within RoofKIT.Workshop_Examples.SecondWorkshop_Files_OM;
model SolarHPSystemRadiant
  "Example for a heat pump system with a solar collector as heat source, a heat storage and a radiant slab"
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;

  package Medium_sin = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Water;
  Buildings.Fluid.Sources.Boundary_pT preSou(
    redeclare package Medium = Medium_sou,
    T=313.15,                                                                                nPorts=1)   "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(transformation(extent={{-100,134},{-80,154}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (
    Placement(transformation(extent = {{148, 50}, {168, 70}}), iconTransformation(extent = {{148, 50}, {168, 70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT_a1(
    redeclare final package Medium = Medium_sou,                                               final m_flow_nominal = 1, final transferHeat = true, final allowFlowReversal = true) "Temperature at sink inlet" annotation (
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, origin = {-132, 110})));
  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(f_WRG = 0.5, U_win = 1.3, U_opaque = 0.2, A_win = {30.54, 31.54, 39.46, 31.46}, A_opaque = 963, A_f = 640, V_room = 2176, win_frame = {0.2, 0.2, 0.2, 0.2}, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, Hysterese_Irradiance = 50, C_mass = 165000 * 640, latitude = 0.015882496193148) annotation (
    Placement(transformation(extent = {{106, 114}, {126, 134}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation (
    Placement(transformation(extent = {{182, 134}, {162, 154}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation (
    Placement(transformation(extent = {{-50, 126}, {-30, 146}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation (
    Placement(transformation(extent = {{22, 108}, {42, 128}})));
  Buildings.Fluid.Sources.Boundary_pT sou_water(T(displayUnit = "K") = 273.15 + 10, redeclare
      package Medium =                                                                                      Medium_sou, nPorts = 1) annotation (
    Placement(transformation(extent = {{184, -114}, {164, -94}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Inlet_T(redeclare package
      Medium =                                                                     Medium_sou, m_flow_nominal = 1.5) annotation (
    Placement(transformation(extent = {{80, -114}, {60, -94}})));
  Buildings.Fluid.FixedResistances.PressureDrop pipeSC(
    redeclare package Medium = Medium_sou,
    m_flow_nominal=1.5,
    dp_nominal=100) annotation (Placement(transformation(
        extent={{42,70},{62,50}},
        rotation=270,
        origin={-62,-22})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Medium_sou, m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(transformation(extent = {{114, -114}, {94, -94}})));
  Modelica.Blocks.Sources.Constant mflow_pump(k = 1.5) annotation (
    Placement(transformation(extent = {{134, -84}, {114, -64}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Return_T(redeclare package
      Medium =                                                                      Medium_sou, m_flow_nominal = 1.5) annotation (
    Placement(transformation(extent = {{-92, 136}, {-112, 116}}, rotation = 270, origin = {-128, -218})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(redeclare
      package Medium =                                                                           Medium_sin, riseTime = 30, m_flow_nominal = 1.5, dpValve_nominal = 100, dpFixed_nominal = {10, 10}) annotation (
    Placement(transformation(extent = {{150, -114}, {130, -94}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (
    Placement(transformation(extent = {{-28, -160}, {-8, -140}})));
  Buildings.Fluid.Sources.Boundary_pT sink_water(T(displayUnit = "K") = 273.15 + 10, redeclare
      package Medium =                                                                                       Medium_sou, nPorts = 1) annotation (
    Placement(transformation(extent = {{184, -144}, {164, -124}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(redeclare
      package Medium =                                                                           Medium_sin, riseTime = 30, m_flow_nominal = 1.5, dpValve_nominal = 100, dpFixed_nominal = {10, 10}) annotation (
    Placement(transformation(extent = {{150, -124}, {130, -144}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature storageRoomTemp(T = 288.15) annotation (
    Placement(transformation(extent = {{-172, -14}, {-152, 6}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium = Medium_sou, m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(transformation(extent = {{-92, 120}, {-112, 100}})));
  Buildings.Controls.Continuous.LimPID conPI(Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.2, yMax = 5, yMin = 0) annotation (
    Placement(visible = true, transformation(origin = {-134, 54}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetP(k = 273.15 + 40) annotation (
    Placement(visible = true, transformation(extent = {{-88, 44}, {-108, 64}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT preSou1(redeclare package Medium = Medium_sin, T = 313.15, nPorts = 1) "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(transformation(extent = {{100, 36}, {80, 56}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(
    redeclare package Medium = Medium_sin,                                                 m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(transformation(extent = {{64, 36}, {44, 56}})));
  Modelica.Blocks.Sources.Constant mflow_pump1(k = 1.2) annotation (
    Placement(transformation(extent={{-4,46},{16,66}})));
  Modelica.Blocks.Logical.Hysteresis hysSollCircuit(
    pre_y_start=true,
    uLow=273.15 + 6,
    uHigh=273.15 + 10)
    annotation (Placement(transformation(extent={{-32,-124},{-50,-106}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{9,-9},{-9,9}},
        origin={-61,-139},
        rotation=180)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage storage(
    redeclare package Medium = Medium_sin,
    redeclare package Medium_HX_1 = Medium_sin,
    redeclare package Medium_HX_2 = Medium_sou,
    height=1.5,
    V=3.1,
    nEle=5,
    HX_1=false,
    Ele_HX_2=4)
    annotation (Placement(transformation(extent={{-120,-16},{-86,14}})));
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
          d=2400)})                                                                                                                                                                                                         "Material layers from surface a to b (8cm concrete, 5 cm insulation, 20 cm reinforced concrete)" annotation (
    Placement(transformation(extent={{-186,62},{-166,82}})));
  parameter Buildings.Fluid.Data.Pipes.PEX_RADTEST pipe "Pipe material"
    annotation (Placement(transformation(extent={{-186,36},{-166,56}})));
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
    annotation (Placement(transformation(extent={{-156,120},{-176,100}})));

  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(
    redeclare package Medium1 = Medium_sin,
    redeclare package Medium2 = Medium_sou,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T1_start=281.4,
    per=perHP) "Water to Water heat pump"
    annotation (Placement(transformation(extent={{24,-32},{76,18}})));
  parameter
    Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240 perHP
    "Reverse heat pump performance data"
    annotation (Placement(transformation(extent={{160,32},{180,52}})));
  Modelica.Blocks.Sources.IntegerConstant integerMode(k=1)   annotation (
    Placement(transformation(extent={{-54,-30},{-40,-16}})));
  Components.Solar.Thermal.ThermalCollector
                                          thermalCollector(
    redeclare package Medium = Medium_sou,
    A_coll=60,
    T_start(displayUnit="K") = 273.15 + 20,
    dp_nominal(displayUnit="Pa") = 50,
    m_flow_nominal=1.5,
    volSol=1.5)                                                                                                                                                                                                   annotation (
    Placement(transformation(extent = {{48, -114}, {28, -94}})));
  Modelica.Blocks.Sources.Constant TSetP1(k = 273.15 + 45) annotation (
    Placement(visible = true, transformation(origin = {-28, 16}, extent = {{-10, -10}, {10, 10}},       rotation = 0)));
equation
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (
    Line(points = {{162, 144}, {116, 144}, {116, 134}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation (
    Line(points = {{105.2, 120.8}, {81.6, 120.8}, {81.6, 136}, {-29, 136}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation (
    Line(points = {{105.2, 117.6}, {86, 117.6}, {86, 118}, {43, 118}}, color = {0, 0, 127}));
  connect(weaBus, weaDat1.weaBus) annotation (
    Line(points = {{158, 60}, {158, 90}, {162, 90}, {162, 144}}, color = {255, 204, 51}, thickness = 0.5),
    Text(string = "%first", index = -1, extent = {{-3, -6}, {-3, -6}}, horizontalAlignment = TextAlignment.Right));
  connect(mflow_pump.y, fan.m_flow_in) annotation (
    Line(points = {{113, -74}, {104, -74}, {104, -92}}, color = {0, 0, 127}));
  connect(solTh_Inlet_T.port_a, fan.port_b) annotation (
    Line(points = {{80, -104}, {94, -104}}, color = {0, 127, 255}));
  connect(pipeSC.port_b, solTh_Return_T.port_b)
    annotation (Line(points={{-2,-84},{-2,-106}}, color={0,127,255}));
  connect(val1.port_2, fan.port_a) annotation (
    Line(points = {{130, -104}, {114, -104}}, color = {0, 127, 255}));
  connect(sou_water.ports[1], val1.port_1) annotation (
    Line(points = {{164, -104}, {150, -104}}, color = {0, 127, 255}));
  connect(booleanToReal.y, val1.y) annotation (
    Line(points = {{-7, -150}, {192, -150}, {192, -78}, {140, -78}, {140, -92}}, color = {0, 0, 127}));
  connect(val2.port_2, solTh_Return_T.port_a) annotation (
    Line(points = {{130, -134}, {-2, -134}, {-2, -126}}, color = {0, 127, 255}));
  connect(val2.port_3, val1.port_3) annotation (
    Line(points = {{140, -124}, {140, -114}}, color = {0, 127, 255}));
  connect(val2.port_1, sink_water.ports[1]) annotation (
    Line(points = {{150, -134}, {164, -134}}, color = {0, 127, 255}));
  connect(val2.y, val1.y) annotation (
    Line(points = {{140, -146}, {140, -150}, {192, -150}, {192, -78}, {140, -78}, {140, -92}}, color = {0, 0, 127}));
  connect(fan1.port_b, senT_a1.port_a) annotation (
    Line(points = {{-112, 110}, {-122, 110}}, color = {0, 127, 255}));
  connect(conPI.u_s, TSetP.y) annotation (
    Line(points = {{-122, 54}, {-109, 54}}, color = {0, 0, 127}));
  connect(senT_a1.T, conPI.u_m) annotation (
    Line(points = {{-132, 99}, {-132, 72}, {-134, 72}, {-134, 66}}, color = {0, 0, 127}));
  connect(conPI.y, fan1.m_flow_in) annotation (
    Line(points = {{-145, 54}, {-152, 54}, {-152, 76}, {-102, 76}, {-102, 98}}, color = {0, 0, 127}));
  connect(preSou.ports[1], fan1.port_a) annotation (
    Line(points={{-80,144},{-72,144},{-72,110},{-92,110}},          color = {0, 127, 255}));
  connect(mflow_pump1.y, fan2.m_flow_in) annotation (
    Line(points={{17,56},{32,56},{32,64},{54,64},{54,58}},          color = {0, 0, 127}));
  connect(preSou1.ports[1], fan2.port_a) annotation (
    Line(points = {{80, 46}, {72, 46}, {72, 46}, {64, 46}}, color = {0, 127, 255}));
  connect(hysSollCircuit.u, solTh_Return_T.T) annotation (Line(points={{-30.2,
          -115},{-20.1,-115},{-20.1,-116},{-13,-116}}, color={0,0,127}));
  connect(hysSollCircuit.y, not2.u) annotation (Line(points={{-50.9,-115},{
          -64,-115},{-64,-116},{-78,-116},{-78,-139},{-71.8,-139}}, color={
          255,0,255}));
  connect(not2.y, booleanToReal.u) annotation (Line(points={{-51.1,-139},{
          -42.55,-139},{-42.55,-150},{-30,-150}}, color={255,0,255}));
  connect(fan2.port_b, storage.port_a2) annotation (Line(points={{44,46},{32,
          46},{32,34},{-52,34},{-52,12.5},{-91.1,12.5}}, color={0,127,255}));
  connect(fan1.port_a, storage.port_HX_2_b) annotation (Line(points={{-92,110},
          {-72,110},{-72,3.5},{-91.1,3.5}}, color={0,127,255}));
  connect(slab.port_a, senT_a1.port_b)
    annotation (Line(points={{-156,110},{-142,110}}, color={0,127,255}));
  connect(slab.port_b, storage.port_HX_2_a) annotation (Line(points={{-176,
          110},{-182,110},{-182,108},{-184,108},{-184,92},{-158,92},{-158,22},
          {-80,22},{-80,6.5},{-91.1,6.5}}, color={0,127,255}));
  connect(slab.surf_a, Gebaeude_modell.port_surf) annotation (Line(points={{
          -170,100},{-170,94},{98,94},{98,126},{106,126},{106,128}}, color={
          191,0,0}));
  connect(storage.heatPort, storageRoomTemp.port) annotation (Line(points={{
          -103,14.6},{-140,14.6},{-140,-4},{-152,-4}}, color={191,0,0}));
  connect(integerMode.y, heaPum.uMod) annotation (Line(points={{-39.3,-23},{
          -24,-23},{-24,-7},{21.4,-7}}, color={255,127,0}));
  connect(heaPum.port_b2, pipeSC.port_a) annotation (Line(points={{24,-22},{
          24,-44},{-2,-44},{-2,-64}}, color={0,127,255}));
  connect(heaPum.port_b1, fan2.port_a) annotation (Line(points={{76,8},{82,8},
          {82,6},{90,6},{90,30},{72,30},{72,46},{64,46}}, color={0,127,255}));
  connect(heaPum.port_a1, storage.port_b2) annotation (Line(points={{24,8},{
          18,8},{18,-2},{-30,-2},{-30,-8},{-78,-8},{-78,-14.5},{-91.1,-14.5}},
        color={0,127,255}));
  connect(thermalCollector.port_a, solTh_Inlet_T.port_b)
    annotation (Line(points={{48,-104},{60,-104}}, color={0,127,255}));
  connect(heaPum.port_a2, thermalCollector.port_b) annotation (Line(points={{
          76,-22},{98,-22},{98,-52},{18,-52},{18,-104},{28,-104}}, color={0,
          127,255}));
  connect(thermalCollector.WeaBusWeaPar, weaBus) annotation (Line(
      points={{44.4,-94},{44,-94},{44,-54},{108,-54},{108,26},{140,26},{140,
          60},{158,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
connect(heaPum.TSet, TSetP1.y) annotation (
    Line(points={{20.36,15.5},{1,15.5},{1,16},{-17,16}},
                                         color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -170}, {200, 170}}), graphics={  Rectangle(origin = {67, 120}, fillColor = {170, 170, 127},
            fillPattern =                                                                                                                                                            FillPattern.Solid, extent = {{-127, 42}, {127, -42}}), Text(origin = {33, 150}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin={68,
              15},                                                                                                                                                                                                        fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
              128,-59},{-128,59}}),                                                                                                                                                                                                        Text(origin = {155, -16}, extent = {{-39, 34}, {39, -34}}, textString = "Wärmepumpe
      "),
        Rectangle(origin = {52, -105}, fillColor = {213, 255, 170},
            fillPattern =                                                         FillPattern.Solid, extent = {{144, -57}, {-144, 57}}), Text(origin = {-49, -84}, extent = {{-39, 34}, {39, -34}}, textString = "Solarkollektoren
60 m²
Wärmequelle WP
      "),
        Rectangle(origin = {-131, -9}, fillColor = {170, 213, 255},
            fillPattern =                                                         FillPattern.Solid, extent = {{65, -35}, {-65, 35}}), Text(origin = {-154, -33}, extent = {{-36, 15}, {36, -15}}, textString = "Wärmespeicher"), Rectangle(origin = {-129, 96}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{65, -66}, {-65, 66}}), Text(origin = {-154, 147}, extent = {{-36, 15}, {36, -15}}, textString = "Fussbodenheizung
Vorlauftemp 40°C")}),
    experiment(StopTime = 604800, Interval = 3600, Tolerance = 1e-06, __Dymola_Algorithm = "Dassl"),
    Documentation(info = "<html><p>
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
        revisions = "<html><ul>
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
    Icon(coordinateSystem(extent = {{-200, -170}, {200, 170}}, preserveAspectRatio = false), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                              FillPattern.Solid, extent = {{-120, -120}, {120, 120}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-38, 64}, {68, -2}, {-38, -64}, {-38, 64}})}));
end SolarHPSystemRadiant;
