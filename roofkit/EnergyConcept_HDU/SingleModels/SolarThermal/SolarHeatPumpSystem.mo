within RoofKIT.EnergyConcept_HDU.SingleModels.SolarThermal;
model SolarHeatPumpSystem "Example for a heat pump system and solar thermal collector at the source side, with the ISO 13790 building model"
  import Modelica.Constants.*;

  package Medium_sin = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Water;
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare
      package                                                                    Medium = Medium_sin, Q_flow_nominal = 20000, TAir_nominal = 293.15, TRad_nominal(displayUnit = "K") = 293.15, T_a_nominal(displayUnit = "K") = 313.15, T_b_nominal(displayUnit = "K") = 308.15, T_start = 313.15, dp_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 20000 / 4180 / 5) "Radiator" annotation (
    Placement(transformation(extent = {{-14, 56}, {-34, 76}})));
  Buildings.Fluid.Sources.Boundary_pT preSou(redeclare package Medium = Medium_sin, nPorts = 1, T = 313.15) "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(transformation(extent = {{-102, 56}, {-82, 76}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT_a1(redeclare final package Medium = Medium_sin, final m_flow_nominal = 1.8, final transferHeat = true, final allowFlowReversal = true) "Temperature at sink inlet" annotation (
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 270, origin = {30, 50})));
  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(f_WRG = 0.5, U_win = 1.3, U_opaque = 0.2, A_win = {30.54, 31.54, 39.46, 31.46}, A_opaque = 963, A_f = 640, V_room = 2176, win_frame = {0.2, 0.2, 0.2, 0.2}, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, Hysterese_Irradiance = 50, C_mass = 165000 * 640, latitude = 0.015882496193148) annotation (
    Placement(transformation(extent = {{28, 116}, {48, 136}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation (
    Placement(transformation(extent = {{116, 134}, {96, 154}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation (
    Placement(transformation(extent = {{-116, 122}, {-96, 142}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation (
    Placement(transformation(extent = {{-58, 98}, {-38, 118}})));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_sin, redeclare
      package                                                                                                      Medium2 = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, T1_start = 281.4, per = perHP) "Water to Water heat pump" annotation (
    Placement(transformation(extent = {{-50, -34}, {2, 16}})));
  Modelica.Blocks.Sources.IntegerConstant integerMode(k = 1) annotation (
    Placement(visible = true, transformation(extent = {{-112, -30}, {-86, -4}}, rotation = 0)));
  parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240 perHP "Reverse heat pump performance data" annotation (
    Placement(transformation(extent = {{80, 58}, {100, 78}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumHeaPum(redeclare replaceable
      package                                                                          Medium = Medium_sin, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 1.8, m_flow_start = 1.8, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation (
    Placement(visible = true, transformation(origin = {30, 22}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant mflowHP(k = 1) annotation (
    Placement(visible = true, transformation(extent = {{102, 12}, {82, 32}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetHP(k = 273.15 + 40) annotation (
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT sou_water(T(displayUnit = "K") = 273.15 + 10, redeclare
      package                                                                                         Medium = Medium_sou, nPorts = 1) annotation (
    Placement(transformation(extent = {{142, -116}, {122, -96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Inlet_T(redeclare package Medium = Medium_sou, m_flow_nominal = 1) annotation (
    Placement(transformation(extent = {{38, -116}, {18, -96}})));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare
      package Medium = Medium_sou, A_coll = 60, T_start(displayUnit = "K") = 273.15 + 20, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 1, volSol = 1.5) annotation (
    Placement(visible = true, transformation(origin = {-8, -106}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Fluid.FixedResistances.PressureDrop pipeSC(redeclare package Medium = Medium_sou, m_flow_nominal = 1, dp_nominal = 50) annotation (
    Placement(transformation(extent = {{42, 70}, {62, 50}}, rotation = 270, origin = {-114, -26})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Medium_sou, m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(transformation(extent = {{72, -116}, {52, -96}})));
  Modelica.Blocks.Sources.Constant mflow_pump(k = 1.2) annotation (
    Placement(transformation(extent = {{92, -86}, {72, -66}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Return_T(redeclare package Medium = Medium_sou, m_flow_nominal = 1) annotation (
    Placement(transformation(extent = {{-92, 136}, {-112, 116}}, rotation = 270, origin = {-180, -218})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(redeclare
      package                                                                           Medium = Medium_sou, riseTime = 30, m_flow_nominal = 1, dpValve_nominal = 50, dpFixed_nominal = {5, 5}) annotation (
    Placement(transformation(extent = {{108, -116}, {88, -96}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (
    Placement(transformation(extent = {{-88, -160}, {-68, -140}})));
  Buildings.Fluid.Sources.Boundary_pT sink_water(T(displayUnit = "K") = 273.15 + 10, redeclare
      package                                                                                          Medium = Medium_sou, nPorts = 1) annotation (
    Placement(transformation(extent = {{142, -146}, {122, -126}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(redeclare
      package                                                                           Medium = Medium_sou, riseTime = 30, m_flow_nominal = 1, dpValve_nominal = 50, dpFixed_nominal = {5, 5}) annotation (
    Placement(transformation(extent = {{108, -126}, {88, -146}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (
    Placement(transformation(extent = {{84, 98}, {104, 118}}), iconTransformation(extent = {{84, 98}, {104, 118}})));
  Modelica.Blocks.Logical.Hysteresis hysSollCircuit(pre_y_start = true, uLow = 273.15 + 6, uHigh = 273.15 + 10) annotation (
    Placement(transformation(extent = {{-86, -124}, {-104, -106}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis" annotation (
    Placement(transformation(extent = {{9, -9}, {-9, 9}}, origin = {-121, -139}, rotation = 180)));
  Modelica.Blocks.Continuous.Integrator energy_HP(k = 1) annotation(
    Placement(visible = true, transformation(extent = {{34, -28}, {54, -8}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_kWh energy_sim_kWh annotation(
    Placement(visible = true, transformation(extent = {{72, -28}, {92, -8}}, rotation = 0)));
equation
  connect(senT_a1.port_b, rad.port_a) annotation (
    Line(points = {{30, 60}, {30, 66}, {-14, 66}}, color = {0, 127, 255}));
  connect(rad.port_b, preSou.ports[1]) annotation (
    Line(points = {{-34, 66}, {-82, 66}}, color = {0, 127, 255}));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (
    Line(points = {{96, 144}, {38, 144}, {38, 136}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation (
    Line(points = {{27.2, 122.8}, {15.6, 122.8}, {15.6, 132}, {-95, 132}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation (
    Line(points = {{27.2, 119.6}, {20, 119.6}, {20, 108}, {-37, 108}}, color = {0, 0, 127}));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation (
    Line(points = {{-26, 73.2}, {-26, 100}, {28, 100}, {28, 130}}, color = {191, 0, 0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation (
    Line(points = {{-22, 73.2}, {-22, 96}, {20, 96}, {20, 134}, {28, 134}}, color = {191, 0, 0}));
//  experiment(StopTime=31536000, Interval=3600, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
  connect(integerMode.y, heaPum.uMod) annotation (
    Line(points={{-84.7,-17},{-68.8,-17},{-68.8,-9},{-52.6,-9}},        color = {255, 127, 0}));
  connect(senT_a1.port_a, pumHeaPum.port_b) annotation (
    Line(points = {{30, 40}, {30, 32}}, color = {0, 127, 255}));
  connect(pumHeaPum.port_a, heaPum.port_b1) annotation (
    Line(points = {{30, 12}, {30, 6}, {2, 6}}, color = {0, 127, 255}));
  connect(heaPum.port_a1, rad.port_b) annotation (
    Line(points = {{-50, 6}, {-70, 6}, {-70, 66}, {-34, 66}}, color = {0, 127, 255}));
  connect(heaPum.TSet, TSetHP.y) annotation (
    Line(points = {{-53.64, 13.5}, {-62, 13.5}, {-62, 30}, {-89, 30}}, color = {0, 0, 127}));
  connect(mflowHP.y, pumHeaPum.m_flow_in) annotation (
    Line(points = {{81, 22}, {42, 22}}, color = {0, 0, 127}));
  connect(mflow_pump.y, fan.m_flow_in) annotation (
    Line(points = {{71, -76}, {62, -76}, {62, -94}}, color = {0, 0, 127}));
  connect(solTh_Inlet_T.port_a, fan.port_b) annotation (
    Line(points = {{38, -106}, {52, -106}}, color = {0, 127, 255}));
  connect(pipeSC.port_b, solTh_Return_T.port_b) annotation (
    Line(points = {{-54, -88}, {-54, -106}}, color = {0, 127, 255}));
  connect(val1.port_2, fan.port_a) annotation (
    Line(points = {{88, -106}, {72, -106}}, color = {0, 127, 255}));
  connect(sou_water.ports[1], val1.port_1) annotation (
    Line(points = {{122, -106}, {108, -106}}, color = {0, 127, 255}));
  connect(booleanToReal.y, val1.y) annotation (
    Line(points = {{-67, -150}, {150, -150}, {150, -80}, {98, -80}, {98, -94}}, color = {0, 0, 127}));
  connect(val2.port_2, solTh_Return_T.port_a) annotation (
    Line(points = {{88, -136}, {-54, -136}, {-54, -126}}, color = {0, 127, 255}));
  connect(val2.port_3, val1.port_3) annotation (
    Line(points = {{98, -126}, {98, -116}}, color = {0, 127, 255}));
  connect(val2.port_1, sink_water.ports[1]) annotation (
    Line(points = {{108, -136}, {122, -136}}, color = {0, 127, 255}));
  connect(val2.y, val1.y) annotation (
    Line(points = {{98, -148}, {98, -150}, {150, -150}, {150, -80}, {98, -80}, {98, -94}}, color = {0, 0, 127}));
  connect(weaDat1.weaBus, weaBus) annotation (
    Line(points = {{96, 144}, {94, 144}, {94, 108}}, color = {255, 204, 51}, thickness = 0.5),
    Text(string = "%second", index = 1, extent = {{-6, 3}, {-6, 3}}, horizontalAlignment = TextAlignment.Right));
  connect(pipeSC.port_a, heaPum.port_b2) annotation (
    Line(points = {{-54, -68}, {-54, -46}, {-54, -24}, {-50, -24}}, color = {0, 127, 255}));
  connect(thermalCollector.WeaBusWeaPar, weaBus) annotation (
    Line(points = {{-1.6, -96}, {-1.6, -58}, {142, -58}, {142, 108}, {94, 108}}, color = {255, 204, 51}, thickness = 0.5));
  connect(solTh_Inlet_T.port_b, thermalCollector.port_a) annotation (
    Line(points = {{18, -106}, {2, -106}}, color = {0, 127, 255}));
  connect(heaPum.port_a2, thermalCollector.port_b) annotation (
    Line(points = {{2, -24}, {18, -24}, {18, -68}, {-28, -68}, {-28, -106}, {-18, -106}}, color = {0, 127, 255}));
  connect(hysSollCircuit.y, not2.u) annotation (
    Line(points = {{-104.9, -115}, {-122, -115}, {-122, -116}, {-140, -116}, {-140, -139}, {-131.8, -139}}, color = {255, 0, 255}));
  connect(hysSollCircuit.u, solTh_Return_T.T) annotation (
    Line(points = {{-84.2, -115}, {-74.1, -115}, {-74.1, -116}, {-65, -116}}, color = {0, 0, 127}));
  connect(not2.y, booleanToReal.u) annotation (
    Line(points = {{-111.1, -139}, {-100.55, -139}, {-100.55, -150}, {-90, -150}}, color = {255, 0, 255}));
  connect(heaPum.P, energy_HP.u) annotation(
    Line(points = {{4, -10}, {32, -10}, {32, -18}}, color = {0, 0, 127}));
  connect(energy_HP.y, energy_sim_kWh.u) annotation(
    Line(points = {{56, -18}, {70, -18}}, color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -170}, {160, 170}}), graphics={  Rectangle(origin = {-2, 124}, fillColor = {170, 170, 127},
            fillPattern =                                                                                                                                                            FillPattern.Solid, extent = {{-126, 38}, {126, -38}}), Text(origin = {-27, 148}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin = {2, 15}, fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{130, -69}, {-130, 69}}), Text(origin = {83, -40}, extent = {{-39, 34}, {39, -34}}, textString = "Wärmepumpe"), Rectangle(origin = {2, -109}, fillColor = {213, 255, 170},
            fillPattern =                                                                     FillPattern.Solid, extent = {{152, -53}, {-152, 53}}), Text(origin = {-107, -80}, extent = {{-39, 34}, {39, -34}}, textString = "Solarkollektoren
60 m²
Wärmequelle WP
      ")}),
    experiment(StopTime = 7776000, Interval = 3600, Tolerance = 1e-06, __Dymola_Algorithm = "Dassl"),
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
</html>", revisions = "<html><ul>
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
    Icon(coordinateSystem(extent = {{-160, -170}, {160, 170}}, preserveAspectRatio = false), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                              FillPattern.Solid, extent = {{-120, -120}, {120, 120}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-38, 64}, {68, -2}, {-38, -64}, {-38, 64}})}));
end SolarHeatPumpSystem;
