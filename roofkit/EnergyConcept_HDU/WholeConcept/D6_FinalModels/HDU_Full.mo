within RoofKIT.EnergyConcept_HDU.WholeConcept.D6_FinalModels;

model HDU_Full
  // 3.1536e+07 stop time
  // Cloudy week StartTime = 14509700, StopTime = 15114500
  // import Modelica.Constants.*;
  extends Modelica.Icons.Example;
  package Medium_loa = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.35, property_T = 283.15);
  package Medium_heat = Buildings.Media.Water;
  
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal = 800 / 3600 "Source heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = 400 / 3600 "Load heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mSolCol_flow_nominal = 12 * 60 / 3600 "Solar collector nominal mass flow rate";
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {74, 186}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {109, 21}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  Buildings.Fluid.Sources.Boundary_pT MAG_solCol(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-38, -166}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {-24, -10}, extent = {{-14, -12}, {14, 12}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_sou(redeclare replaceable package Medium = Medium_sou, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {10, -18}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_TWW(redeclare replaceable package Medium = Medium_loa, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {-23, 110}, extent = {{7, 8}, {-7, -8}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_FH(redeclare replaceable package Medium = Medium_loa, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {171, 84}, extent = {{7, 8}, {-7, -8}}, rotation = -90)));
  Buildings.Fluid.Sources.Boundary_pT MAG_HP_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {14, 18}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_HP_loa(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {76, 92}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-74, -72}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 1.62 * 12, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, lat = 0.8946, m_flow_nominal = 60 / 3600 * 12, til = 0.21, volSol = 0.00154 * 12) annotation(
    Placement(visible = true, transformation(origin = {38, -174}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_In_HP(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-57, -9}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_Out_solCol(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {59, -174}, extent = {{-7, 6}, {7, -6}}, rotation = 180)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_heat, redeclare package Medium_HX_1 = Medium_heat, redeclare package Medium_HX_2 = Medium_loa, HX_1 = true, HX_2 = false, T_start = 50 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 20000, V = 0.185, height = 0.5, nEle = 5, thickness_ins = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-48, 104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 115}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_heat, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 121}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_heat, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 95}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {-63, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal1(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {69, 17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val12(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 96}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_TWW(uHigh = 45 + 273.15, uLow = 41 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-149, 65}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage Quelle_Puffer(redeclare package Medium = Medium_sou, redeclare package Medium_HX_1 = Medium_sou, redeclare package Medium_HX_2 = Medium_sou, HX_1 = true, HX_2 = false, T_start = 30 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 20000, V = 1.0, height = 1.5, nEle = 5, thickness_ins = 0.15, thickness_wall = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-16, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_solCol(redeclare replaceable package Medium = Medium_sou, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-20, -174}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT MAG_HP_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {36, -20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_solCol(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {39, -43}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis_solCol(uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {57, -43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium = Medium_sou, CvData = Buildings.Fluid.Types.CvTypes.OpPoint, dpValve_nominal = 600, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {6, -72}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val8(redeclare package Medium = Medium_sou, dpValve_nominal = 600, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {6, -96}, extent = {{4, 4}, {-4, -4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP1(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {-26, -96}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP2(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {26, -72}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal btr_solCol annotation(
    Placement(visible = true, transformation(origin = {74, -43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2_solCol(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {47, -59}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_solCol(k = 1) annotation(
    Placement(visible = true, transformation(origin = {64, -64}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_In_solCol(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {3, -174}, extent = {{-7, 6}, {7, -6}}, rotation = 180)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 1500, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {178, -74}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {105, -74}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_Th annotation(
    Placement(visible = true, transformation(origin = {150, -48}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division JAZ annotation(
    Placement(visible = true, transformation(origin = {104, -48}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_El annotation(
    Placement(visible = true, transformation(origin = {152, -68}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {118, -88}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 10000, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {178, -48}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_solCol(k = mSolCol_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-70, -162}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable HDU(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/HDU/Input_HDU.txt", table = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tableName = "HDU", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {4, 188}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_FH(k = -54) annotation(
    Placement(visible = true, transformation(origin = {30, 116}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / 3600) annotation(
    Placement(visible = true, transformation(origin = {-59, 125}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {-156, 136}, extent = {{8, 8}, {-8, -8}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-149, 105}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_HP_Out(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {13, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Eheater_HP annotation(
    Placement(visible = true, transformation(origin = {89, 1}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperature_floor_heat(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {125, 137}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_HP annotation(
    Placement(visible = true, transformation(origin = {-128, -50}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume1(redeclare package Medium = Medium_loa, V = 0.03, m_flow_nominal = mSou_flow_nominal, T_start = 35 + 273.15, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {42, 10}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Logical.Not not_temp_sou annotation(
    Placement(visible = true, transformation(origin = {-129, -75}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatPower annotation(
    Placement(visible = true, transformation(origin = {57, 125}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume(redeclare package Medium = Medium_loa, T_start = 35 + 273.15, V = 0.2, m_flow_nominal = mSou_flow_nominal, nPorts = 3) annotation(
    Placement(visible = true, transformation(origin = {36, 144}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_eheat_TWW annotation(
    Placement(visible = true, transformation(origin = {130, 9}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_TWW annotation(
    Placement(visible = true, transformation(origin = {-95, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_TWW annotation(
    Placement(visible = true, transformation(origin = {-133, 65}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_HP_sou(k = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-74, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_mflow_FH annotation(
    Placement(visible = true, transformation(origin = {108, 99}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_FH annotation(
    Placement(visible = true, transformation(origin = {67, 107}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_FH(uHigh = 34 + 273.15, uLow = 32 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {29, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_FH annotation(
    Placement(visible = true, transformation(origin = {45, 85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_mflow_HPsou annotation(
    Placement(visible = true, transformation(origin = {-52, -51}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Eheater_pow(k = 3000) annotation(
    Placement(visible = true, transformation(origin = {160, 26}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-176, -42}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_Eheater annotation(
    Placement(visible = true, transformation(origin = {155, 5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_Eheater annotation(
    Placement(visible = true, transformation(origin = {-124, -96}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger bti_HP annotation(
    Placement(visible = true, transformation(origin = {-106, -50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {154, -88}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {131, -71}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Tset_TWW(k = 273.15 + 45) annotation(
    Placement(visible = true, transformation(origin = {-180, 20}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product_contHP annotation(
    Placement(visible = true, transformation(origin = {-158, 22}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Math.Max max_contHP annotation(
    Placement(visible = true, transformation(origin = {-135, 9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_TWW(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-70, 60}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Tset_FH(k = 273.15 + 35) annotation(
    Placement(visible = true, transformation(origin = {-174, -2}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_contHP(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-113, -5}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_contHP(uHigh = 1, uLow = -1) annotation(
    Placement(visible = true, transformation(origin = {-151, -15}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-156, -42}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = 4 + 273.15, uLow = 2 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-99, -85}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch sw_FH annotation(
    Placement(visible = true, transformation(origin = {143, 83}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gr_FH(threshold = 0.001) annotation(
    Placement(visible = true, transformation(origin = {79, 63}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = mLoa_flow_nominal / 5) annotation(
    Placement(visible = true, transformation(origin = {122, 56}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.And and2 annotation(
    Placement(visible = true, transformation(origin = {112, 74}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl batteryControl annotation(
    Placement(visible = true, transformation(origin = {-109, -170}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 16.2, V_nominal = 400, azi(displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {36, -200}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 220 / 220, eta = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-166, -200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 480, f = 60) annotation(
    Placement(visible = true, transformation(origin = {-84, 190}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(origin = {-184, -166}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 9000000, SOC_start = 0.8, V_nominal = 110) annotation(
    Placement(visible = true, transformation(origin = {-108, -206}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Utilities.Time.CalendarTime calTim(day(start = 1), hour(start = 0), zerTim = Buildings.Utilities.Time.Types.ZeroTime.Custom) annotation(
    Placement(visible = true, transformation(origin = {-186, -100}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal itr_time annotation(
    Placement(visible = true, transformation(origin = {-169, -97}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gre_time(threshold = 5) annotation(
    Placement(visible = true, transformation(origin = {-175, -79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_time annotation(
    Placement(visible = true, transformation(origin = {-155, -79}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.Temperature Temp_FH(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {9, 86}, extent = {{-5, 4}, {5, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.And and3 annotation(
    Placement(visible = true, transformation(origin = {-155, -61}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less_time(threshold = 23) annotation(
    Placement(visible = true, transformation(origin = {-175, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less_TWW(threshold = 17) annotation(
    Placement(visible = true, transformation(origin = {-175, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gre_TWW(threshold = 13) annotation(
    Placement(visible = true, transformation(origin = {-175, 53}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW1 annotation(
    Placement(visible = true, transformation(origin = {-133, 53}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW2 annotation(
    Placement(visible = true, transformation(origin = {-115, 61}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_FH_T(uHigh = 34 + 273.15, uLow = 32 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {111, 125}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_FH_T annotation(
    Placement(visible = true, transformation(origin = {91, 125}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {-169, -183}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_g annotation(
    Placement(visible = true, transformation(origin = {152, -182}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_f annotation(
    Placement(visible = true, transformation(origin = {116, -206}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_c annotation(
    Placement(visible = true, transformation(origin = {154, -164}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression I_sc(y = (E_g.y - E_f.y) / E_g_filt.y) annotation(
    Placement(visible = true, transformation(origin = {101, -154}, extent = {{9, -6}, {-9, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_grid(k = -1) annotation(
    Placement(visible = true, transformation(origin = {156, -206}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_h annotation(
    Placement(visible = true, transformation(origin = {180, -160}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression grid_Preal(y = grid.P.real) annotation(
    Placement(visible = true, transformation(origin = {180, -207}, extent = {{10, -7}, {-10, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_eb_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {104, -178}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_c_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {123, -157}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter lim_grid(limitsAtInit = true, uMax = 100000, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {138, -206}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_eb(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {130, -178}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {184, -176}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Max E_g_filt annotation(
    Placement(visible = true, transformation(origin = {101, -164}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression vent_power(y = 0.33 ^ 3 * 3.3 * 4 + 6.2 * 3 / 3 / 24) annotation(
    Placement(visible = true, transformation(origin = {-139, -187}, extent = {{7, -5}, {-7, 5}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum power_total(nu = 4) annotation(
    Placement(visible = true, transformation(origin = {-155, -165}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {107, -101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integratorvent annotation(
    Placement(visible = true, transformation(origin = {182, -98}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_g_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {176, -192}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_f_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {96, -206}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
equation
//Connections
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{84, 186}, {84, 163}, {246, 163}, {246, -220}, {18, -220}, {18, -184}, {32, -184}}, color = {255, 204, 51}, thickness = 0.5));
 connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 121}, {-104, 121}, {-104, 115}, {-96, 115}}, color = {0, 127, 255}));
 connect(Wasseranschluss.ports[1], val12.port_b) annotation(
    Line(points = {{-110, 95}, {-102, 95}, {-102, 96}, {-94, 96}}, color = {0, 127, 255}));
  connect(heaPum.port_b2, Quelle_Puffer.port_a1) annotation(
    Line(points = {{-38, -17}, {-42, -17}, {-42, -77}, {-23, -77}}, color = {0, 127, 255}));
  connect(T_QP1.port_1, Quelle_Puffer.port_HX_1_b) annotation(
    Line(points = {{-26, -92}, {-26, -87}, {-6, -87}, {-6, -86}, {-4.5, -86}, {-4.5, -74}, {-9, -74}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_HX_1_a, val7.port_a) annotation(
    Line(points = {{-9, -72}, {2, -72}}, color = {0, 127, 255}));
  connect(val7.port_b, T_QP2.port_2) annotation(
    Line(points = {{10, -72}, {22, -72}}, color = {0, 127, 255}));
  connect(T_QP1.port_3, val8.port_a) annotation(
    Line(points = {{-22, -96}, {2, -96}}, color = {0, 127, 255}));
  connect(val8.port_b, T_QP2.port_3) annotation(
    Line(points = {{10, -96}, {26, -96}, {26, -76}}, color = {0, 127, 255}));
  connect(constant3.y, max.u2) annotation(
    Line(points = {{114, -88}, {111.7, -88}, {111.7, -77}, {111, -77}}, color = {0, 0, 127}));
  connect(JAZ.u2, max.y) annotation(
    Line(points = {{111, -52}, {116.5, -52}, {116.5, -65.4}, {93.2, -65.4}, {93.2, -74}, {99.5, -74}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.y, JAZ.u1) annotation(
    Line(points = {{143.4, -48}, {124.8, -48}, {124.8, -44}, {111, -44}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.u, limiter1.y) annotation(
    Line(points = {{157.2, -48}, {169.2, -48}}, color = {0, 0, 127}));
  connect(integrator_WP_El.u, limiter.y) annotation(
    Line(points = {{159.2, -68}, {165.2, -68}, {165.2, -74}, {171.2, -74}}, color = {0, 0, 127}));
  connect(limiter1.u, heaPum.QLoa_flow) annotation(
    Line(points = {{185, -48}, {190, -48}, {190, -8}, {-3, -8}, {-3, 1}, {-9, 1}}, color = {0, 0, 127}));
  connect(limiter.u, heaPum.P) annotation(
    Line(points = {{185, -74}, {192, -74}, {192, -10}, {-9, -10}}, color = {0, 0, 127}));
 connect(gain1.u, HDU.y[10]) annotation(
    Line(points = {{-51, 125}, {-44, 125}, {-44, 188}, {-7, 188}}, color = {0, 0, 127}));
 connect(gain1.y, pump_TWW.m_flow_in) annotation(
    Line(points = {{-66.7, 125}, {-78.7, 125}, {-78.7, 121}, {-90.7, 121}}, color = {0, 0, 127}));
 connect(greaterEqualThreshold2.y, booleanToReal.u) annotation(
    Line(points = {{-164.8, 136}, {-174.3, 136}, {-174.3, 105}, {-154.8, 105}}, color = {255, 0, 255}));
 connect(gain1.y, greaterEqualThreshold2.u) annotation(
    Line(points = {{-66.7, 125}, {-66.7, 136}, {-145.7, 136}}, color = {0, 0, 127}));
 connect(booleanToReal.y, val12.y) annotation(
    Line(points = {{-143.5, 105}, {-150, 105}, {-150, 82}, {-90, 82}, {-90, 91}}, color = {0, 0, 127}));
 connect(val12.port_a, TWW.port_a1) annotation(
    Line(points = {{-86, 96}, {-75, 96}, {-75, 95}, {-55, 95}}, color = {0, 127, 255}));
 connect(pump_TWW.port_a, TWW.port_b1) annotation(
    Line(points = {{-86, 115}, {-70.5, 115}, {-70.5, 113}, {-55, 113}}, color = {0, 127, 255}));
 connect(temperature_floor_heat.port_a, mixingVolume.ports[1]) annotation(
    Line(points = {{120, 137}, {94, 137}, {94, 138}, {36, 138}}, color = {0, 127, 255}));
 connect(teeJunctionIdeal.port_1, mixingVolume.ports[2]) annotation(
    Line(points = {{-58, 13}, {0, 13}, {0, 138}, {36, 138}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.T[2], add_solCol.u2) annotation(
    Line(points = {{-23, -62}, {-27.4, -62}, {-27.4, -40}, {33, -40}}, color = {0, 0, 127}));
  connect(add_solCol.y, hysteresis_solCol.u) annotation(
    Line(points = {{44.5, -43}, {51, -43}}, color = {0, 0, 127}));
  connect(hysteresis_solCol.y, btr_solCol.u) annotation(
    Line(points = {{62.5, -43}, {69, -43}}, color = {255, 0, 255}));
  connect(btr_solCol.y, add2_solCol.u1) annotation(
    Line(points = {{79.5, -43}, {82, -43}, {82, -56}, {53, -56}}, color = {0, 0, 127}));
  connect(const_solCol.y, add2_solCol.u2) annotation(
    Line(points = {{60, -64}, {57.5, -64}, {57.5, -62}, {53, -62}}, color = {0, 0, 127}));
  connect(btr_solCol.y, val7.y) annotation(
    Line(points = {{79.5, -43}, {82, -43}, {82, -80}, {19, -80}, {19, -77}, {6, -77}}, color = {0, 0, 127}));
  connect(val8.y, add2_solCol.y) annotation(
    Line(points = {{6, -91}, {19.375, -91}, {19.375, -91.2}, {36.75, -91.2}, {36.75, -59}, {41.5, -59}}, color = {0, 0, 127}));
 connect(hyst_TWW.y, not_TWW.u) annotation(
    Line(points = {{-143.5, 65}, {-139, 65}}, color = {255, 0, 255}));
 connect(HDU.y[3], gain_FH.u) annotation(
    Line(points = {{-7, 188}, {-20, 188}, {-20, 148}, {6, 148}, {6, 116}, {20, 116}}, color = {0, 0, 127}));
 connect(gain_FH.y, HeatPower.Q_flow) annotation(
    Line(points = {{38.8, 116}, {42.6, 116}, {42.6, 125}, {47.8, 125}}, color = {0, 0, 127}));
 connect(HeatPower.port, mixingVolume.heatPort) annotation(
    Line(points = {{66, 125}, {72, 125}, {72, 144}, {30, 144}}, color = {191, 0, 0}));
  connect(heaPum.port_a2, pump_HP_sou.port_b) annotation(
    Line(points = {{-10, -17}, {-3, -17}, {-3, -18}, {4, -18}}, color = {0, 127, 255}));
  connect(pump_HP_sou.port_a, MAG_HP_sou.ports[1]) annotation(
    Line(points = {{16, -18}, {26, -18}, {26, -20}, {32, -20}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_a2, pump_HP_sou.port_a) annotation(
    Line(points = {{-9, -59}, {6.5, -59}, {6.5, -47}, {16, -47}, {16, -18}}, color = {0, 127, 255}));
 connect(T_QP1.port_2, pump_solCol.port_a) annotation(
    Line(points = {{-26, -100}, {-26, -174}}, color = {0, 127, 255}));
 connect(thermalCollector.port_b, Temp_Out_solCol.port_b) annotation(
    Line(points = {{48, -174}, {52, -174}}, color = {0, 127, 255}));
 connect(T_QP2.port_1, Temp_Out_solCol.port_a) annotation(
    Line(points = {{30, -72}, {70, -72}, {70, -174}, {66, -174}}, color = {0, 127, 255}));
 connect(pump_solCol.port_b, Temp_In_solCol.port_b) annotation(
    Line(points = {{-14, -174}, {-4, -174}}, color = {0, 127, 255}));
 connect(MAG_solCol.ports[1], pump_solCol.port_a) annotation(
    Line(points = {{-34, -166}, {-31, -166}, {-31, -174}, {-26, -174}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_3, Temp_In_HP.port_a) annotation(
    Line(points = {{-63, 8}, {-63, -8}, {-62, -8}}, color = {0, 127, 255}));
  connect(Temp_In_HP.port_b, heaPum.port_a1) annotation(
    Line(points = {{-52, -8}, {-48, -8}, {-48, -3}, {-38, -3}}, color = {0, 127, 255}));
  connect(heaPum.port_b1, Temp_HP_Out.port_a) annotation(
    Line(points = {{-10, -2}, {-4, -2}, {-4, 1}, {8, 1}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_1, MAG_HP_loa.ports[1]) annotation(
    Line(points = {{64, 17}, {60, 17}, {60, 22}, {18, 22}, {18, 18}}, color = {0, 127, 255}));
 connect(TWW.T[5], hyst_TWW.u) annotation(
    Line(points = {{-55.4, 110}, {-64.4, 110}, {-64.4, 76}, {-158.4, 76}, {-158.4, 65}, {-155.4, 65}}, color = {0, 0, 127}));
 connect(massflow_HP_loa.y, prod_mflow_FH.u1) annotation(
    Line(points = {{80.4, 92}, {90.4, 92}, {90.4, 96}, {102.4, 96}}, color = {0, 0, 127}));
 connect(hyst_FH.y, not_FH.u) annotation(
    Line(points = {{34.5, 85}, {39, 85}}, color = {255, 0, 255}));
 connect(not_FH.y, btr_FH.u) annotation(
    Line(points = {{50.5, 85}, {56.5, 85}, {56.5, 107}, {61, 107}}, color = {255, 0, 255}));
 connect(btr_FH.y, prod_mflow_FH.u2) annotation(
    Line(points = {{72.5, 107}, {76.5, 107}, {76.5, 102}, {102, 102}}, color = {0, 0, 127}));
  connect(prod_mflow_HPsou.u2, massflow_HP_sou.y) annotation(
    Line(points = {{-58, -48}, {-70, -48}}, color = {0, 0, 127}));
  connect(integerToReal.y, prod_mflow_HPsou.u1) annotation(
    Line(points = {{-70, -72}, {-63.6, -72}, {-63.6, -54}, {-58, -54}}, color = {0, 0, 127}));
  connect(Temp_HP_Out.port_b, mixingVolume1.ports[1]) annotation(
    Line(points = {{18, 1}, {25, 1}, {25, 16}, {42, 16}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_1, mixingVolume1.ports[2]) annotation(
    Line(points = {{64, 17}, {42, 17}, {42, 16}}, color = {0, 127, 255}));
  connect(prod_eheat_TWW.u2, Eheater_pow.y) annotation(
    Line(points = {{136, 12}, {136, 26}, {156, 26}}, color = {0, 0, 127}));
  connect(Eheater_HP.port, mixingVolume1.heatPort) annotation(
    Line(points = {{80, 1}, {60, 1}, {60, 10}, {48, 10}}, color = {191, 0, 0}));
  connect(Eheater_HP.Q_flow, prod_eheat_TWW.y) annotation(
    Line(points = {{98, 1}, {113.25, 1}, {113.25, 9}, {124.5, 9}}, color = {0, 0, 127}));
  connect(bti_HP.y, heaPum.uMod) annotation(
    Line(points = {{-99, -50}, {-88, -50}, {-88, -24}, {-46, -24}, {-46, -10}, {-40, -10}}, color = {255, 127, 0}));
  connect(bti_HP.u, and_HP.y) annotation(
    Line(points = {{-113.2, -50}, {-121.2, -50}}, color = {255, 0, 255}));
  connect(bti_HP.y, integerToReal.u) annotation(
    Line(points = {{-99, -50}, {-89, -50}, {-89, -72}, {-79, -72}}, color = {255, 127, 0}));
  connect(and_Eheater.y, btr_Eheater.u) annotation(
    Line(points = {{-117, -96}, {-94.5, -96}, {-94.5, -104}, {170, -104}, {170, 5}, {161, 5}}, color = {255, 0, 255}));
  connect(btr_Eheater.y, prod_eheat_TWW.u1) annotation(
    Line(points = {{149.5, 5}, {142, 5}, {142, 6}, {136, 6}}, color = {0, 0, 127}));
 connect(add_solCol.u1, Temp_Out_solCol.T) annotation(
    Line(points = {{33, -46}, {74, -46}, {74, -92}, {59, -92}, {59, -167}}, color = {0, 0, 127}));
  connect(max.u1, add.y) annotation(
    Line(points = {{111, -71}, {125.5, -71}}, color = {0, 0, 127}));
  connect(add.u1, integrator_WP_El.y) annotation(
    Line(points = {{137, -68}, {145, -68}}, color = {0, 0, 127}));
  connect(add.u2, integrator.y) annotation(
    Line(points = {{137, -74}, {141, -74}, {141, -88}, {147, -88}}, color = {0, 0, 127}));
  connect(integrator.u, prod_eheat_TWW.y) annotation(
    Line(points = {{161, -88}, {162, -88}, {162, -24}, {124.5, -24}, {124.5, 9}}, color = {0, 0, 127}));
 connect(pump_solCol.m_flow_in, massflow_solCol.y) annotation(
    Line(points = {{-20, -181.2}, {-54, -181.2}, {-54, -162}, {-66, -162}}, color = {0, 0, 127}));
 connect(btr_TWW.y, product_contHP.u2) annotation(
    Line(points = {{-89.5, 59}, {-86, 59}, {-86, 34}, {-172, 34}, {-172, 24}, {-163, 24}}, color = {0, 0, 127}));
  connect(Tset_TWW.y, product_contHP.u1) annotation(
    Line(points = {{-176, 20}, {-163, 20}}, color = {0, 0, 127}));
  connect(product_contHP.y, max_contHP.u1) annotation(
    Line(points = {{-154, 22}, {-150, 22}, {-150, 12}, {-141, 12}}, color = {0, 0, 127}));
 connect(btr_TWW.y, gain_TWW.u) annotation(
    Line(points = {{-89.5, 59}, {-76.5, 59}}, color = {0, 0, 127}));
 connect(gain_TWW.y, pump_HP_TWW.m_flow_in) annotation(
    Line(points = {{-63.4, 60}, {-23.4, 60}, {-23.4, 100}}, color = {0, 0, 127}));
  connect(Tset_FH.y, max_contHP.u2) annotation(
    Line(points = {{-170, -2}, {-166, -2}, {-166, 6}, {-141, 6}}, color = {0, 0, 127}));
  connect(max_contHP.y, heaPum.TSet) annotation(
    Line(points = {{-129.5, 9}, {-94, 9}, {-94, 0}, {-40, 0}}, color = {0, 0, 127}));
  connect(Temp_In_HP.T, add_contHP.u2) annotation(
    Line(points = {{-56, -14}, {-56, -16}, {-80, -16}, {-80, -4}, {-100, -4}, {-100, 6}, {-124, 6}, {-124, -2}, {-119, -2}}, color = {0, 0, 127}));
  connect(add_contHP.y, hyst_contHP.u) annotation(
    Line(points = {{-107.5, -5}, {-103.5, -5}, {-103.5, -15}, {-145, -15}}, color = {0, 0, 127}));
  connect(max_contHP.y, add_contHP.u1) annotation(
    Line(points = {{-129.5, 9}, {-129.5, -9}, {-117.5, -9}}, color = {0, 0, 127}));
  connect(hyst_contHP.y, and1.u2) annotation(
    Line(points = {{-156.5, -15}, {-166, -15}, {-166, -37}, {-163, -37}}, color = {255, 0, 255}));
  connect(or1.y, and1.u1) annotation(
    Line(points = {{-169.4, -42}, {-163.4, -42}}, color = {255, 0, 255}));
 connect(pump_HP_FH.port_b, temperature_floor_heat.port_b) annotation(
    Line(points = {{171, 91}, {169, 91}, {169, 136}, {129, 136}}, color = {0, 127, 255}));
  connect(and_Eheater.u2, not_temp_sou.y) annotation(
    Line(points = {{-131.2, -91.2}, {-141.2, -91.2}, {-141.2, -73.2}, {-133.2, -73.2}}, color = {255, 0, 255}));
  connect(not_temp_sou.u, hysteresis.y) annotation(
    Line(points = {{-123, -75}, {-115, -75}, {-115, -85}, {-104.5, -85}}, color = {255, 0, 255}));
  connect(and_HP.u1, hysteresis.y) annotation(
    Line(points = {{-135.2, -50}, {-141.2, -50}, {-141.2, -66}, {-109.2, -66}, {-109.2, -85}, {-104.5, -85}}, color = {255, 0, 255}));
 connect(pump_HP_FH.m_flow_in, sw_FH.y) annotation(
    Line(points = {{161.4, 84}, {155.4, 84}, {155.4, 83}, {150.4, 83}}, color = {0, 0, 127}));
 connect(gain_TWW.y, gr_FH.u) annotation(
    Line(points = {{-63.4, 60}, {21.6, 60}, {21.6, 63}, {70.6, 63}}, color = {0, 0, 127}));
 connect(prod_mflow_FH.y, sw_FH.u3) annotation(
    Line(points = {{113.5, 99}, {121.5, 99}, {121.5, 87}, {133.5, 87}}, color = {0, 0, 127}));
 connect(sw_FH.u1, constant2.y) annotation(
    Line(points = {{134.6, 77.4}, {132.6, 77.4}, {132.6, 55.4}, {126.6, 55.4}}, color = {0, 0, 127}));
 connect(not_FH.y, and2.u2) annotation(
    Line(points = {{50.5, 85}, {64, 85}, {64, 78}, {104, 78}}, color = {255, 0, 255}));
 connect(gr_FH.y, and2.u1) annotation(
    Line(points = {{86.7, 63}, {97.7, 63}, {97.7, 74}, {103.7, 74}}, color = {255, 0, 255}));
 connect(and2.y, sw_FH.u2) annotation(
    Line(points = {{118.6, 74}, {122.6, 74}, {122.6, 84}, {134.6, 84}}, color = {255, 0, 255}));
  connect(hysteresis.u, Quelle_Puffer.T[4]) annotation(
    Line(points = {{-93, -85}, {-54.5, -85}, {-54.5, -73}, {-28, -73}, {-28, -62}, {-23, -62}}, color = {0, 0, 127}));
 connect(Temp_In_solCol.port_a, thermalCollector.port_a) annotation(
    Line(points = {{10, -174}, {28, -174}}, color = {0, 127, 255}));
 connect(teeJunctionIdeal1.port_2, pump_HP_FH.port_a) annotation(
    Line(points = {{74, 17}, {90, 17}, {90, 38}, {171, 38}, {171, 77}}, color = {0, 127, 255}));
 connect(pump_HP_TWW.port_a, teeJunctionIdeal1.port_3) annotation(
    Line(points = {{-16, 110}, {-12, 110}, {-12, 36}, {69, 36}, {69, 22}}, color = {0, 127, 255}));
 connect(pVSimpleOriented.P, batteryControl.PV_power) annotation(
    Line(points = {{25, -193}, {-74, -193}, {-74, -185}, {-128.5, -185}, {-128.5, -179}, {-119, -179}}, color = {0, 0, 127}));
 connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{-156, -200}, {-138, -200}, {-138, -206}, {-118, -206}}));
 connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{-176, -200}, {-198, -200}, {-198, 180}, {-84, 180}}));
 connect(bat.SOC, batteryControl.SOC) annotation(
    Line(points = {{-97, -200}, {-87, -200}, {-87, -154}, {-135, -154}, {-135, -167}, {-119, -167}}, color = {0, 0, 127}));
 connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{46, -200}, {71, -200}, {71, -214}, {-143.5, -214}, {-143.5, -200}, {-156, -200}}));
 connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{-192, -166}, {-192, -129.75}, {-194, -129.75}, {-194, -129.5}, {-198, -129.5}, {-198, 179}, {-84, 179}, {-84, 180}}));
 connect(batteryControl.P, bat.P) annotation(
    Line(points = {{-99.4375, -170}, {-92.4375, -170}, {-92.4375, -188}, {-108.438, -188}, {-108.438, -196}}, color = {0, 0, 127}));
  connect(weaDat1.weaBus, pVSimpleOriented.weaBus);
  connect(calTim.hour, itr_time.u) annotation(
    Line(points = {{-179, -96}, {-174, -96}, {-174, -97}, {-175, -97}}, color = {255, 127, 0}));
  connect(itr_time.y, gre_time.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-190, -88}, {-190, -78}, {-180, -78}}, color = {0, 0, 127}));
  connect(pump_HP_sou.m_flow_in, prod_mflow_HPsou.y) annotation(
    Line(points = {{10, -26}, {10, -36}, {-40, -36}, {-40, -50}, {-46, -50}}, color = {0, 0, 127}));
 connect(mixingVolume.ports[3], Temp_FH.port) annotation(
    Line(points = {{36, 138}, {36, 132}, {10, 132}, {10, 90}}, color = {0, 127, 255}));
  connect(and_time.y, and3.u1) annotation(
    Line(points = {{-150, -78}, {-148, -78}, {-148, -70}, {-164, -70}, {-164, -61}, {-161, -61}}, color = {255, 0, 255}));
  connect(and3.u2, and1.y) annotation(
    Line(points = {{-161, -57}, {-164, -57}, {-164, -54}, {-148, -54}, {-148, -42}, {-150, -42}}, color = {255, 0, 255}));
  connect(gre_time.y, and_time.u1) annotation(
    Line(points = {{-170, -78}, {-160, -78}}, color = {255, 0, 255}));
  connect(and3.y, and_HP.u2) annotation(
    Line(points = {{-150, -60}, {-144, -60}, {-144, -46}, {-136, -46}}, color = {255, 0, 255}));
  connect(and3.y, and_Eheater.u1) annotation(
    Line(points = {{-150, -60}, {-144, -60}, {-144, -96}, {-132, -96}}, color = {255, 0, 255}));
  connect(itr_time.y, less_time.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-190, -88}, {-190, -60}, {-180, -60}}, color = {0, 0, 127}));
  connect(less_time.y, and_time.u2) annotation(
    Line(points = {{-170, -60}, {-168, -60}, {-168, -74}, {-160, -74}}, color = {255, 0, 255}));
 connect(Temp_FH.T, hyst_FH.u) annotation(
    Line(points = {{12.5, 86}, {24.5, 86}}, color = {0, 0, 127}));
 connect(itr_time.y, gre_TWW.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-192, -88}, {-192, 53}, {-181, 53}}, color = {0, 0, 127}));
 connect(itr_time.y, less_TWW.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-192, -88}, {-192, 69}, {-181, 69}}, color = {0, 0, 127}));
 connect(not_TWW.y, and_TWW2.u2) annotation(
    Line(points = {{-127.5, 65}, {-121, 65}}, color = {255, 0, 255}));
 connect(and_TWW2.y, btr_TWW.u) annotation(
    Line(points = {{-109.5, 61}, {-106, 61}, {-106, 59}, {-101, 59}}, color = {255, 0, 255}));
 connect(and_TWW2.u1, and_TWW1.y) annotation(
    Line(points = {{-121, 61}, {-123, 61}, {-123, 53}, {-129, 53}}, color = {255, 0, 255}));
 connect(and_TWW2.y, or1.u1) annotation(
    Line(points = {{-109.5, 61}, {-106, 61}, {-106, 38}, {-96, 38}, {-96, -32}, {-184, -32}, {-184, -42}}, color = {255, 0, 255}));
 connect(and_TWW1.u1, gre_TWW.y) annotation(
    Line(points = {{-139, 53}, {-171, 53}}, color = {255, 0, 255}));
 connect(and_TWW1.u2, less_TWW.y) annotation(
    Line(points = {{-139, 57}, {-167, 57}, {-167, 69}, {-171, 69}}, color = {255, 0, 255}));
 connect(not_FH_T.u, hyst_FH_T.y) annotation(
    Line(points = {{97, 125}, {105, 125}}, color = {255, 0, 255}));
 connect(hyst_FH_T.u, temperature_floor_heat.T) annotation(
    Line(points = {{117, 125}, {125, 125}, {125, 131}}, color = {0, 0, 127}));
 connect(not_FH_T.y, or1.u2) annotation(
    Line(points = {{85.5, 125}, {82, 125}, {82, -32}, {-186, -32}, {-186, -46}, {-184, -46}}, color = {255, 0, 255}));
 connect(RL.Pow, gain_el.y) annotation(
    Line(points = {{-176, -166}, {-172, -166}, {-172, -176}, {-182, -176}, {-182, -184}, {-176, -184}, {-176, -182}}, color = {0, 0, 127}));
 connect(pump_HP_TWW.port_b, TWW.port_HX_1_a) annotation(
    Line(points = {{-30, 110}, {-34, 110}, {-34, 100}, {-40, 100}}, color = {0, 127, 255}));
 connect(TWW.port_HX_1_b, teeJunctionIdeal.port_2) annotation(
    Line(points = {{-41, 98}, {-34, 98}, {-34, 26}, {-74, 26}, {-74, 14}, {-68, 14}}, color = {0, 127, 255}));
 connect(gain_grid.y, lim_grid.u) annotation(
    Line(points = {{149.4, -206}, {145.4, -206}}, color = {0, 0, 127}));
 connect(E_eb_kwh.u, E_eb.y) annotation(
    Line(points = {{111.2, -178}, {123.2, -178}}, color = {0, 0, 127}));
 connect(E_c.y, E_c_kwh.u) annotation(
    Line(points = {{147.4, -164}, {141.5, -164}, {141.5, -157}, {129.4, -157}}, color = {0, 0, 127}));
 connect(E_g.y, E_eb.u2) annotation(
    Line(points = {{145.4, -182}, {137.4, -182}}, color = {0, 0, 127}));
 connect(lim_grid.y, E_f.u) annotation(
    Line(points = {{131.4, -206}, {123.4, -206}}, color = {0, 0, 127}));
 connect(E_c.u1, E_h.y) annotation(
    Line(points = {{161.2, -160.4}, {173.2, -160.4}}, color = {0, 0, 127}));
 connect(E_c.y, E_eb.u1) annotation(
    Line(points = {{147.4, -164}, {139.4, -164}, {139.4, -174}, {137.4, -174}}, color = {0, 0, 127}));
 connect(gain_grid.u, grid_Preal.y) annotation(
    Line(points = {{163.2, -206}, {169.4, -206}, {169.4, -207}}, color = {0, 0, 127}));
 connect(pVSimpleOriented.P, E_g.u) annotation(
    Line(points = {{25, -193}, {25, -191}, {163, -191}, {163, -183}, {159, -183}}, color = {0, 0, 127}));
 connect(HDU.y[9], E_h.u) annotation(
    Line(points = {{-7, 188}, {-10, 188}, {-10, 152}, {242, 152}, {242, -128}, {190.5, -128}, {190.5, -158}, {193.375, -158}, {193.375, -160}, {187, -160}}, color = {0, 0, 127}));
 connect(E_g_filt.u2, E_g.y) annotation(
    Line(points = {{107, -167}, {141, -167}, {141, -183}, {145, -183}}, color = {0, 0, 127}));
 connect(E_g_filt.u1, constant1.y) annotation(
    Line(points = {{107, -161}, {113, -161}, {113, -173}, {173, -173}, {173, -177}, {179, -177}}, color = {0, 0, 127}));
 connect(gain_el.u, power_total.y) annotation(
    Line(points = {{-160.6, -183}, {-156.6, -183}, {-156.6, -173}, {-166.6, -173}, {-166.6, -165}, {-160.6, -165}}, color = {0, 0, 127}));
 connect(vent_power.y, power_total.u[1]) annotation(
    Line(points = {{-146.7, -187}, {-150.7, -187}, {-150.7, -177}, {-142.7, -177}, {-142.7, -165}, {-150.7, -165}}, color = {0, 0, 127}));
  connect(add.y, add1.u1) annotation(
    Line(points = {{126, -70}, {126, -98}, {114, -98}}, color = {0, 0, 127}));
  connect(add1.u2, integratorvent.y) annotation(
    Line(points = {{114, -104}, {170, -104}, {170, -98}, {176, -98}}, color = {0, 0, 127}));
 connect(add1.y, E_c.u2) annotation(
    Line(points = {{102, -100}, {98, -100}, {98, -106}, {166, -106}, {166, -168}, {161, -168}}, color = {0, 0, 127}));
 connect(vent_power.y, integratorvent.u) annotation(
    Line(points = {{-147, -187}, {-142, -187}, {-142, -140}, {192, -140}, {192, -98}, {190, -98}}, color = {0, 0, 127}));
 connect(prod_eheat_TWW.y, power_total.u[2]) annotation(
    Line(points = {{124, 10}, {124, -24}, {88, -24}, {88, -112}, {-144, -112}, {-144, -165}, {-150, -165}}, color = {0, 0, 127}));
 connect(heaPum.P, power_total.u[3]) annotation(
    Line(points = {{-8, -10}, {86, -10}, {86, -114}, {-142, -114}, {-142, -165}, {-150, -165}}, color = {0, 0, 127}));
 connect(HDU.y[9], power_total.u[4]) annotation(
    Line(points = {{-7, 188}, {-58, 188}, {-58, 176}, {-196, 176}, {-196, -112}, {-148, -112}, {-148, -165}, {-150, -165}}, color = {0, 0, 127}));
 connect(power_total.y, batteryControl.power_cons) annotation(
    Line(points = {{-160.85, -165}, {-162.85, -165}, {-162.85, -175}, {-120.85, -175}}, color = {0, 0, 127}));
 connect(E_g.y, E_g_kwh.u) annotation(
    Line(points = {{145.4, -182}, {143.4, -182}, {143.4, -192}, {167.4, -192}}, color = {0, 0, 127}));
 connect(E_f.y, E_f_kwh.u) annotation(
    Line(points = {{109.4, -206}, {103.4, -206}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {-10, 198}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-124, 30}, {124, -30}}), Rectangle(origin = {-126, 99}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{122, -57}, {-122, 57}}), Rectangle(origin = {125, 99}, fillColor = {255, 166, 187}, fillPattern = FillPattern.Solid, extent = {{125, -57}, {-125, 57}}), Rectangle(origin = {83, 6}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{165, -34}, {-165, 34}}), Rectangle(origin = {-166, -77}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-82, 47}, {82, -47}}), Rectangle(origin = {1, -171}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{83, -45}, {-83, 45}}), Rectangle(origin = {167, -77}, fillColor = {204, 142, 255}, fillPattern = FillPattern.Solid, extent = {{-81, 47}, {81, -47}}), Rectangle(origin = {1, -77}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{83, -47}, {-83, 47}}), Rectangle(origin = {-166, 6}, fillColor = {207, 207, 207}, fillPattern = FillPattern.Solid, extent = {{-82, 34}, {82, -34}}), Rectangle(origin = {-166, -171}, fillColor = {223, 223, 0}, fillPattern = FillPattern.Solid, extent = {{82, -45}, {-82, 45}}), Rectangle(origin = {167, -171}, fillColor = {255, 170, 0}, fillPattern = FillPattern.Solid, extent = {{-81, 45}, {81, -45}}), Text(origin = {-84, 213}, lineThickness = 0.5, extent = {{-28, 1}, {28, -1}}, textString = "Grid", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {75, 213}, lineThickness = 0.5, extent = {{-77, 1}, {77, -1}}, textString = "Weather", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {1, 213}, lineThickness = 0.5, extent = {{-77, 1}, {77, -1}}, textString = "Building", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {206, 121}, lineThickness = 0.5, extent = {{-44, 1}, {44, -1}}, textString = "Floor heating", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {-99, 148}, lineThickness = 0.5, extent = {{51, 4}, {-51, -4}}, textString = "Domestic hot water", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {-223, 7}, lineThickness = 0.5, extent = {{45, 5}, {-45, -5}}, textString = "Heat pump 
set point", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {-223, -65}, lineThickness = 0.5, extent = {{63, 3}, {-63, -3}}, textString = "Heat pump \ncontroller", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {216, -178}, lineThickness = 0.5, extent = {{-52, 0}, {52, 0}}, textString = "Building\nperformance", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {214, -96}, lineThickness = 0.5, extent = {{-60, -2}, {60, 0}}, textString = "Heat pump \nperformance", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {206, 17}, lineThickness = 0.5, extent = {{-44, 1}, {44, -1}}, textString = "Heat pump", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {12, -119}, lineThickness = 0.5, extent = {{-44, 1}, {44, -1}}, textString = "Buffer tank", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {-171, -227}, lineThickness = 0.5, extent = {{-69, 1}, {69, -1}}, textString = "Inverter, battery and EMS", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold}), Text(origin = {6, -147}, lineThickness = 0.5, extent = {{-44, 1}, {44, -1}}, textString = "PVT System", fontSize = 12, fontName = "IBM Plex Serif", textStyle = {TextStyle.Bold})}, coordinateSystem(extent = {{-250, -250}, {250, 250}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-6, Interval = 3600),
    Documentation(info = "<html><p>
This model calculates the whole energy balance of the House Demonstration Unit for a full year, both thermal and electrical. List of assumptions:</p>
<li>
Building thermal model from the ISO 13709 (5R1C) from SimRoom simulation. 
</li>
<li>
Electrical energy consumption of appliances was obtained from the BDEW load profiles. 
</li>
<li>
Domestic hot water consumption assumed from DHWcalc. 
</li>
<li>
Self-developed control strategies to maximize the seasonal COP of the heat pump and optimize battery charging strategy. 
</li>
<p> A schematic overview of the simnulated model is shown below.</p>
<p align=\"center\">
<img alt=\"image\"
src=\"modelica://RoofKIT/Resources/Images/HDU_Full_model.png\"/>
</p>
</html>", revisions = "<html>
<ul>
<li>
February 28, 2022 by Nicolas Carbonare:<br/>
Joined together thermal and electrical models. Completed documentation and parametrization. Model working.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-250, -250}, {250, 250}})));
end HDU_Full;
