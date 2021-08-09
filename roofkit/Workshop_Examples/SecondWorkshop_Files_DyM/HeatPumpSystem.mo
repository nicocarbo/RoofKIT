within RoofKIT.Workshop_Examples.SecondWorkshop_Files_DyM;
model HeatPumpSystem
  "Example for a heat pump system with the ISO 13790 building model"
  import Modelica.Constants.*;
  package Medium_sin = AixLib.Media.Water;
  package Medium_sou = AixLib.Media.Water;
  AixLib.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal(displayUnit="degC") = 323.15,
    dp_nominal=0,
    m_flow_nominal=20000/4180/5,
    Q_flow_nominal=20000,
    redeclare package Medium = Medium_sin,
    T_start=313.15,
    T_b_nominal=318.15,
    TAir_nominal=293.15,
    TRad_nominal=293.15) "Radiator"
    annotation (Placement(transformation(extent={{10,-32},{-10,-12}})));

  AixLib.Fluid.Sources.Boundary_pT preSou(
    redeclare package Medium = Medium_sin,
    nPorts=1,
    T=313.15)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{-78,-32},{-58,-12}})));

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
        AixLib.Controls.SetPoints.Functions.HeatingCurveFunction (TDesign=
            328.15),
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
    annotation (Placement(transformation(extent={{-20,-124},{34,-64}})));

  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
    annotation (Placement(transformation(extent={{74,-6},{94,14}}),
        iconTransformation(extent={{74,-6},{94,14}})));
  AixLib.Fluid.Sources.Boundary_pT sou(
    use_T_in=false,
    T=283.15,
    nPorts=1,
    redeclare package Medium = Medium_sou)
              "Fluid source on source side"
    annotation (Placement(transformation(extent={{72,-134},{52,-114}})));

  AixLib.Fluid.Sources.Boundary_pT sin(
    nPorts=1,
    redeclare package Medium = Medium_sou,
    T=278.15) "Fluid sink on source side"
    annotation (Placement(transformation(extent={{-78,-134},{-58,-114}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort
                             senT_a1(
    redeclare final package Medium = Medium_sin,
    final m_flow_nominal=1,
    final transferHeat=true,
    final allowFlowReversal=true)
                                "Temperature at sink inlet" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={58,-50})));
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
    annotation (Placement(transformation(extent={{52,88},{72,108}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{140,120},{120,140}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k=1088)
    annotation (Placement(transformation(extent={{-92,96},{-72,116}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(
    amplitude=650,
    width=50,
    period=86400,
    offset=650)
    annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
equation
  connect(sou.ports[1], heatPumpSystem.port_a2)
    annotation (Line(points={{52,-124},{34,-124},{34,-115.429}},
                                                          color={0,127,255}));
  connect(sin.ports[1], heatPumpSystem.port_b2) annotation (Line(points={{-58,
          -124},{-16,-124},{-16,-115.429},{-20,-115.429}},
                                       color={0,127,255}));
  connect(weaBus.TDryBul, heatPumpSystem.T_oda) annotation (Line(
      points={{84,4},{-88,4},{-88,-77.0714},{-24.05,-77.0714}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(senT_a1.port_a, heatPumpSystem.port_b1) annotation (Line(points={{58,-60},
          {58,-89.7143},{34,-89.7143}},      color={0,127,255}));
  connect(senT_a1.port_b, rad.port_a) annotation (Line(points={{58,-40},{58,-22},
          {10,-22}},        color={0,127,255}));
  connect(senT_a1.T, heatPumpSystem.TAct) annotation (Line(points={{47,-50},{
          -32,-50},{-32,-68},{-24.05,-68},{-24.05,-68.0714}},
                                                     color={0,0,127}));
  connect(rad.port_b, heatPumpSystem.port_a1) annotation (Line(points={{-10,-22},
          {-42,-22},{-42,-89.7143},{-20,-89.7143}},
                                                 color={0,127,255}));
  connect(rad.port_b, preSou.ports[1])
    annotation (Line(points={{-10,-22},{-58,-22}},
                                                color={0,127,255}));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (Line(
      points={{120,130},{62,130},{62,108}},
      color={255,204,51},
      thickness=0.5));
  connect(Gebaeude_modell.Vdot_vent,Vdot_vent. y) annotation (Line(points={{51.2,
          94.8},{39.6,94.8},{39.6,106},{-71,106}},  color={0,0,127}));
  connect(Gebaeude_modell.Qdot_int,Qdot_int. y) annotation (Line(points={{51.2,91.6},
          {44,91.6},{44,72},{-69,72}},          color={0,0,127}));
  connect(weaBus, weaDat1.weaBus) annotation (Line(
      points={{84,4},{84,60},{120,60},{120,130}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation (Line(points={{-2,
          -14.8},{-2,44},{52,44},{52,102}},    color={191,0,0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation (Line(points={{2,-14.8},
          {2,52},{48,52},{48,106},{52,106}},         color={191,0,0}));

  //  experiment(StopTime=31536000, Interval=3600, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -160},{160,160}}), graphics={                                      Rectangle(origin={22,
              90},                                                                                           fillColor = {170, 170, 127},
            fillPattern =                                                                                                                               FillPattern.Solid, extent={{
              -126,66},{126,-66}}),                                                                                                                                                                            Text(origin={
              -13,136},                                                                                                                                                                                                        extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin={26,
              -64},                                                                                                                                                                                                        fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
              130,-80},{-130,80}}),                                                                                                                                                                                                        Text(origin={
              115,-102},                                                                                                                                                                                                        extent={{
              -39,34},{39,-34}},
          textString="Wärmepumpe
Heizkörper
Vorlauftemp 40°C
",        lineColor={0,0,0})}),
    experiment(StopTime=7776000, Interval=3600, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
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
    Icon(coordinateSystem(extent={{-160,-160},{160,160}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-120,-120},{120,120}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-38,64},{68,-2},{-38,-64},{-38,64}})}));
end HeatPumpSystem;
