within RoofKIT.EnergyConcept_GG.WholeConcept.SubModels;

model Thermal_System
  //
  //  Media
  package Medium_Water = Buildings.Media.Water;
  package Medium_Brine = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.50, property_T = 283.15);
  package Medium_Air = Buildings.Media.Air;
  //  TRANSYS
  //
  Modelica.Blocks.Sources.CombiTimeTable FirstFloor(fileName = "C:\Users\Moritz\Documents\01_RED\RoofKIT\RoofKIT\Inputs\FirstFloor.txt", table = [0, 0, 0], tableName = "FirstFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-187, -47}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable SecondFloor(fileName = "C:\Users\Moritz\Documents\01_RED\RoofKIT\RoofKIT\Inputs\SecondFloor.txt", table = [0, 0, 0], tableName = "SecondFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-187, -11}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable ThirdFloor(fileName = "C:\Users\Moritz\Documents\01_RED\RoofKIT\RoofKIT\Inputs\ThirdFloor.txt", table = [0, 0, 0], tableName = "ThirdFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-187, 33}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  //  Umrechnung
  Modelica.Blocks.Sources.RealExpression FF_Temp(y = FirstFloor.y[1] + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-153, -45}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  //
  //  WeatherData
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 WeatherData(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {-197, 134}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  //
  //  Zones
  Modelica.Fluid.Sources.Boundary_pT FirstSecond(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-186, -29}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
  //
  //  Ventilation 1st + 2nd Floor
  Buildings.Fluid.Sources.MassFlowSource_T Vent_SUP(redeclare package Medium = Buildings.Media.Air, m_flow = 0.1, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-21, -45}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex_down(redeclare package Medium1 = Medium_Air, redeclare package Medium2 = Medium_Air, show_T = true, m1_flow_nominal = 5, m2_flow_nominal = 5, dp1_nominal = 500, dp2_nominal = 10) annotation(
    Placement(visible = true, transformation(origin = {-50, -49}, extent = {{14, -7}, {-14, 7}}, rotation = 0)));
  Buildings.Fluid.Sources.MassFlowSource_T Vent_RET(redeclare package Medium = Medium_Air, m_flow = 0.3, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-83, -53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT lower(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {2, -54}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  //
  //  Heatpump Exhaust Air
  Buildings.Fluid.HeatPumps.EquationFitReversible AW_Heatpump(redeclare package Medium1 = Medium_Water, redeclare package Medium2 = Medium_Air, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per_AW) annotation(
    Placement(visible = true, transformation(origin = {-14, -95}, extent = {{14, 11}, {-14, -11}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_AW1(redeclare replaceable package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {36, -102}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Medium_Water, T = 20 + 273.15, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {25, -87}, extent = {{3, -3}, {-3, 3}}, rotation = 180)));
  parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240 per_AW annotation(
    Placement(visible = true, transformation(origin = {-181, -69}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  //
  //  Storage Tank
  BuildingSystems.Technologies.ThermalStorages.FluidStorage WaterTank(redeclare package Medium = Medium_Water, redeclare package Medium_HX_1 = Medium_Brine, redeclare package Medium_HX_2 = Medium_Brine, Ele_HX_1 = 1, HX_1 = true, HX_2 = false, UA_HX_1 = 1000, V = 3, height = 3, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {73, -50}, extent = {{-15, -16}, {15, 16}}, rotation = 0)));
  //
  //  Solar Thermal
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_Brine, A_coll = 1.62 * 14, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 0.00154 * 14) annotation(
    Placement(visible = true, transformation(origin = {48, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT test2(redeclare package Medium = Medium_Brine, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {13, 83}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort ST_T_IN(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {29, 94}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort ST_T_OUT(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {70, 94}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort BW_T_OUT(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {0, -10}, extent = {{6, -4}, {-6, 4}}, rotation = -90)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort AW_T_OUT(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {14, -102}, extent = {{6, -4}, {-6, 4}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear st_ZeroFlow1(redeclare package Medium = Medium_Brine, dpValve_nominal = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {1, 94}, extent = {{-5, -8}, {5, 8}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear st_ZeroFlow2(redeclare package Medium = Medium_Brine, dpValve_nominal = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 0.3, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {87, 94}, extent = {{-5, -8}, {5, 8}}, rotation = 0)));
  Buildings.Fluid.Sensors.MassFlowRate ST_massflow(redeclare package Medium = Medium_Brine) annotation(
    Placement(visible = true, transformation(origin = {-29, 94}, extent = {{-7, -4}, {7, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_ST(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {14, 94}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_SUP(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {120, -36}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_RET(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {120, -64}, extent = {{6, -4}, {-6, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT RoomHeating_IN(redeclare package Medium = Medium_Water, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {161, -38}, extent = {{11, -4}, {-11, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT RoomHeating_OUT(redeclare package Medium = Medium_Water, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {161, -64}, extent = {{11, -4}, {-11, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant c_SUP(k = 10) annotation(
    Placement(visible = true, transformation(origin = {134, -16}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {156, -20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort T_SUP(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {139, -36}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_BW(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {16, -18}, extent = {{6, -4}, {-6, 4}}, rotation = 0)));

//  Exhaust Air 3rd floor
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex_up(redeclare package Medium1 = Medium_Brine, redeclare package Medium2 = Medium_Air, dp1_nominal = 500, dp2_nominal = 10, m1_flow_nominal = 5, m2_flow_nominal = 5, show_T = true) annotation(
    Placement(visible = true, transformation(origin = {-42, 28}, extent = {{9, -7}, {-9, 7}}, rotation = -90)));
  Buildings.Fluid.Movers.FlowControlled_m_flow vent_thrid(redeclare package Medium = Medium_Air, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-84, 38}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Third_source(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-104, 37}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT Third_sink(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-104, 19}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression TF_Temp(y = ThirdFloor.y[1] + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-153, 39}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Brine_IN(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-27, 14}, extent = {{5, -4}, {-5, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Brine_OUT(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-37, 48}, extent = {{6, -5}, {-6, 5}}, rotation = -90)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Air_IN(redeclare package Medium = Medium_Air, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-62, 38}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Air_Out(redeclare package Medium = Medium_Air, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-62, 18}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 0.1)  annotation(
    Placement(visible = true, transformation(origin = {-106, 58}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression third_on_off(y = - Ex_Brine_IN.T + TF_Temp.y) annotation(
    Placement(visible = true, transformation(origin = {-187, 59}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal b2r1 annotation(
    Placement(visible = true, transformation(origin = {-131, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold compare annotation(
    Placement(visible = true, transformation(origin = {-149, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(redeclare package Medium = Medium_Brine, dpValve_nominal = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-37, 64}, extent = {{-5, -8}, {5, 8}}, rotation = 90)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(redeclare package Medium = Medium_Brine, dpValve_nominal = 1, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {111, 64}, extent = {{5, 8}, {-5, -8}}, rotation = 90)));
    Buildings.Fluid.HeatPumps.EquationFitReversible BW_Heatpump(redeclare package Medium1 = Medium_Water, redeclare package Medium2 = Medium_Brine, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per_WW) annotation(
    Placement(visible = true, transformation(origin = {24, 7}, extent = {{-14, 11}, {14, -11}}, rotation = 0)));
 //////////////////////////////////////////////////////
  //
  Modelica.Blocks.Sources.RealExpression realExpression(y = (FirstFloor.y[2] + SecondFloor.y[2] + ThirdFloor.y[2]) / 4200 / 10) annotation(
    Placement(visible = true, transformation(origin = {199, 3}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant st_dir_setpoint(k = 60 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {157, 115}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Blocks.Logical.Hysteresis st_dir_hyst(uHigh = 2, uLow = 0)  annotation(
    Placement(visible = true, transformation(origin = {199, 149}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = (-WaterTank.T[1]) +ST_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {249, 149}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal b2r annotation(
    Placement(visible = true, transformation(origin = {157, 149}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 parameter RoofKIT.Database.HeatPump.WATERKOTTE_EcoTouch_Ai per_WW annotation(
    Placement(visible = true, transformation(origin = {-188, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
 Modelica.Blocks.Sources.BooleanConstant Switch_BW(k = false)  annotation(
    Placement(visible = true, transformation(origin = {243, 73}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
 Modelica.Blocks.Sources.BooleanConstant Switch_AW(k = false)  annotation(
    Placement(visible = true, transformation(origin = {244, -94}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
 Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {175, 149}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {199, 137}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
 Modelica.Blocks.Math.BooleanToInteger b2i annotation(
    Placement(visible = true, transformation(origin = {200, 32}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
 Modelica.Blocks.Math.BooleanToInteger b2i1 annotation(
    Placement(visible = true, transformation(origin = {209, -95}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Math.Gain gain1(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {116, -112}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
 Modelica.Blocks.Math.BooleanToReal b2r2 annotation(
    Placement(visible = true, transformation(origin = {209, -113}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {115, 125}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Sources.Constant m_flow_BW(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {157, 135}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
 Modelica.Blocks.Math.BooleanToReal b2r3 annotation(
    Placement(visible = true, transformation(origin = {159, 73}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {115, 159}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
 Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {157, 169}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
 Modelica.Blocks.Math.Gain gain2(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {64, -12}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
 Modelica.Blocks.Sources.RealExpression realExpression2(y = 2000 / 0.3 / 4200 + BW_T_OUT.T ) annotation(
    Placement(visible = true, transformation(origin = {-67, -3}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
 Modelica.Blocks.Sources.RealExpression realExpression3(y = 2000 / 0.3 / 4200 + AW_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {231, -129}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
 Buildings.Controls.Continuous.LimPID st_PID(controllerType = Modelica.Blocks.Types.SimpleController.PD, reverseActing = false, strict = true, yMax = 2, yMin = 0.01) annotation(
    Placement(visible = true, transformation(origin = {139, 115}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
equation
  connect(hex_down.port_b1, FirstSecond.ports[1]) annotation(
    Line(points = {{-64, -44.8}, {-70, -44.8}, {-70, -28.6}, {-180, -28.6}}, color = {0, 127, 255}));
  connect(Vent_RET.ports[1], hex_down.port_a2) annotation(
    Line(points = {{-76, -53}, {-64, -53}}, color = {0, 127, 255}));
  connect(FF_Temp.y, Vent_RET.T_in) annotation(
    Line(points = {{-129.9, -45}, {-117.8, -45}, {-117.8, -50}, {-91.8, -50}}, color = {0, 0, 127}));
  connect(hex_down.port_b2, AW_Heatpump.port_a2) annotation(
    Line(points = {{-36, -53.2}, {-32, -53.2}, {-32, -87.4}, {-28, -87.4}}, color = {0, 127, 255}));
  connect(AW_Heatpump.port_b2, lower.ports[1]) annotation(
    Line(points = {{1.77636e-15, -88.4}, {10, -88.4}, {10, -54.4}, {6, -54.4}}, color = {0, 127, 255}));
  connect(RoomHeating_OUT.ports[1], pump_RET.port_a) annotation(
    Line(points = {{150, -64}, {126, -64}}, color = {0, 127, 255}));
  connect(pump_SUP.port_b, T_SUP.port_a) annotation(
    Line(points = {{126, -36}, {132, -36}}, color = {0, 127, 255}));
  connect(T_SUP.port_b, RoomHeating_IN.ports[1]) annotation(
    Line(points = {{146, -36}, {146, -38}, {150, -38}}, color = {0, 127, 255}));
  connect(T_SUP.T, add1.u2) annotation(
    Line(points = {{139, -29.4}, {139, -24.4}, {148, -24.4}}, color = {0, 0, 127}));
  connect(c_SUP.y, add1.u1) annotation(
    Line(points = {{138.4, -16}, {148.4, -16}}, color = {0, 0, 127}));
  connect(add1.y, RoomHeating_OUT.T_in) annotation(
    Line(points = {{162.6, -20}, {192.6, -20}, {192.6, -62}, {174, -62}}, color = {0, 0, 127}));
  connect(WeatherData.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{-190, 134}, {35, 134}, {35, 92}}, color = {255, 204, 51}, pattern = LinePattern.None, thickness = 0.5));
  connect(ST_T_IN.port_b, thermalCollector.port_a) annotation(
    Line(points = {{36, 94}, {38, 94}}, color = {0, 127, 255}));
  connect(thermalCollector.port_b, ST_T_OUT.port_a) annotation(
    Line(points = {{58, 94}, {60, 94}}, color = {0, 127, 255}));
  connect(ST_T_OUT.port_b, st_ZeroFlow2.port_1) annotation(
    Line(points = {{80, 94}, {82, 94}}, color = {0, 127, 255}));
  connect(st_ZeroFlow1.port_3, st_ZeroFlow2.port_3) annotation(
    Line(points = {{1, 86}, {1, 76}, {87, 76}, {87, 86}}, color = {0, 127, 255}));
  connect(ST_massflow.port_b, st_ZeroFlow1.port_1) annotation(
    Line(points = {{-22, 94}, {-4, 94}}, color = {0, 127, 255}));
  connect(st_ZeroFlow1.port_2, pump_ST.port_a) annotation(
    Line(points = {{6, 94}, {8, 94}}, color = {0, 127, 255}));
  connect(pump_ST.port_b, ST_T_IN.port_a) annotation(
    Line(points = {{20, 94}, {22, 94}}, color = {0, 127, 255}));
  connect(realExpression1.y, st_dir_hyst.u) annotation(
    Line(points = {{225.9, 149}, {204.9, 149}}, color = {0, 0, 127}));
  connect(Third_source.ports[1], vent_thrid.port_a) annotation(
    Line(points = {{-98, 37}, {-98, 38}, {-90, 38}}, color = {0, 127, 255}));
  connect(TF_Temp.y, Third_source.T_in) annotation(
    Line(points = {{-129.9, 39}, {-120.9, 39}, {-120.9, 40}, {-111.9, 40}}, color = {0, 0, 127}));
  connect(hex_up.port_b1, Ex_Brine_OUT.port_a) annotation(
    Line(points = {{-37.8, 37}, {-36.8, 37}, {-36.8, 42}}, color = {0, 127, 255}));
  connect(hex_up.port_a1, Ex_Brine_IN.port_b) annotation(
    Line(points = {{-37.8, 19}, {-37.8, 14}, {-32, 14}}, color = {0, 127, 255}));
  connect(vent_thrid.port_b, Ex_Air_IN.port_a) annotation(
    Line(points = {{-78, 38}, {-72, 38}}, color = {0, 127, 255}));
  connect(Ex_Air_IN.port_b, hex_up.port_a2) annotation(
    Line(points = {{-52, 38}, {-46, 38}}, color = {0, 127, 255}));
  connect(hex_up.port_b2, Ex_Air_Out.port_b) annotation(
    Line(points = {{-46.2, 19}, {-46.2, 17}, {-52.2, 17}}, color = {0, 127, 255}));
  connect(Third_sink.ports[1], Ex_Air_Out.port_a) annotation(
    Line(points = {{-98, 19}, {-72, 19}, {-72, 18}}, color = {0, 127, 255}));
  connect(gain.y, vent_thrid.m_flow_in) annotation(
    Line(points = {{-99.4, 58}, {-84.4, 58}, {-84.4, 42}}, color = {0, 0, 127}));
  connect(third_on_off.y, compare.u) annotation(
    Line(points = {{-163.9, 59}, {-154.9, 59}}, color = {0, 0, 127}));
  connect(compare.y, b2r1.u) annotation(
    Line(points = {{-143.5, 59}, {-137, 59}}, color = {255, 0, 255}));
  connect(b2r1.y, gain.u) annotation(
    Line(points = {{-125.5, 59}, {-113, 59}, {-113, 58}}, color = {0, 0, 127}));
  connect(val1.port_2, ST_massflow.port_a) annotation(
    Line(points = {{-37, 69}, {-37, 76}, {-36, 76}, {-36, 94}}, color = {0, 127, 255}));
  connect(val1.port_3, WaterTank.port_HX_1_a) annotation(
    Line(points = {{-29, 64}, {88, 64}, {88, -56}, {83.5, -56}}, color = {0, 127, 255}));
  connect(st_ZeroFlow2.port_2, val2.port_1) annotation(
    Line(points = {{92, 94}, {111, 94}, {111, 69}}, color = {0, 127, 255}));
  connect(val2.port_3, WaterTank.port_HX_1_b) annotation(
    Line(points = {{103, 64}, {96, 64}, {96, -60}, {83.5, -60}}, color = {0, 127, 255}));
  connect(val1.port_1, Ex_Brine_OUT.port_b) annotation(
    Line(points = {{-37, 59}, {-37, 54}}, color = {0, 127, 255}));
  connect(realExpression.y, pump_RET.m_flow_in) annotation(
    Line(points = {{175.9, 3}, {119.9, 3}, {119.9, -59}}, color = {0, 0, 127}));
  connect(realExpression.y, pump_SUP.m_flow_in) annotation(
    Line(points = {{175.9, 3}, {119.8, 3}, {119.8, -33}}, color = {0, 0, 127}));
  connect(Ex_Brine_IN.port_a, BW_Heatpump.port_b2) annotation(
    Line(points = {{-22, 14}, {10, 14}}, color = {0, 127, 255}));
  connect(BW_Heatpump.port_a2, val2.port_2) annotation(
    Line(points = {{38, 13.6}, {112, 13.6}, {112, 59.6}}, color = {0, 127, 255}));
  connect(pump_AW1.port_a, WaterTank.port_a1) annotation(
    Line(points = {{42, -102}, {54, -102}, {54, -64}, {62.5, -64}}, color = {0, 127, 255}));
  connect(WaterTank.port_a2, pump_SUP.port_a) annotation(
    Line(points = {{83.5, -36}, {98.5, -36}, {98.5, -35.2}, {113.5, -35.2}}, color = {0, 127, 255}));
  connect(WaterTank.port_b2, pump_RET.port_b) annotation(
    Line(points = {{83.5, -64}, {98.5, -64}, {98.5, -64.8}, {113.5, -64.8}}, color = {0, 127, 255}));
  connect(bou1.ports[1], pump_AW1.port_a) annotation(
    Line(points = {{28, -87}, {42, -87}, {42, -102}}, color = {0, 127, 255}));
  connect(hex_down.port_a1, Vent_SUP.ports[1]) annotation(
    Line(points = {{-36, -44.8}, {-28, -44.8}}, color = {0, 127, 255}));
  connect(Vent_SUP.T_in, WeatherData.weaBus.TDryBul) annotation(
    Line(points = {{-12.6, -42.2}, {-5.6, -42.2}, {-5.6, 133.8}, {-189.6, 133.8}}, color = {0, 0, 127}));
  connect(st_dir_hyst.y, and1.u1) annotation(
    Line(points = {{193.5, 149}, {181, 149}}, color = {255, 0, 255}));
  connect(and1.u2, not1.y) annotation(
    Line(points = {{181, 145}, {186, 145}, {186, 137}, {193.5, 137}}, color = {255, 0, 255}));
  connect(Switch_BW.y, not1.u) annotation(
    Line(points = {{233.1, 73}, {222.2, 73}, {222.2, 137}, {205.1, 137}}, color = {255, 0, 255}));
  connect(Switch_BW.y, b2i.u) annotation(
    Line(points = {{233.1, 73}, {222.7, 73}, {222.7, 32}, {207.2, 32}}, color = {255, 0, 255}));
  connect(b2i.y, BW_Heatpump.uMod) annotation(
    Line(points = {{193.4, 32}, {2.40025, 32}, {2.40025, 8}, {8.40025, 8}}, color = {255, 127, 0}));
  connect(b2i1.u, Switch_AW.y) annotation(
    Line(points = {{215, -95}, {223, -95}, {223, -94}, {234, -94}}, color = {255, 0, 255}));
  connect(AW_Heatpump.uMod, b2i1.y) annotation(
    Line(points = {{1.4, -95}, {202.9, -95}, {202.9, -96}}, color = {255, 127, 0}));
  connect(pump_AW1.m_flow_in, gain1.y) annotation(
    Line(points = {{36, -109}, {36, -112}, {109, -112}}, color = {0, 0, 127}));
  connect(Switch_AW.y, b2r2.u) annotation(
    Line(points = {{233, -94}, {225, -94}, {225, -113}, {214, -113}}, color = {255, 0, 255}));
  connect(b2r2.y, gain1.u) annotation(
    Line(points = {{203.5, -113}, {164, -113}, {164, -112}, {123, -112}}, color = {0, 0, 127}));
  connect(switch1.y, pump_ST.m_flow_in) annotation(
    Line(points = {{109.5, 125}, {14, 125}, {14, 98}}, color = {0, 0, 127}));
  connect(m_flow_BW.y, switch1.u1) annotation(
    Line(points = {{151.5, 135}, {125.5, 135}, {125.5, 129}, {121, 129}}, color = {0, 0, 127}));
  connect(switch1.u2, Switch_BW.y) annotation(
    Line(points = {{121, 125}, {222, 125}, {222, 73}, {233, 73}}, color = {255, 0, 255}));
  connect(val2.y, b2r3.y) annotation(
    Line(points = {{120.6, 64}, {130.6, 64}, {130.6, 73}, {153.5, 73}}, color = {0, 0, 127}));
  connect(b2r3.y, val1.y) annotation(
    Line(points = {{153.5, 73}, {-60, 73}, {-60, 64}, {-46, 64}}, color = {0, 0, 127}));
  connect(Switch_BW.y, b2r3.u) annotation(
    Line(points = {{233.1, 73}, {165.1, 73}}, color = {255, 0, 255}));
  connect(switch2.u3, b2r.y) annotation(
    Line(points = {{121, 155}, {137, 155}, {137, 149}, {151.5, 149}}, color = {0, 0, 127}));
  connect(b2r.u, and1.y) annotation(
    Line(points = {{163, 149}, {169.5, 149}}, color = {255, 0, 255}));
  connect(Switch_BW.y, switch2.u2) annotation(
    Line(points = {{233.1, 73}, {222.1, 73}, {222.1, 159}, {121.1, 159}}, color = {255, 0, 255}));
  connect(switch2.y, st_ZeroFlow2.y) annotation(
    Line(points = {{109.5, 159}, {87, 159}, {87, 104}}, color = {0, 0, 127}));
  connect(switch2.y, st_ZeroFlow1.y) annotation(
    Line(points = {{109.5, 159}, {1, 159}, {1, 104}}, color = {0, 0, 127}));
  connect(const.y, switch2.u1) annotation(
    Line(points = {{151.5, 169}, {136, 169}, {136, 163}, {121, 163}}, color = {0, 0, 127}));
  connect(WaterTank.port_a1, pump_BW.port_a) annotation(
    Line(points = {{62.5, -64}, {28, -64}, {28, -18.4}, {22, -18.4}}, color = {0, 127, 255}));
  connect(gain2.y, pump_BW.m_flow_in) annotation(
    Line(points = {{57.4, -12}, {15.4, -12}, {15.4, -14}}, color = {0, 0, 127}));
  connect(b2r3.y, gain2.u) annotation(
    Line(points = {{153.5, 73}, {80, 73}, {80, -12}, {72, -12}}, color = {0, 0, 127}));
  connect(realExpression2.y, BW_Heatpump.TSet) annotation(
    Line(points = {{-43.9, -3}, {-13.9, -3}, {-13.9, -2}, {8.1, -2}}, color = {0, 0, 127}));
  connect(AW_Heatpump.TSet, realExpression3.y) annotation(
    Line(points = {{1.96, -104.9}, {17.96, -104.9}, {17.96, -129}, {208, -129}}, color = {0, 0, 127}));
  connect(BW_Heatpump.port_b1, WaterTank.port_b1) annotation(
    Line(points = {{38, 0}, {44, 0}, {44, -36}, {62, -36}}, color = {0, 127, 255}));
  connect(pump_BW.port_b, BW_T_OUT.port_a) annotation(
    Line(points = {{10, -18}, {0, -18}, {0, -16}}, color = {0, 127, 255}));
  connect(BW_T_OUT.port_b, BW_Heatpump.port_a1) annotation(
    Line(points = {{0, -4}, {0, 0}, {10, 0}}, color = {0, 127, 255}));
  connect(AW_Heatpump.port_b1, WaterTank.port_b1) annotation(
    Line(points = {{-28, -102}, {-36, -102}, {-36, -116}, {44, -116}, {44, -36}, {62, -36}}, color = {0, 127, 255}));
  connect(AW_Heatpump.port_a1, AW_T_OUT.port_b) annotation(
    Line(points = {{0, -102}, {8, -102}}, color = {0, 127, 255}));
  connect(AW_T_OUT.port_a, pump_AW1.port_b) annotation(
    Line(points = {{20, -102}, {30, -102}}, color = {0, 127, 255}));
  connect(st_PID.y, switch1.u3) annotation(
    Line(points = {{133.5, 115}, {125.25, 115}, {125.25, 121}, {121, 121}}, color = {0, 0, 127}));
  connect(ST_T_OUT.T, st_PID.u_m) annotation(
    Line(points = {{70, 98.4}, {70, 106.8}, {139, 106.8}, {139, 109}}, color = {0, 0, 127}));
  connect(st_dir_setpoint.y, st_PID.u_s) annotation(
    Line(points = {{151.5, 115}, {145, 115}}, color = {0, 0, 127}));
 connect(test2.ports[1], pump_ST.port_a) annotation(
    Line(points = {{16, 84}, {8, 84}, {8, 94}}, color = {0, 127, 255}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {-42, -44}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-56, 18}, {56, -18}})}, coordinateSystem(extent = {{-150, -150}, {150, 150}})),
    experiment(StartTime = 8.7264e+06, StopTime = 8.8128e+06, Tolerance = 1e-06, Interval = 3600),
 Icon(coordinateSystem(extent = {{-150, -150}, {150, 150}})));
end Thermal_System;
