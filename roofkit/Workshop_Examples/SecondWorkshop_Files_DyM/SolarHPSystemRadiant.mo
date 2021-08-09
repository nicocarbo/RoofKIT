within RoofKIT.Workshop_Examples.SecondWorkshop_Files_DyM;
model SolarHPSystemRadiant
  "Example for a heat pump system with a solar collector as heat source, a heat storage and a radiant slab"
  extends Modelica.Icons.Example;

  import Modelica.Constants.*;
  package Medium_sin = AixLib.Media.Water;
  package Medium_sou = AixLib.Media.Water;

  AixLib.Fluid.Sources.Boundary_pT preSou(
    redeclare package Medium = Medium_sin,
    T=313.15,
    nPorts=1)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{-100,136},{-80,156}})));

  AixLib.Systems.HeatPumpSystems.HeatPumpSystem heatPumpSystem(
    redeclare package Medium_con = Medium_sin,
    redeclare package Medium_eva = Medium_sou,
    dataTable=AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(),
    use_deFro=false,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    refIneFre_constant=0.01,
    dpEva_nominal=0,
    deltaM_con=0.1,
    use_opeEnvFroRec=true,
    tableUpp=[-100,100; 100,100],
    minIceFac=0,
    use_chiller=true,
    calcPel_deFro=100,
    minRunTime(displayUnit="min"),
    minLocTime(displayUnit="min"),
    use_antLeg=false,
    use_refIne=true,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    minTimeAntLeg(displayUnit="min") = 900,
    scalingFactor=1,
    use_tableData=false,
    dpCon_nominal=0,
    use_conCap=true,
    CCon=3000,
    use_evaCap=true,
    CEva=3000,
    Q_flow_nominal=5000,
    cpEva=4180,
    cpCon=4180,
    use_secHeaGen=false,
    redeclare model TSetToNSet = AixLib.Controls.HeatPump.BaseClasses.OnOffHP (
          hys=5),
    use_sec=true,
    QCon_nominal=10000,
    P_el_nominal=2500,
    redeclare model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        dataTable=
            AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113(
            tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833;
            45,4833,4917,4958,5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,
            7125,7250,7417,7583]),
        printAsserts=false,
        extrapolation=false),
    redeclare function HeatingCurveFunction =
        AixLib.Controls.SetPoints.Functions.HeatingCurveFunction (TDesign=343.15),
    use_minRunTime=true,
    use_minLocTime=true,
    use_runPerHou=true,
    pre_n_start=true,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 perEva,
    redeclare AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 perCon,
    TCon_nominal=313.15,
    TCon_start=313.15,
    TEva_start=283.15,
    use_revHP=false,
    VCon=0.004,
    VEva=0.004)
    annotation (Placement(transformation(extent={{14,-40},{68,20}})));

  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{148,50},{168,70}}),
        iconTransformation(extent={{148,50},{168,70}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senT_a1(
    redeclare final package Medium = Medium_sin,
    final m_flow_nominal=1,
    final transferHeat=true,
    final allowFlowReversal=true) "Temperature at sink inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        origin={-132,118})));

  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(
    f_WRG=0.5,
    U_win=1.3,
    U_opaque=0.2,
    A_win={30.54,31.54,39.46,31.46},
    A_opaque=963,
    A_f=640,
    V_room=2176,
    win_frame={0.2,0.2,0.2,0.2},
    surfaceAzimut={pi,-pi/2,0,pi/2},
    Hysterese_Irradiance=50,
    C_mass=165000*640,
    latitude=0.015882496193148)
    annotation (Placement(transformation(extent={{106,114},{126,134}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{182,134},{162,154}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k=1088)
    annotation (Placement(transformation(extent={{-50,126},{-30,146}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(
    amplitude=650,
    width=50,
    period=86400,
    offset=650)
    annotation (Placement(transformation(extent={{22,108},{42,128}})));
  AixLib.Fluid.Sources.Boundary_pT sou_water(
    T(displayUnit="K") = 273.15 + 10,
    redeclare package Medium = Medium_sou,
    nPorts=1)
    annotation (Placement(transformation(extent={{184,-114},{164,-94}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort solTh_Inlet_T(redeclare package
      Medium = Medium_sou, m_flow_nominal=1.5)
    annotation (Placement(transformation(extent={{80,-114},{60,-94}})));
  AixLib.Fluid.Solar.Thermal.SolarThermal solarThermal(
    A=60,
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    volPip=1.5,
    T_start(displayUnit="K") = 273.15 + 20,
    Collector=AixLib.DataBase.SolarThermal.FlatCollector())
    annotation (Placement(transformation(extent={{48,-114},{28,-94}})));
  AixLib.Fluid.FixedResistances.PressureDrop pipedp(
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    dp_nominal=100) annotation (Placement(transformation(
        extent={{42,70},{62,50}},
        rotation=270,
        origin={-62,-22})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    addPowerToMedium=false,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{114,-114},{94,-94}})));
  Modelica.Blocks.Sources.Constant mflow_pump(k=1.5)
    annotation (Placement(transformation(extent={{134,-84},{114,-64}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort solTh_Return_T(redeclare package
      Medium = Medium_sou, m_flow_nominal=1.5) annotation (Placement(
        transformation(
        extent={{-92,136},{-112,116}},
        rotation=270,
        origin={-128,-218})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(
    redeclare package Medium = Medium_sin,
    riseTime=30,
    m_flow_nominal=1.5,
    dpValve_nominal=100,
    dpFixed_nominal={10,10})
    annotation (Placement(transformation(extent={{150,-114},{130,-94}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=280.15)
    annotation (Placement(transformation(extent={{-26,-126},{-46,-106}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-28,-160},{-8,-140}})));
  AixLib.Fluid.Sources.Boundary_pT sink_water(
    T(displayUnit="K") = 273.15 + 10,
    redeclare package Medium = Medium_sou,
    nPorts=1)
    annotation (Placement(transformation(extent={{184,-144},{164,-124}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(
    redeclare package Medium = Medium_sin,
    riseTime=30,
    m_flow_nominal=1.5,
    dpValve_nominal=100,
    dpFixed_nominal={10,10})
    annotation (Placement(transformation(extent={{150,-124},{130,-144}})));
  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=1.5,
    m2_flow_nominal=1.5,
    mHC1_flow_nominal=1.5,
    n=5,
    redeclare package Medium = Medium_sou,
    data=AixLib.DataBase.Storage.Generic_New_2000l(),
    useHeatingCoil1=true,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    redeclare package MediumHC1 = Medium_sou,
    redeclare package MediumHC2 = Medium_sou,
    TStart=303.15) annotation (Placement(transformation(extent={{-108,-18},{
            -128,6}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature storageRoomTemp(T=288.15)
    annotation (Placement(transformation(extent={{-172,-14},{-152,6}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    addPowerToMedium=false,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{-92,128},{-112,108}})));
  Buildings.Controls.Continuous.LimPID conPI(
    Ti=10,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.2,
    yMax=10,
    yMin=0)                                                                                                                                       annotation (
    Placement(visible = true, transformation(origin={-122,54},     extent={{10,10},
            {-10,-10}},                                                                             rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetP(k=273.15 + 35)   annotation (
    Placement(visible = true, transformation(extent={{-80,44},{-100,64}},       rotation = 0)));
  AixLib.Fluid.Sources.Boundary_pT preSou1(
    redeclare package Medium = Medium_sin,
    T=313.15,
    nPorts=1)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{100,36},{80,56}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    addPowerToMedium=false,
    dp_nominal=100)
    annotation (Placement(transformation(extent={{64,36},{44,56}})));
  Modelica.Blocks.Sources.Constant mflow_pump1(k=1.5)
    annotation (Placement(transformation(extent={{-28,40},{-8,60}})));
  Buildings.Fluid.HeatExchangers.RadiantSlabs.SingleCircuitSlab slab(
    m_flow_nominal=5,
    redeclare package Medium = Medium_sou,
    layers=layers,
    iLayPip=1,
    pipe=pipe,
    sysTyp=Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Floor,
    disPip=0.25,
    A=500,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    from_dp=true) "Slab with embedded pipes"
    annotation (Placement(transformation(extent={{-160,128},{-180,108}})));
  parameter Buildings.Fluid.Data.Pipes.PEX_RADTEST pipe "Pipe material"
    annotation (Placement(transformation(extent={{-178,40},{-158,60}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic layers(nLay=3,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.08,
        k=1.13,
        c=1000,
        d=1400,
        nSta=5),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.05,
        k=0.04,
        c=1400,
        d=10),Buildings.HeatTransfer.Data.Solids.Generic(
        x=0.2,
        k=1.8,
        c=1100,
        d=2400)})
    "Material layers from surface a to b (8cm concrete, 5 cm insulation, 20 cm reinforced concrete)"
    annotation (Placement(transformation(extent={{-178,66},{-158,86}})));
equation
  connect(weaBus.TDryBul, heatPumpSystem.T_oda) annotation (Line(
      points={{158,60},{106,60},{106,68},{-34,68},{-34,6.92857},{9.95,6.92857}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (Line(
      points={{162,144},{116,144},{116,134}},
      color={255,204,51},
      thickness=0.5));
  connect(Gebaeude_modell.Vdot_vent,Vdot_vent. y) annotation (Line(points={{105.2,
          120.8},{81.6,120.8},{81.6,136},{-29,136}},color={0,0,127}));
  connect(Gebaeude_modell.Qdot_int,Qdot_int. y) annotation (Line(points={{105.2,
          117.6},{86,117.6},{86,118},{43,118}}, color={0,0,127}));
  connect(weaBus, weaDat1.weaBus) annotation (Line(
      points={{158,60},{158,90},{162,90},{162,144}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(solTh_Inlet_T.port_b, solarThermal.port_a)
    annotation (Line(points={{60,-104},{48,-104}}, color={0,127,255}));
  connect(mflow_pump.y, fan.m_flow_in)
    annotation (Line(points={{113,-74},{104,-74},{104,-92}},color={0,0,127}));
  connect(solTh_Inlet_T.port_a, fan.port_b)
    annotation (Line(points={{80,-104},{94,-104}}, color={0,127,255}));
  connect(pipedp.port_a, heatPumpSystem.port_b2) annotation (Line(points={{-2,
          -64},{-2,-32},{14,-32},{14,-31.4286}}, color={0,127,255}));
  connect(solarThermal.T_air, weaBus.TDryBul) annotation (Line(points={{44,-94},
          {44,-70},{42,-70},{42,-46},{110,-46},{110,56},{158,56},{158,60}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.HGloHor, solarThermal.Irradiation) annotation (Line(
      points={{158,60},{106,60},{106,-44},{38,-44},{38,-94}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(solarThermal.port_b, heatPumpSystem.port_a2) annotation (Line(points={{28,-104},
          {18,-104},{18,-42},{68,-42},{68,-31.4286}},           color={0,127,255}));
  connect(pipedp.port_b, solTh_Return_T.port_b)
    annotation (Line(points={{-2,-84},{-2,-106}}, color={0,127,255}));
  connect(val1.port_2, fan.port_a)
    annotation (Line(points={{130,-104},{114,-104}},
                                                 color={0,127,255}));
  connect(sou_water.ports[1], val1.port_1)
    annotation (Line(points={{164,-104},{150,-104}},
                                                   color={0,127,255}));
  connect(lessThreshold.u, solTh_Return_T.T)
    annotation (Line(points={{-24,-116},{-13,-116}},color={0,0,127}));
  connect(booleanToReal.u, lessThreshold.y) annotation (Line(points={{-30,-150},
          {-54,-150},{-54,-116},{-47,-116}},  color={255,0,255}));
  connect(booleanToReal.y, val1.y) annotation (Line(points={{-7,-150},{192,-150},
          {192,-78},{140,-78},{140,-92}},
                                        color={0,0,127}));
  connect(val2.port_2, solTh_Return_T.port_a) annotation (Line(points={{130,-134},
          {-2,-134},{-2,-126}},  color={0,127,255}));
  connect(val2.port_3, val1.port_3)
    annotation (Line(points={{140,-124},{140,-114}},
                                                   color={0,127,255}));
  connect(val2.port_1, sink_water.ports[1])
    annotation (Line(points={{150,-134},{164,-134}}, color={0,127,255}));
  connect(val2.y, val1.y) annotation (Line(points={{140,-146},{140,-150},{192,-150},
          {192,-78},{140,-78},{140,-92}},
                                        color={0,0,127}));
  connect(storageRoomTemp.port, bufferStorage.heatportOutside) annotation (Line(
        points={{-152,-4},{-150,-4},{-150,-5.28},{-127.75,-5.28}}, color={191,0,
          0}));
  connect(bufferStorage.TTop, heatPumpSystem.TAct) annotation (Line(points={{-108,
          4.56},{-50,4.56},{-50,15.9286},{9.95,15.9286}},   color={0,0,127}));
  connect(fan1.port_b, senT_a1.port_a)
    annotation (Line(points={{-112,118},{-122,118}}, color={0,127,255}));
  connect(bufferStorage.portHC1Out, fan1.port_a) annotation (Line(points={{
          -107.875,-2.88},{-76,-2.88},{-76,118},{-92,118}}, color={0,127,255}));
  connect(conPI.u_s, TSetP.y)
    annotation (Line(points={{-110,54},{-101,54}}, color={0,0,127}));
  connect(senT_a1.T, conPI.u_m) annotation (Line(points={{-132,107},{-132,66},{
          -122,66}}, color={0,0,127}));
  connect(conPI.y, fan1.m_flow_in) annotation (Line(points={{-133,54},{-140,54},
          {-140,76},{-102,76},{-102,106}}, color={0,0,127}));
  connect(preSou.ports[1], fan1.port_a) annotation (Line(points={{-80,146},{-72,
          146},{-72,118},{-92,118}}, color={0,127,255}));
  connect(mflow_pump1.y, fan2.m_flow_in) annotation (Line(points={{-7,50},{8,50},
          {8,62},{54,62},{54,58}}, color={0,0,127}));
  connect(preSou1.ports[1], fan2.port_a) annotation (Line(points={{80,46},{72,
          46},{72,46},{64,46}}, color={0,127,255}));
  connect(fan2.port_a, heatPumpSystem.port_b1) annotation (Line(points={{64,46},
          {72,46},{72,28},{78,28},{78,-5.71429},{68,-5.71429}}, color={0,127,
          255}));
  connect(bufferStorage.fluidportTop1, fan2.port_b) annotation (Line(points={{
          -114.5,6.12},{-114.5,12},{-56,12},{-56,30},{18,30},{18,46},{44,46}},
        color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, heatPumpSystem.port_a1) annotation (
      Line(points={{-114.625,-18.24},{-114.625,-26},{-74,-26},{-74,-5.71429},{
          14,-5.71429}}, color={0,127,255}));
  connect(senT_a1.port_b, slab.port_a)
    annotation (Line(points={{-142,118},{-160,118}}, color={0,127,255}));
  connect(slab.surf_a, Gebaeude_modell.port_surf) annotation (Line(points={{
          -174,108},{-174,96},{94,96},{94,128},{106,128}}, color={191,0,0}));
  connect(slab.port_b, bufferStorage.portHC1In) annotation (Line(points={{-180,
          118},{-188,118},{-188,28},{-96,28},{-96,0.84},{-107.75,0.84}}, color=
          {0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -170},{200,170}}), graphics={                                      Rectangle(origin={67,
              120},                                                                                          fillColor = {170, 170, 127},
            fillPattern =                                                                                                                               FillPattern.Solid, extent={{
              -127,42},{127,-42}}),                                                                                                                                                                            Text(origin={33,
              150},                                                                                                                                                                                                        extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"),              Rectangle(origin={68,
              16},                                                                                                                                                                                                        fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
              128,-56},{-128,56}}),                                                                                                                                                                                                        Text(origin={
              155,-16},                                                                                                                                                                                                        extent={{
              -39,34},{39,-34}},
          lineColor={0,0,0},
          textString="Wärmepumpe
"),                                                                                                                                                                                                      Rectangle(origin={52,
              -105},                                                                                                                                                                                                        extent={{
              144,-57},{-144,57}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),                                                                                                                                                                                                        Text(origin={
              -49,-84},                                                                                                                                                                                                        extent={{
              -39,34},{39,-34}},
          lineColor={0,0,0},
          textString="Solarkollektoren
60 m²
Wärmequelle WP
"),                                                                                                                                                                                                      Rectangle(origin={
              -131,-8},                                                                                                                                                                                                       fillColor=
              {170,213,255},
            fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent={{
              63,-32},{-63,32}},
          lineColor={0,0,0}),                                                                                                                                                                                                        Text(origin={
              -154,-33},                                                                                                                                                                                                        extent={{
              -36,15},{36,-15}},
          lineColor={0,0,0},
          textString="Wärmespeicher"),                                                                                                                                                                                                        Rectangle(origin={
              -129,96},                                                                                                                                                                                                        fillColor=
              {255,213,170},
            fillPattern=FillPattern.Solid,                                                                                                                                                                                                        extent={{
              65,-66},{-65,66}},
          lineColor={0,0,0}),                                                                                                                                                                                                        Text(origin={
              -154,149},                                                                                                                                                                                                        extent={{
              -36,15},{36,-15}},
          lineColor={0,0,0},
          textString="Heizkörper
Vorlauftemp 40°C")}),
    experiment(
      StopTime=604800,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>
  Model for testing the model <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">AixLib.Systems.HeatPumpSystems.HeatPumpSystem</a>.
</p>
<p>
  A simple radiator is used to heat a room. This example is based on
  the example in <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Examples.ScrollWaterToWater_OneRoomRadiator\">
  AixLib.Fluid.HeatPumps.Examples.ScrollWaterToWater_OneRoomRadiator</a>.
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-200,-170},{200,170}}, preserveAspectRatio=false),
                                                           graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-120,-120},{120,120}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-38,64},{68,-2},{-38,-64},{-38,64}})}));
end SolarHPSystemRadiant;
