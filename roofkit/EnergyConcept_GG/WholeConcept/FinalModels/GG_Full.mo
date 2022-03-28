within RoofKIT.EnergyConcept_GG.WholeConcept.FinalModels;

model GG_Full
  extends Modelica.Icons.Example;

  Real heatflow = -HX_U.y * HX_A.y * ((WW_T_in.y - ((WW_T_in.y - WW_tank.T) * 2.71828 * exp(HX_U.y / (WW_mflow.y * 4200)) + WW_tank.T)) / 2 - WW_tank.T);
  Real p_DHW = (FirstFloor.y[3] + SecondFloor.y[3] + ThirdFloor.y[3]) / 3600 * 4200 * (45 - 10);
  Real WW_Ausnutzung = heatflow / p_DHW;
  //
  //  Media
  package Medium_Water = Buildings.Media.Water;
  package Medium_Brine = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.50, property_T = 283.15);
  package Medium_Air = Buildings.Media.Air;
  //  TRANSYS
  //
  Modelica.Blocks.Sources.CombiTimeTable FirstFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/FirstFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "FirstFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-341, 129}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable SecondFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/SecondFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "SecondFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-319, 131}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable ThirdFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/ThirdFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "ThirdFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-299, 129}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  //  Umrechnung
  Modelica.Blocks.Sources.RealExpression FF_Temp(y = (FirstFloor.y[1] + 273.15) * FirstFloor.y[5] / (FirstFloor.y[5] + SecondFloor.y[5]) + (SecondFloor.y[1] + 273.15) * SecondFloor.y[5] / (FirstFloor.y[5] + SecondFloor.y[5])) annotation(
    Placement(visible = true, transformation(origin = {-320, -23}, extent = {{-24, -7}, {24, 7}}, rotation = 0)));
  //
  //  WeatherData
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 WeatherData(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {-367, 128}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  //
  //  Zones
  Modelica.Fluid.Sources.Boundary_pT FirstSecond(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-218, -7}, extent = {{-4, -3}, {4, 3}}, rotation = 0)));
  //
  //  Ventilation 1st + 2nd Floor
  Buildings.Fluid.Sources.MassFlowSource_T Vent_SUP(redeclare package Medium = Buildings.Media.Air, m_flow = 0.1, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-151, -17}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex_down(redeclare package Medium1 = Medium_Air, redeclare package Medium2 = Medium_Air, show_T = true, m1_flow_nominal = 5, m2_flow_nominal = 5, dp1_nominal = 500, dp2_nominal = 10) annotation(
    Placement(visible = true, transformation(origin = {-180, -21}, extent = {{14, -7}, {-14, 7}}, rotation = 0)));
  Buildings.Fluid.Sources.MassFlowSource_T Vent_RET(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-217, -25}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT lower(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-166, -50}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  //
  //  Heatpump Exhaust Air
  Buildings.Fluid.HeatPumps.EquationFitReversible AW_Heatpump(redeclare package Medium1 = Medium_Water, redeclare package Medium2 = Medium_Air, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per_AW) annotation(
    Placement(visible = true, transformation(origin = {-144, -67}, extent = {{-14, 11}, {14, -11}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_AW1(redeclare replaceable package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-94, -86}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Medium_Water, T = 20 + 273.15, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-76, -86}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240 per_AW annotation(
    Placement(visible = true, transformation(origin = {-261, 129}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage WaterTank(redeclare package Medium = Medium_Water, redeclare package Medium_HX_1 = Medium_Water, redeclare package Medium_HX_2 = Medium_Brine, Ele_HX_1 = 1, Ele_HX_2 = 2, HX_1 = true, HX_2 = true, T_start = 51 + 273, UA_HX_1 = 1000, V = 10, height = 3, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-57, -22}, extent = {{-15, -16}, {15, 16}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_Brine, A_coll = 1.62 * 100, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 0.00154 * 100) annotation(
    Placement(visible = true, transformation(origin = {-82, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT test2(redeclare package Medium = Medium_Brine, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {-117, 111}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort ST_T_IN(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-101, 122}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort ST_T_OUT(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-64, 122}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort BW_T_OUT(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-130, 14}, extent = {{6, -4}, {-6, 4}}, rotation = -90)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort AW_T_OUT(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-116, -86}, extent = {{6, -4}, {-6, 4}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear st_ZeroFlow1(redeclare package Medium = Medium_Brine, dpValve_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-129, 122}, extent = {{-5, -8}, {5, 8}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear st_ZeroFlow2(redeclare package Medium = Medium_Brine, dpValve_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 0.3, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-25, 122}, extent = {{-5, -8}, {5, 8}}, rotation = 0)));
  Buildings.Fluid.Sensors.MassFlowRate ST_massflow(redeclare package Medium = Medium_Brine) annotation(
    Placement(visible = true, transformation(origin = {-151, 122}, extent = {{-7, -4}, {7, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_ST(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-116, 122}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_SUP(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, -8}, extent = {{-6, -4}, {6, 4}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_RET(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {1, -36}, extent = {{7, -6}, {-7, 6}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT RoomHeating_IN(redeclare package Medium = Medium_Water, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {31, -8}, extent = {{11, -4}, {-11, 4}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT RoomHeating_OUT(redeclare package Medium = Medium_Water, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {31, -36}, extent = {{11, -4}, {-11, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant c_SUP(k = 10) annotation(
    Placement(visible = true, transformation(origin = {4, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {40, 8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort T_SUP(redeclare package Medium = Medium_Water, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {9, -8}, extent = {{-7, -6}, {7, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_BW(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-114, 0}, extent = {{6, -4}, {-6, 4}}, rotation = 0)));
  //  Exhaust Air 3rd floor
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex_up(redeclare package Medium1 = Medium_Brine, redeclare package Medium2 = Medium_Air, dp1_nominal = 500, dp2_nominal = 10, m1_flow_nominal = 5, m2_flow_nominal = 5, show_T = true) annotation(
    Placement(visible = true, transformation(origin = {-168, 56}, extent = {{9, -7}, {-9, 7}}, rotation = -90)));
  Modelica.Fluid.Sources.Boundary_pT Third_sink(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-208, 47}, extent = {{-6, -5}, {6, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression TF_Temp(y = ThirdFloor.y[1] + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-325, 61}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Brine_IN(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-153, 42}, extent = {{5, -4}, {-5, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Brine_OUT(redeclare package Medium = Medium_Brine, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-163, 76}, extent = {{6, -5}, {-6, 5}}, rotation = -90)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Air_IN(redeclare package Medium = Medium_Air, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-188, 66}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort Ex_Air_Out(redeclare package Medium = Medium_Air, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-188, 46}, extent = {{-10, -4}, {10, 4}}, rotation = 0)));
  BuildingSystems.Fluid.Sensors.TemperatureTwoPort HX_AW_OUT(redeclare package Medium = Medium_Air, m_flow_nominal = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-114, -46}, extent = {{-10, -4}, {10, 4}}, rotation = -90)));
  Modelica.Blocks.Sources.RealExpression third_on_off(y = (-Ex_Brine_IN.T) + TF_Temp.y) annotation(
    Placement(visible = true, transformation(origin = {-325, 71}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal b2r1 annotation(
    Placement(visible = true, transformation(origin = {-253, 71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold compare annotation(
    Placement(visible = true, transformation(origin = {-271, 71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(redeclare package Medium = Medium_Brine, dpValve_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-163, 92}, extent = {{-5, -8}, {5, 8}}, rotation = 90)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(redeclare package Medium = Medium_Brine, dpValve_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, l = {0.005, 0.005}, m_flow_nominal = 2, use_inputFilter = false) annotation(
    Placement(visible = true, transformation(origin = {-19, 92}, extent = {{5, 8}, {-5, -8}}, rotation = 90)));
  Buildings.Fluid.HeatPumps.EquationFitReversible BW_Heatpump(redeclare package Medium1 = Medium_Water, redeclare package Medium2 = Medium_Brine, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per_WW) annotation(
    Placement(visible = true, transformation(origin = {-106, 35}, extent = {{-14, 11}, {14, -11}}, rotation = 0)));
  //////////////////////////////////////////////////////
  //
  Modelica.Blocks.Sources.RealExpression Heating(y = (FirstFloor.y[2] + SecondFloor.y[2] + ThirdFloor.y[2]) / 4200 / c_SUP.y) annotation(
    Placement(visible = true, transformation(origin = {116, 37}, extent = {{38, -9}, {-38, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant st_dir_setpoint(k = 80 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {27, 135}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Blocks.Logical.Hysteresis st_dir_hyst(uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {69, 171}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = (-WaterTank.T[1]) + ST_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {119, 171}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal b2r annotation(
    Placement(visible = true, transformation(origin = {27, 171}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.WATERKOTTE_EcoTouch_Ai per_WW annotation(
    Placement(visible = true, transformation(origin = {-279, 129}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {45, 171}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {69, 157}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger b2i annotation(
    Placement(visible = true, transformation(origin = {70, 60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger b2i1 annotation(
    Placement(visible = true, transformation(origin = {79, -125}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain AW_mflow_load(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {57, -111}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal b2r2 annotation(
    Placement(visible = true, transformation(origin = {79, -111}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-15, 145}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant BW_mflow_load(k = 0.8) annotation(
    Placement(visible = true, transformation(origin = {27, 155}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal b2r3 annotation(
    Placement(visible = true, transformation(origin = {29, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch2 annotation(
    Placement(visible = true, transformation(origin = {-15, 181}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1) annotation(
    Placement(visible = true, transformation(origin = {27, 191}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Blocks.Math.Gain BW_mflow_source(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-66, 16}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y = 40000 / BW_mflow_source.k / 4200 + BW_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {55, 75}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression3(y = 4000 / 0.3 / 4200 + AW_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {63, -97}, extent = {{21, -7}, {-21, 7}}, rotation = 0)));
  Buildings.Controls.Continuous.LimPID st_PID(controllerType = Modelica.Blocks.Types.SimpleController.PD, reverseActing = false, strict = true, yMax = 3, yMin = 0.01) annotation(
    Placement(visible = true, transformation(origin = {9, 135}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(pre_y_start = true, uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {-255, -99}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-237, -99}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = 5) annotation(
    Placement(visible = true, transformation(origin = {-215, -99}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-278, -98}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_ww(redeclare package Medium = Medium_Water, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 0.3, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-194, -134}, extent = {{-8, -6}, {8, 6}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume WW_tank(redeclare package Medium = Medium_Water, T_start = 40 + 273.15, V = 10, m_flow_nominal = 0.1, nPorts = 3) annotation(
    Placement(visible = true, transformation(origin = {-240, -125}, extent = {{-8, -9}, {8, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression t_wwtank(y = WW_tank.T) annotation(
    Placement(visible = true, transformation(origin = {-323, -102}, extent = {{-21, -8}, {21, 8}}, rotation = 0)));
  Modelica.Fluid.Sources.Boundary_pT boundary(redeclare package Medium = Medium_Water, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-215, -124}, extent = {{5, -4}, {-5, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression4(y = heatflow) annotation(
    Placement(visible = true, transformation(origin = {-323, -125}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HX_U(k = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-278, -150}, extent = {{8, -8}, {-8, 8}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant HX_A(k = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-258, -150}, extent = {{8, -8}, {-8, 8}}, rotation = 180)));
  Modelica.Blocks.Sources.RealExpression WW_T_in(y = T_DHW.y - dT_DHW2WW.y) annotation(
    Placement(visible = true, transformation(origin = {-323, -147}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_mflow(y = (FirstFloor.y[3] + SecondFloor.y[3] + ThirdFloor.y[3]) / 3600) annotation(
    Placement(visible = true, transformation(origin = {-323, -159}, extent = {{-21, -7}, {21, 7}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(visible = true, transformation(origin = {-283, -125}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression FF_mflow(y = (FirstFloor.y[5] + SecondFloor.y[5]) * 1.225 / 3600) annotation(
    Placement(visible = true, transformation(origin = {-320, -12}, extent = {{-24, -6}, {24, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression TF_mflow(y = ThirdFloor.y[5] * 1.225 / 3600) annotation(
    Placement(visible = true, transformation(origin = {-325, 82}, extent = {{-21, -8}, {21, 8}}, rotation = 0)));
  Buildings.Fluid.Sources.MassFlowSource_T Vent_TF(redeclare package Medium = Medium_Air, nPorts = 1, use_T_in = true, use_m_flow_in = true) annotation(
    Placement(visible = true, transformation(origin = {-208, 66}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-233, 71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression DHW(y = (FirstFloor.y[3] + SecondFloor.y[3] + ThirdFloor.y[3]) / 3600 * (T_DHW.y - T_ColdWater.y) / (WaterTank.T[5] - T_ColdWater.y)) annotation(
    Placement(visible = true, transformation(origin = {116, 23}, extent = {{38, -9}, {-38, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_ColdWater(k = 10 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {146, 6}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant T_DHW(k = 45 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {122, 6}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant dT_DHW2WW(k = 10) annotation(
    Placement(visible = true, transformation(origin = {-277, -175}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {44, 30}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression T_Storage(y = (-WaterTank.T[5]) + 65 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {382, 70}, extent = {{24, -10}, {-24, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = ST_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {385, 128}, extent = {{25, -8}, {-25, 8}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold Brine_min(threshold = (-10) + 273.15) annotation(
    Placement(visible = true, transformation(origin = {324, 128}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Estimated_COP_BW(y = ((-6.0831) - 0.3793 * realExpression2.y / 289.15 + 7.473 * ST_T_OUT.T / 283.15) * 3533.9 / ((7.7150 + 7.0296 * realExpression2.y / 289.15 + 1.6481 * ST_T_OUT.T / 283.15) * 449.1)) annotation(
    Placement(visible = true, transformation(origin = {92, 276}, extent = {{-34, -8}, {34, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression Estimated_COP_AW(y = ((-1.24) - 1.24 * realExpression3.y / 326.15 + 6.28 * HX_AW_OUT.T / 291.15) * 77000 / (((-5.55) + 5.08 * realExpression3.y / 326.15 + 1.01 * HX_AW_OUT.T / 291.15) * 18000)) annotation(
    Placement(visible = true, transformation(origin = {92, 262}, extent = {{-34, -8}, {34, 8}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis LowEnergy(uHigh = 18, uLow = 13) annotation(
    Placement(visible = true, transformation(origin = {326, 70}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAnd(nu = 2) annotation(
    Placement(visible = true, transformation(origin = {194, 100}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression6(y = (-WaterTank.T[5]) + 65 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {350, -92}, extent = {{24, -10}, {-24, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uHigh = 18, uLow = 8) annotation(
    Placement(visible = true, transformation(origin = {300, -92}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume cool(redeclare package Medium = Medium_Brine, V = 1, m_flow_nominal = 1, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {-44, 118}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(
    Placement(visible = true, transformation(origin = {5, 117}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -2000) annotation(
    Placement(visible = true, transformation(origin = {17, 117}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold = 95 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {37, 117}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation(
    Placement(visible = true, transformation(origin = {27, 117}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression5(y = ST_T_OUT.T) annotation(
    Placement(visible = true, transformation(origin = {54, 116}, extent = {{8, -4}, {-8, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression7(y = (DHW.y * T_ColdWater.y + Heating.y * add1.y) / add2.y) annotation(
    Placement(visible = true, transformation(origin = {120, -31}, extent = {{38, -9}, {-38, 9}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pvRoof(A = 10, V_nominal = 120, azi(displayUnit = "rad") = -0.78539816339745, lat(displayUnit = "rad") = 0.65798912800186, til(displayUnit = "rad") = 0.34906585039887) annotation(
    Placement(visible = true, transformation(extent = {{-144, -252}, {-124, -232}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pvFacade(A = 10, V_nominal = 120, azi(displayUnit = "rad") = -0.78539816339745, lat(displayUnit = "rad") = 0.65798912800186, til(displayUnit = "rad") = 0.34906585039887) annotation(
    Placement(visible = true, transformation(extent = {{-60, -222}, {-40, -202}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pvSolarTree(A = 10, V_nominal = 120, azi(displayUnit = "rad") = -0.78539816339745, lat(displayUnit = "rad") = 0.65798912800186, til(displayUnit = "rad") = 0.34906585039887) annotation(
    Placement(visible = true, transformation(extent = {{-66, -264}, {-46, -244}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {-280, -220}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(P_nominal = -2000, V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_y_input) annotation(
    Placement(visible = true, transformation(extent = {{20, -266}, {40, -246}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant load(k = 0.5) annotation(
    Placement(visible = true, transformation(extent = {{78, -266}, {58, -246}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pow(amplitude = 1000, offset = -500, period = 1200, width = 50) annotation(
    Placement(visible = true, transformation(origin = {322, -160}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(V = 120, f = 60) annotation(
    Placement(visible = true, transformation(extent = {{188, -238}, {208, -218}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Storage.Battery bat_ideal(EMax = 749999.88, SOC_start = 0.5, V_nominal = 120, etaCha = 1, etaDis = 1, eta_DCAC = 1) annotation(
    Placement(visible = true, transformation(extent = {{250, -208}, {270, -188}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression elecCons_1(y = FirstFloor.y[4]) annotation(
    Placement(visible = true, transformation(origin = {365, -270}, extent = {{21, -8}, {-21, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression elecCons_2(y = SecondFloor.y[4]) annotation(
    Placement(visible = true, transformation(origin = {303, -242}, extent = {{21, -8}, {-21, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression elecCons_3(y = ThirdFloor.y[4]) annotation(
    Placement(visible = true, transformation(origin = {239, -272}, extent = {{21, -8}, {-21, 8}}, rotation = 0)));
equation
  connect(hex_down.port_b1, FirstSecond.ports[1]) annotation(
    Line(points = {{-194, -16.8}, {-200, -16.8}, {-200, -7}, {-214, -7}}, color = {0, 127, 255}));
  connect(Vent_RET.ports[1], hex_down.port_a2) annotation(
    Line(points = {{-210, -25}, {-194, -25}}, color = {0, 127, 255}));
  connect(FF_Temp.y, Vent_RET.T_in) annotation(
    Line(points = {{-293.6, -23}, {-241.3, -23}, {-241.3, -22}, {-224.6, -22}}, color = {0, 0, 127}));
  connect(AW_Heatpump.port_b2, lower.ports[1]) annotation(
    Line(points = {{-158, -60.4}, {-167, -60.4}, {-167, -54.4}, {-166, -54.4}}, color = {0, 127, 255}));
  connect(RoomHeating_OUT.ports[1], pump_RET.port_a) annotation(
    Line(points = {{20, -36}, {8, -36}}, color = {0, 127, 255}));
  connect(pump_SUP.port_b, T_SUP.port_a) annotation(
    Line(points = {{-4, -8}, {2, -8}}, color = {0, 127, 255}));
  connect(T_SUP.port_b, RoomHeating_IN.ports[1]) annotation(
    Line(points = {{16, -8}, {20, -8}}, color = {0, 127, 255}));
  connect(T_SUP.T, add1.u2) annotation(
    Line(points = {{9, -1.4}, {9, 4}, {33, 4}}, color = {0, 0, 127}));
  connect(c_SUP.y, add1.u1) annotation(
    Line(points = {{8.4, 12}, {33, 12}}, color = {0, 0, 127}));
  connect(WeatherData.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{-360, 128}, {-135, 128}, {-135, 86}}, color = {255, 204, 51}, pattern = LinePattern.None, thickness = 0.5));
  connect(ST_T_IN.port_b, thermalCollector.port_a) annotation(
    Line(points = {{-94, 122}, {-92, 122}}, color = {0, 127, 255}));
  connect(thermalCollector.port_b, ST_T_OUT.port_a) annotation(
    Line(points = {{-72, 122}, {-70, 122}}, color = {0, 127, 255}));
  connect(st_ZeroFlow1.port_3, st_ZeroFlow2.port_3) annotation(
    Line(points = {{-129, 114}, {-129, 104}, {-25, 104}, {-25, 114}}, color = {0, 127, 255}));
  connect(ST_massflow.port_b, st_ZeroFlow1.port_1) annotation(
    Line(points = {{-144, 122}, {-134, 122}}, color = {0, 127, 255}));
  connect(st_ZeroFlow1.port_2, pump_ST.port_a) annotation(
    Line(points = {{-124, 122}, {-122, 122}}, color = {0, 127, 255}));
  connect(pump_ST.port_b, ST_T_IN.port_a) annotation(
    Line(points = {{-110, 122}, {-108, 122}}, color = {0, 127, 255}));
  connect(realExpression1.y, st_dir_hyst.u) annotation(
    Line(points = {{95.9, 171}, {74.9, 171}}, color = {0, 0, 127}));
  connect(hex_up.port_b1, Ex_Brine_OUT.port_a) annotation(
    Line(points = {{-163.8, 65}, {-162.8, 65}, {-162.8, 70}}, color = {0, 127, 255}));
  connect(hex_up.port_a1, Ex_Brine_IN.port_b) annotation(
    Line(points = {{-163.8, 47}, {-163.8, 42.5}, {-157.8, 42.5}, {-157.8, 42}}, color = {0, 127, 255}));
  connect(Ex_Air_IN.port_b, hex_up.port_a2) annotation(
    Line(points = {{-178, 66}, {-179, 66}, {-179, 65}, {-172, 65}}, color = {0, 127, 255}));
  connect(hex_up.port_b2, Ex_Air_Out.port_b) annotation(
    Line(points = {{-172.2, 47}, {-172.2, 46}, {-178.2, 46}}, color = {0, 127, 255}));
  connect(Third_sink.ports[1], Ex_Air_Out.port_a) annotation(
    Line(points = {{-202, 47}, {-198, 47}, {-198, 46}}, color = {0, 127, 255}));
  connect(third_on_off.y, compare.u) annotation(
    Line(points = {{-301.9, 71}, {-276.8, 71}}, color = {0, 0, 127}));
  connect(compare.y, b2r1.u) annotation(
    Line(points = {{-265.5, 71}, {-259, 71}}, color = {255, 0, 255}));
  connect(val1.port_2, ST_massflow.port_a) annotation(
    Line(points = {{-163, 97}, {-163, 122}, {-158, 122}}, color = {0, 127, 255}));
  connect(val1.port_1, Ex_Brine_OUT.port_b) annotation(
    Line(points = {{-163, 87}, {-163, 82}}, color = {0, 127, 255}));
  connect(Ex_Brine_IN.port_a, BW_Heatpump.port_b2) annotation(
    Line(points = {{-148, 42}, {-120, 42}}, color = {0, 127, 255}));
  connect(BW_Heatpump.port_a2, val2.port_2) annotation(
    Line(points = {{-92, 41.6}, {-18, 41.6}, {-18, 87.6}}, color = {0, 127, 255}));
  connect(pump_AW1.port_a, WaterTank.port_a1) annotation(
    Line(points = {{-88, -86}, {-82, -86}, {-82, -36}, {-67.5, -36}}, color = {0, 127, 255}));
  connect(WaterTank.port_a2, pump_SUP.port_a) annotation(
    Line(points = {{-46.5, -7.6}, {-31.5, -7.6}, {-31.5, -6.8}, {-16.5, -6.8}}, color = {0, 127, 255}));
  connect(WaterTank.port_b2, pump_RET.port_b) annotation(
    Line(points = {{-46.5, -36.4}, {-41.5, -36.4}, {-41.5, -36}, {-6, -36}}, color = {0, 127, 255}));
  connect(bou1.ports[1], pump_AW1.port_a) annotation(
    Line(points = {{-80, -86}, {-88, -86}}, color = {0, 127, 255}));
  connect(hex_down.port_a1, Vent_SUP.ports[1]) annotation(
    Line(points = {{-166, -16.8}, {-158, -16.8}}, color = {0, 127, 255}));
  connect(Vent_SUP.T_in, WeatherData.weaBus.TDryBul) annotation(
    Line(points = {{-142.6, -14.2}, {-135.6, -14.2}, {-135.6, 6}, {-355.8, 6}, {-355.8, 128}, {-360, 128}}, color = {0, 0, 127}));
  connect(st_dir_hyst.y, and1.u1) annotation(
    Line(points = {{63.5, 171}, {51, 171}}, color = {255, 0, 255}));
  connect(and1.u2, not1.y) annotation(
    Line(points = {{51, 167}, {56, 167}, {56, 157}, {63.5, 157}}, color = {255, 0, 255}));
  connect(b2i.y, BW_Heatpump.uMod) annotation(
    Line(points = {{63.4, 60}, {-127.6, 60}, {-127.6, 36}, {-121.6, 36}}, color = {255, 127, 0}));
  connect(pump_AW1.m_flow_in, AW_mflow_load.y) annotation(
    Line(points = {{-94, -93.2}, {-93.25, -93.2}, {-93.25, -111.2}, {49, -111.2}}, color = {0, 0, 127}));
  connect(b2r2.y, AW_mflow_load.u) annotation(
    Line(points = {{73.5, -111}, {65, -111}}, color = {0, 0, 127}));
  connect(switch1.y, pump_ST.m_flow_in) annotation(
    Line(points = {{-20.5, 145}, {-116, 145}, {-116, 126}}, color = {0, 0, 127}));
  connect(BW_mflow_load.y, switch1.u1) annotation(
    Line(points = {{21.5, 155}, {-4.5, 155}, {-4.5, 149}, {-9, 149}}, color = {0, 0, 127}));
  connect(val2.y, b2r3.y) annotation(
    Line(points = {{-9.4, 92}, {0.6, 92}, {0.6, 101}, {23.5, 101}}, color = {0, 0, 127}));
  connect(b2r3.y, val1.y) annotation(
    Line(points = {{23.5, 101}, {-190, 101}, {-190, 92}, {-173, 92}}, color = {0, 0, 127}));
  connect(switch2.u3, b2r.y) annotation(
    Line(points = {{-9, 177}, {7, 177}, {7, 171}, {21.5, 171}}, color = {0, 0, 127}));
  connect(b2r.u, and1.y) annotation(
    Line(points = {{33, 171}, {39.5, 171}}, color = {255, 0, 255}));
  connect(switch2.y, st_ZeroFlow2.y) annotation(
    Line(points = {{-20.5, 181}, {-25, 181}, {-25, 132}}, color = {0, 0, 127}));
  connect(switch2.y, st_ZeroFlow1.y) annotation(
    Line(points = {{-20.5, 181}, {-129, 181}, {-129, 132}}, color = {0, 0, 127}));
  connect(const.y, switch2.u1) annotation(
    Line(points = {{21.5, 191}, {6, 191}, {6, 185}, {-9, 185}}, color = {0, 0, 127}));
  connect(WaterTank.port_a1, pump_BW.port_a) annotation(
    Line(points = {{-67.5, -36.4}, {-102, -36.4}, {-102, 9.91834e-05}, {-108, 9.91834e-05}}, color = {0, 127, 255}));
  connect(BW_mflow_source.y, pump_BW.m_flow_in) annotation(
    Line(points = {{-72.6, 16}, {-114, 16}, {-114, 5}}, color = {0, 0, 127}));
  connect(b2r3.y, BW_mflow_source.u) annotation(
    Line(points = {{23.5, 101}, {-50, 101}, {-50, 16}, {-58, 16}}, color = {0, 0, 127}));
  connect(realExpression2.y, BW_Heatpump.TSet) annotation(
    Line(points = {{31.9, 75}, {-144, 75}, {-144, 26}, {-122, 26}}, color = {0, 0, 127}));
  connect(AW_Heatpump.TSet, realExpression3.y) annotation(
    Line(points = {{-159.96, -76.9}, {-176, -76.9}, {-176, -96.9}, {40.04, -96.9}}, color = {0, 0, 127}));
  connect(BW_Heatpump.port_b1, WaterTank.port_b1) annotation(
    Line(points = {{-92, 28.4}, {-86, 28.4}, {-86, -7.6}, {-68, -7.6}}, color = {0, 127, 255}));
  connect(pump_BW.port_b, BW_T_OUT.port_a) annotation(
    Line(points = {{-120, 0}, {-130, 0}, {-130, 8}}, color = {0, 127, 255}));
  connect(BW_T_OUT.port_b, BW_Heatpump.port_a1) annotation(
    Line(points = {{-130, 20}, {-130, 28}, {-120, 28}}, color = {0, 127, 255}));
  connect(AW_Heatpump.port_b1, WaterTank.port_b1) annotation(
    Line(points = {{-130, -73.6}, {-86, -73.6}, {-86, -7.2}, {-68, -7.2}}, color = {0, 127, 255}));
  connect(AW_Heatpump.port_a1, AW_T_OUT.port_b) annotation(
    Line(points = {{-158, -73.6}, {-170, -73.6}, {-170, -85.6}, {-122, -85.6}}, color = {0, 127, 255}));
  connect(AW_T_OUT.port_a, pump_AW1.port_b) annotation(
    Line(points = {{-110, -86}, {-100, -86}}, color = {0, 127, 255}));
  connect(st_PID.y, switch1.u3) annotation(
    Line(points = {{3.5, 135}, {-4.75, 135}, {-4.75, 141}, {-9, 141}}, color = {0, 0, 127}));
  connect(ST_T_OUT.T, st_PID.u_m) annotation(
    Line(points = {{-64, 126}, {-64, 126.8}, {9, 126.8}, {9, 129}}, color = {0, 0, 127}));
  connect(st_dir_setpoint.y, st_PID.u_s) annotation(
    Line(points = {{21.5, 135}, {15, 135}}, color = {0, 0, 127}));
  connect(test2.ports[1], pump_ST.port_a) annotation(
    Line(points = {{-114, 111}, {-122, 111}, {-122, 121}}, color = {0, 127, 255}));
  connect(val1.port_3, WaterTank.port_HX_2_a) annotation(
    Line(points = {{-155, 92}, {-43, 92}, {-43, -14}, {-47, -14}}, color = {0, 127, 255}));
  connect(WaterTank.port_HX_2_b, val2.port_3) annotation(
    Line(points = {{-46.5, -17.2}, {-34.5, -17.2}, {-34.5, 92.8}, {-26.5, 92.8}}, color = {0, 127, 255}));
  connect(hysteresis.y, booleanToReal.u) annotation(
    Line(points = {{-249.5, -99}, {-243, -99}}, color = {255, 0, 255}));
  connect(booleanToReal.y, gain3.u) annotation(
    Line(points = {{-231.5, -99}, {-221, -99}}, color = {0, 0, 127}));
  connect(add.y, hysteresis.u) annotation(
    Line(points = {{-271.4, -98}, {-260.4, -98}}, color = {0, 0, 127}));
  connect(WaterTank.T[1], add.u1) annotation(
    Line(points = {{-68.1, -12.4}, {-120.1, -12.4}, {-120.1, -40.4}, {-294.1, -40.4}, {-294.1, -94.4}, {-285.1, -94.4}}, color = {0, 0, 127}));
  connect(gain3.y, pump_ww.m_flow_in) annotation(
    Line(points = {{-209.5, -99}, {-193.5, -99}, {-193.5, -128}}, color = {0, 0, 127}));
  connect(WW_tank.ports[1], pump_ww.port_a) annotation(
    Line(points = {{-240, -134}, {-202, -134}}, color = {0, 127, 255}));
  connect(t_wwtank.y, add.u2) annotation(
    Line(points = {{-299.9, -102}, {-285.9, -102}}, color = {0, 0, 127}));
  connect(WaterTank.port_HX_1_a, pump_ww.port_b) annotation(
    Line(points = {{-46.5, -28.4}, {-26.5, -28.4}, {-26.5, -134.4}, {-186.5, -134.4}}, color = {0, 127, 255}));
  connect(WaterTank.port_HX_1_b, WW_tank.ports[2]) annotation(
    Line(points = {{-46.5, -31.6}, {-36.5, -31.6}, {-36.5, -145.6}, {-240.5, -145.6}, {-240.5, -133.6}}, color = {0, 127, 255}));
  connect(WW_tank.ports[3], boundary.ports[1]) annotation(
    Line(points = {{-240, -134}, {-230, -134}, {-230, -124}, {-220, -124}}, color = {0, 127, 255}));
  connect(prescribedHeatFlow.port, WW_tank.heatPort) annotation(
    Line(points = {{-274, -125}, {-248, -125}}, color = {191, 0, 0}));
  connect(realExpression4.y, prescribedHeatFlow.Q_flow) annotation(
    Line(points = {{-300, -125}, {-291.9, -125}}, color = {0, 0, 127}));
  connect(FF_mflow.y, Vent_RET.m_flow_in) annotation(
    Line(points = {{-293.6, -12}, {-241.6, -12}, {-241.6, -20}, {-225.6, -20}}, color = {0, 0, 127}));
  connect(Ex_Air_IN.port_a, Vent_TF.ports[1]) annotation(
    Line(points = {{-198, 66}, {-202, 66}}, color = {0, 127, 255}));
  connect(b2r1.y, product.u2) annotation(
    Line(points = {{-247.5, 71}, {-243.25, 71}, {-243.25, 68}, {-239, 68}}, color = {0, 0, 127}));
  connect(TF_mflow.y, product.u1) annotation(
    Line(points = {{-301.9, 82}, {-243.8, 82}, {-243.8, 74}, {-238.9, 74}}, color = {0, 0, 127}));
  connect(product.y, Vent_TF.m_flow_in) annotation(
    Line(points = {{-227.5, 71}, {-215, 71}}, color = {0, 0, 127}));
  connect(TF_Temp.y, Vent_TF.T_in) annotation(
    Line(points = {{-301.9, 61}, {-221.9, 61}, {-221.9, 68}, {-214.9, 68}}, color = {0, 0, 127}));
  connect(Heating.y, add2.u1) annotation(
    Line(points = {{74.2, 37}, {60.2, 37}, {60.2, 34}, {52.2, 34}}, color = {0, 0, 127}));
  connect(DHW.y, add2.u2) annotation(
    Line(points = {{74.2, 23}, {60.2, 23}, {60.2, 26}, {52.2, 26}}, color = {0, 0, 127}));
  connect(add2.y, pump_SUP.m_flow_in) annotation(
    Line(points = {{37.4, 30}, {-10.6, 30}, {-10.6, -4}}, color = {0, 0, 127}));
  connect(add2.y, pump_RET.m_flow_in) annotation(
    Line(points = {{37.4, 30}, {0.399999, 30}, {0.399999, -29}}, color = {0, 0, 127}));
  connect(AW_Heatpump.uMod, b2i1.y) annotation(
    Line(points = {{-159.4, -67}, {-179.4, -67}, {-179.4, -126}, {74.1, -126}}, color = {255, 127, 0}));
  connect(realExpression.y, Brine_min.u) annotation(
    Line(points = {{357.5, 128}, {334, 128}}, color = {0, 0, 127}));
  connect(hex_down.port_b2, HX_AW_OUT.port_a) annotation(
    Line(points = {{-166, -26}, {-114, -26}, {-114, -36}}, color = {0, 127, 255}));
  connect(HX_AW_OUT.port_b, AW_Heatpump.port_a2) annotation(
    Line(points = {{-114, -56}, {-114, -60}, {-130, -60}}, color = {0, 127, 255}));
  connect(T_Storage.y, LowEnergy.u) annotation(
    Line(points = {{355.6, 70}, {338, 70}}, color = {0, 0, 127}));
  connect(mulAnd.y, b2r3.u) annotation(
    Line(points = {{182, 100}, {36, 100}, {36, 102}}, color = {255, 0, 255}));
  connect(mulAnd.y, b2i.u) annotation(
    Line(points = {{182, 100}, {152, 100}, {152, 60}, {78, 60}}, color = {255, 0, 255}));
  connect(switch1.u2, mulAnd.y) annotation(
    Line(points = {{-8, 146}, {152, 146}, {152, 100}, {182, 100}}, color = {255, 0, 255}));
  connect(not1.u, mulAnd.y) annotation(
    Line(points = {{76, 158}, {152, 158}, {152, 100}, {182, 100}}, color = {255, 0, 255}));
  connect(switch2.u2, mulAnd.y) annotation(
    Line(points = {{-8, 182}, {152, 182}, {152, 100}, {182, 100}}, color = {255, 0, 255}));
  connect(Brine_min.y, mulAnd.u[1]) annotation(
    Line(points = {{316, 128}, {228, 128}, {228, 100}, {206, 100}}, color = {255, 0, 255}));
  connect(LowEnergy.y, mulAnd.u[2]) annotation(
    Line(points = {{315, 70}, {228, 70}, {228, 100}, {206, 100}}, color = {255, 0, 255}));
  connect(hysteresis1.u, realExpression6.y) annotation(
    Line(points = {{312, -92}, {324, -92}}, color = {0, 0, 127}));
  connect(hysteresis1.y, b2r2.u) annotation(
    Line(points = {{290, -92}, {190, -92}, {190, -110}, {86, -110}}, color = {255, 0, 255}));
  connect(hysteresis1.y, b2i1.u) annotation(
    Line(points = {{290, -92}, {190, -92}, {190, -124}, {86, -124}}, color = {255, 0, 255}));
  connect(prescribedHeatFlow1.port, cool.heatPort) annotation(
    Line(points = {{0, 117}, {-40, 117}, {-40, 118}}, color = {191, 0, 0}));
  connect(prescribedHeatFlow1.Q_flow, gain.y) annotation(
    Line(points = {{10, 117}, {14, 117}}, color = {0, 0, 127}));
  connect(gain.u, booleanToReal1.y) annotation(
    Line(points = {{20.6, 117}, {23.6, 117}}, color = {0, 0, 127}));
  connect(booleanToReal1.u, greaterThreshold.y) annotation(
    Line(points = {{30.6, 117}, {33.6, 117}}, color = {255, 0, 255}));
  connect(greaterThreshold.u, realExpression5.y) annotation(
    Line(points = {{40.6, 117}, {43.1, 117}, {43.1, 116}, {44.6, 116}}, color = {0, 0, 127}));
  connect(st_ZeroFlow2.port_2, val2.port_1) annotation(
    Line(points = {{-20, 122}, {-18, 122}, {-18, 98}}, color = {0, 127, 255}));
  connect(ST_T_OUT.port_b, cool.ports[1]) annotation(
    Line(points = {{-58, 122}, {-44, 122}}, color = {0, 127, 255}));
  connect(cool.ports[2], st_ZeroFlow2.port_1) annotation(
    Line(points = {{-44, 122}, {-30, 122}}, color = {0, 127, 255}));
  connect(realExpression7.y, RoomHeating_OUT.T_in) annotation(
    Line(points = {{78, -31}, {62, -31}, {62, -34}, {44, -34}}, color = {0, 0, 127}));
  connect(fixVol.terminal, bat_ideal.terminal) annotation(
    Line(points = {{208, -228}, {230, -228}, {230, -198}, {250, -198}}, color = {0, 120, 120}));
  connect(pow.y, bat_ideal.P) annotation(
    Line(points = {{311, -160}, {260, -160}, {260, -188}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-400, -300}, {400, 300}}), graphics = {Text(origin = {113, 136}, extent = {{73, -12}, {-73, 12}}, textString = "If BW-HP on -> fixed massflow from HP 
 If BW-HP out -> PD controll for fixed temperature output"), Text(origin = {153, 203}, extent = {{223, -9}, {-223, 9}}, textString = "If BW-HP on -> valve open 
 If BW-HP out ->checking if storage can be loaded,
 if not, closed curcuit for correct behaviour in PVT"), Text(origin = {207, 29}, extent = {{95, -9}, {-95, 9}}, textString = "calculation of massflow for a 
set temperature difference"), Text(origin = {-323, -135}, extent = {{-29, 13}, {29, -13}}, textString = "VDI 2055 Ausg. 1994 - Wärme- und Kälteschutz für betriebs- und haustechnische Anlagen"), Text(origin = {-335, -40}, extent = {{-41, 10}, {41, -10}}, textString = "Temperature of air mixture 
 mass flow"), Text(origin = {-291, 101}, extent = {{-75, 13}, {75, -13}}, textString = "If T at HX brine inlet is lower 
than room temperature in thrid floor 
 -> heat exchange"), Rectangle(origin = {27, 155}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-9, 7}, {9, -7}}), Rectangle(origin = {56, 76}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 6}, {28, -6}}), Rectangle(origin = {-67, 15}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-9, 7}, {9, -7}}), Rectangle(origin = {27, 135}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-9, 7}, {9, -7}}), Rectangle(origin = {-217, -99}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-9, 7}, {9, -7}}), Rectangle(origin = {-269, -146}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-25, 14}, {25, -14}}), Text(origin = {-141, -177}, extent = {{-111, 5}, {111, -5}}, textString = "Temperaturunterschied zwischen Zapftemperatur und WasteWater Temperatur"), Rectangle(origin = {51, -112}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-19, 6}, {19, -6}}), Rectangle(origin = {56, 76}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 6}, {28, -6}}), Rectangle(origin = {56, 76}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 6}, {28, -6}}), Rectangle(origin = {56, 76}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 6}, {28, -6}}), Rectangle(origin = {64, -96}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-28, 6}, {28, -6}}), Text(origin = {100, -73}, extent = {{-98, 31}, {98, -31}}, textString = "Set Temperatur, eingestellt nach konstanter Leistung 
 möglich wäre Leistung nach Koeffizienten aus Regression zu ermitteln 
 damit wäre T_set = f(T_source, T_Load, Q_load, hersteller)"), Rectangle(origin = {-265, 131}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 11}, {23, -11}}), Rectangle(origin = {-105, 35}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 11}, {23, -11}}), Rectangle(origin = {-166, 55}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-12, 7}, {12, -7}}), Rectangle(origin = {-180, -21}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-12, 7}, {12, -7}}), Rectangle(origin = {-57, -23}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-17, 25}, {17, -25}}), Rectangle(origin = {-83, 122}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-15, 12}, {15, -12}}), Rectangle(origin = {-145, -67}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-23, 11}, {23, -11}}), Rectangle(origin = {-240, -125}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-12, 7}, {12, -7}})}),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600),
			Documentation(info = "<html><p>
This model calculates the whole energy balance of the Design Challenge for a full year. Both thermal and electrical models are included List of assumptions must be completed here.</p>
</html>", revisions = "<html>
<ul>
<li>
January 28, 2022 by Nicolas Carbonare:<br/>
Added first implementation of electrical model. Parametrization of model incomplete. Documentation incomplete. 
</li>
<li>
January 08, 2022 by Moritz Bühler:<br/>
First implementation of thermal model. Parametrization of model incomplete. Documentation incomplete. 
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-400, -300}, {400, 300}})));
end GG_Full;
