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
    Placement(visible = true, transformation(origin = {54, 166}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {109, 21}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  Buildings.Fluid.Sources.Boundary_pT MAG_solCol(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-38, -130}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {-24, -10}, extent = {{-14, -12}, {14, 12}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_sou(redeclare replaceable package Medium = Medium_sou, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {10, -18}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_TWW(redeclare replaceable package Medium = Medium_loa, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {-23, 100}, extent = {{7, 8}, {-7, -8}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_HP_FH(redeclare replaceable package Medium = Medium_loa, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {171, 74}, extent = {{7, 8}, {-7, -8}}, rotation = -90)));
  Buildings.Fluid.Sources.Boundary_pT MAG_HP_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {14, 18}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_HP_loa(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {76, 82}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-74, -72}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 1.62 * 12, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, lat = 0.8946, m_flow_nominal = 60 / 3600 * 12, til = 0.21, volSol = 0.00154 * 12) annotation(
    Placement(visible = true, transformation(origin = {38, -138}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_In_HP(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-57, -9}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_Out_solCol(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {59, -138}, extent = {{-7, 6}, {7, -6}}, rotation = 180)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_heat, redeclare package Medium_HX_1 = Medium_heat, redeclare package Medium_HX_2 = Medium_loa, HX_1 = true, HX_2 = false, T_start = 50 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 20000, V = 0.185, height = 0.5, nEle = 5, thickness_ins = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-48, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_heat, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 111}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_heat, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 85}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {-63, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal1(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {69, 17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val12(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 86}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_TWW(uHigh = 45 + 273.15, uLow = 41 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-149, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage Quelle_Puffer(redeclare package Medium = Medium_sou, redeclare package Medium_HX_1 = Medium_sou, redeclare package Medium_HX_2 = Medium_sou, HX_1 = true, HX_2 = false, T_start = 30 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 20000, V = 1.0, height = 1.5, nEle = 5, thickness_ins = 0.15, thickness_wall = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-10, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_solCol(redeclare replaceable package Medium = Medium_sou, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-20, -138}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT MAG_HP_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {36, -20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_solCol(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {85, -63}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis_solCol(uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {103, -63}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium = Medium_sou, CvData = Buildings.Fluid.Types.CvTypes.OpPoint, dpValve_nominal = 600, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -66}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val8(redeclare package Medium = Medium_sou, dpValve_nominal = 600, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -92}, extent = {{4, 4}, {-4, -4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP1(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {6, -92}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP2(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {38, -66}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal btr_solCol annotation(
    Placement(visible = true, transformation(origin = {121, -63}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2_solCol(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {103, -87}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const_solCol(k = 1) annotation(
    Placement(visible = true, transformation(origin = {144, -90}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_In_solCol(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {3, -138}, extent = {{-7, 6}, {7, -6}}, rotation = 180)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 1500, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {178, -154}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {103, -158}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_Th annotation(
    Placement(visible = true, transformation(origin = {150, -128}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division JAZ annotation(
    Placement(visible = true, transformation(origin = {103, -135}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_El annotation(
    Placement(visible = true, transformation(origin = {152, -148}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {120, -170}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 10000, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {178, -128}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_solCol(k = mSolCol_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-70, -126}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable HDU(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/HDU/HDU_input.txt", table = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tableName = "HDU", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {4, 168}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_FH(k = -54) annotation(
    Placement(visible = true, transformation(origin = {30, 106}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / 3600) annotation(
    Placement(visible = true, transformation(origin = {-61, 121}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {-156, 130}, extent = {{8, 8}, {-8, -8}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-149, 95}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort Temp_HP_Out(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {13, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Eheater_HP annotation(
    Placement(visible = true, transformation(origin = {89, 1}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperature_floor_heat(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {125, 127}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_HP annotation(
    Placement(visible = true, transformation(origin = {-128, -50}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume1(redeclare package Medium = Medium_loa, V = 0.03, m_flow_nominal = mSou_flow_nominal, T_start = 35 + 273.15, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {42, 10}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Logical.Not not_temp_sou annotation(
    Placement(visible = true, transformation(origin = {-129, -75}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatPower annotation(
    Placement(visible = true, transformation(origin = {57, 115}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume(redeclare package Medium = Medium_loa, T_start = 35 + 273.15, V = 0.2, m_flow_nominal = mSou_flow_nominal, nPorts = 3) annotation(
    Placement(visible = true, transformation(origin = {36, 134}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_eheat_TWW annotation(
    Placement(visible = true, transformation(origin = {130, 9}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_TWW annotation(
    Placement(visible = true, transformation(origin = {-95, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_TWW annotation(
    Placement(visible = true, transformation(origin = {-133, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant massflow_HP_sou(k = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-74, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_mflow_FH annotation(
    Placement(visible = true, transformation(origin = {108, 89}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_FH annotation(
    Placement(visible = true, transformation(origin = {67, 97}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_FH(uHigh = 34 + 273.15, uLow = 32 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {29, 75}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_FH annotation(
    Placement(visible = true, transformation(origin = {45, 75}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_mflow_HPsou annotation(
    Placement(visible = true, transformation(origin = {-52, -51}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Eheater_pow(k = 3000) annotation(
    Placement(visible = true, transformation(origin = {178, 20}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-176, -42}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_Eheater annotation(
    Placement(visible = true, transformation(origin = {155, 5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_Eheater annotation(
    Placement(visible = true, transformation(origin = {-124, -96}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger bti_HP annotation(
    Placement(visible = true, transformation(origin = {-106, -50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator annotation(
    Placement(visible = true, transformation(origin = {154, -168}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {131, -153}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Tset_TWW(k = 273.15 + 45) annotation(
    Placement(visible = true, transformation(origin = {-180, 20}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product_contHP annotation(
    Placement(visible = true, transformation(origin = {-158, 22}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Math.Max max_contHP annotation(
    Placement(visible = true, transformation(origin = {-135, 9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_TWW(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-70, 50}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {143, 73}, extent = {{-7, 7}, {7, -7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gr_FH(threshold = 0.001) annotation(
    Placement(visible = true, transformation(origin = {79, 53}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = mLoa_flow_nominal / 5) annotation(
    Placement(visible = true, transformation(origin = {122, 46}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.And and2 annotation(
    Placement(visible = true, transformation(origin = {112, 64}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl batteryControl annotation(
    Placement(visible = true, transformation(origin = {-109, -134}, extent = {{-9, -10}, {9, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 16, V_nominal = 400, azi(displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {36, -164}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 220 / 220, eta = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-166, -164}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 480, f = 60) annotation(
    Placement(visible = true, transformation(origin = {-92, 178}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(origin = {-184, -130}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 9000000, SOC_start = 0.8, V_nominal = 110) annotation(
    Placement(visible = true, transformation(origin = {-108, -170}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Utilities.Time.CalendarTime calTim(day(start = 1), hour(start = 0), zerTim = Buildings.Utilities.Time.Types.ZeroTime.Custom) annotation(
    Placement(visible = true, transformation(origin = {-186, -100}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal itr_time annotation(
    Placement(visible = true, transformation(origin = {-169, -97}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gre_time(threshold = 5) annotation(
    Placement(visible = true, transformation(origin = {-175, -79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_time annotation(
    Placement(visible = true, transformation(origin = {-155, -79}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add_pow annotation(
    Placement(visible = true, transformation(origin = {-158, -130}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Buildings.Fluid.Sensors.Temperature Temp_FH(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {9, 76}, extent = {{-5, 4}, {5, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.And and3 annotation(
    Placement(visible = true, transformation(origin = {-155, -61}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less_time(threshold = 23) annotation(
    Placement(visible = true, transformation(origin = {-175, -61}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less_TWW(threshold = 17) annotation(
    Placement(visible = true, transformation(origin = {-175, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gre_TWW(threshold = 13) annotation(
    Placement(visible = true, transformation(origin = {-175, 43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW1 annotation(
    Placement(visible = true, transformation(origin = {-133, 43}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW2 annotation(
    Placement(visible = true, transformation(origin = {-115, 51}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_FH_T(uHigh = 34 + 273.15, uLow = 32 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {111, 115}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_FH_T annotation(
    Placement(visible = true, transformation(origin = {91, 115}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {-169, -147}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
equation
//Connections
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{64, 166}, {64, 165}, {198, 165}, {198, -124}, {79, -124}, {79, -148}, {32, -148}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 111}, {-104, 111}, {-104, 105}, {-96, 105}}, color = {0, 127, 255}));
  connect(Wasseranschluss.ports[1], val12.port_b) annotation(
    Line(points = {{-110, 85}, {-102, 85}, {-102, 86}, {-94, 86}}, color = {0, 127, 255}));
  connect(heaPum.port_b2, Quelle_Puffer.port_a1) annotation(
    Line(points = {{-38, -17}, {-42, -17}, {-42, -77}, {-17, -77}}, color = {0, 127, 255}));
  connect(T_QP1.port_1, Quelle_Puffer.port_HX_1_b) annotation(
    Line(points = {{6, -88}, {6, -74}, {-3, -74}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_HX_1_a, val7.port_a) annotation(
    Line(points = {{-3, -72}, {6, -72}, {6, -66}, {16, -66}}, color = {0, 127, 255}));
  connect(val7.port_b, T_QP2.port_2) annotation(
    Line(points = {{24, -66}, {34, -66}}, color = {0, 127, 255}));
  connect(T_QP1.port_3, val8.port_a) annotation(
    Line(points = {{10, -92}, {16, -92}}, color = {0, 127, 255}));
  connect(val8.port_b, T_QP2.port_3) annotation(
    Line(points = {{24, -92}, {38, -92}, {38, -70}}, color = {0, 127, 255}));
  connect(constant3.y, max.u2) annotation(
    Line(points = {{115.6, -170}, {111.7, -170}, {111.7, -162}, {110.6, -162}}, color = {0, 0, 127}));
  connect(JAZ.u2, max.y) annotation(
    Line(points = {{111.4, -139.2}, {122.1, -139.2}, {122.1, -145.2}, {88.8, -145.2}, {88.8, -158.2}, {95.4, -158.2}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.y, JAZ.u1) annotation(
    Line(points = {{143.4, -128}, {124.8, -128}, {124.8, -131}, {109.4, -131}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.u, limiter1.y) annotation(
    Line(points = {{157.2, -126}, {169.2, -126}}, color = {0, 0, 127}));
  connect(integrator_WP_El.u, limiter.y) annotation(
    Line(points = {{159.2, -148}, {165.2, -148}, {165.2, -154}, {171.2, -154}}, color = {0, 0, 127}));
  connect(limiter1.u, heaPum.QLoa_flow) annotation(
    Line(points = {{185, -128}, {190, -128}, {190, -8}, {-3, -8}, {-3, 1}, {-9, 1}}, color = {0, 0, 127}));
  connect(limiter.u, heaPum.P) annotation(
    Line(points = {{185, -154}, {192, -154}, {192, -10}, {-9, -10}}, color = {0, 0, 127}));
  connect(gain1.u, HDU.y[10]) annotation(
    Line(points = {{-53, 121}, {-44, 121}, {-44, 168}, {-7, 168}}, color = {0, 0, 127}));
  connect(gain1.y, pump_TWW.m_flow_in) annotation(
    Line(points = {{-69, 121}, {-79, 121}, {-79, 111}, {-91, 111}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold2.y, booleanToReal.u) annotation(
    Line(points = {{-165, 130}, {-174.5, 130}, {-174.5, 95}, {-155, 95}}, color = {255, 0, 255}));
  connect(gain1.y, greaterEqualThreshold2.u) annotation(
    Line(points = {{-69, 121}, {-69, 130}, {-146, 130}}, color = {0, 0, 127}));
  connect(booleanToReal.y, val12.y) annotation(
    Line(points = {{-143.5, 95}, {-150, 95}, {-150, 72}, {-90, 72}, {-90, 81}}, color = {0, 0, 127}));
  connect(val12.port_a, TWW.port_a1) annotation(
    Line(points = {{-86, 86}, {-75, 86}, {-75, 85}, {-55, 85}}, color = {0, 127, 255}));
  connect(pump_TWW.port_a, TWW.port_b1) annotation(
    Line(points = {{-86, 105}, {-70.5, 105}, {-70.5, 103}, {-55, 103}}, color = {0, 127, 255}));
  connect(temperature_floor_heat.port_a, mixingVolume.ports[1]) annotation(
    Line(points = {{120, 127}, {94, 127}, {94, 128}, {36, 128}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_1, mixingVolume.ports[2]) annotation(
    Line(points = {{-58, 13}, {0, 13}, {0, 128}, {36, 128}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.T[2], add_solCol.u2) annotation(
    Line(points = {{-17.4, -62}, {-27.4, -62}, {-27.4, -52}, {73.1, -52}, {73.1, -60}, {79.6, -60}}, color = {0, 0, 127}));
  connect(add_solCol.y, hysteresis_solCol.u) annotation(
    Line(points = {{90.5, -63}, {97, -63}}, color = {0, 0, 127}));
  connect(hysteresis_solCol.y, btr_solCol.u) annotation(
    Line(points = {{108.5, -63}, {115, -63}}, color = {255, 0, 255}));
  connect(btr_solCol.y, add2_solCol.u1) annotation(
    Line(points = {{126.5, -63}, {134, -63}, {134, -84}, {109, -84}}, color = {0, 0, 127}));
  connect(const_solCol.y, add2_solCol.u2) annotation(
    Line(points = {{140, -90}, {109, -90}}, color = {0, 0, 127}));
  connect(btr_solCol.y, val7.y) annotation(
    Line(points = {{126.5, -63}, {130, -63}, {130, -76}, {19, -76}, {19, -71}, {20, -71}}, color = {0, 0, 127}));
  connect(val8.y, add2_solCol.y) annotation(
    Line(points = {{20, -87}, {19.375, -87}, {19.375, -81.2}, {58.75, -81.2}, {58.75, -87}, {97.5, -87}}, color = {0, 0, 127}));
  connect(hyst_TWW.y, not_TWW.u) annotation(
    Line(points = {{-143.5, 55}, {-139, 55}}, color = {255, 0, 255}));
  connect(HDU.y[3], gain_FH.u) annotation(
    Line(points = {{-7, 168}, {-20, 168}, {-20, 148}, {6, 148}, {6, 106}, {20, 106}}, color = {0, 0, 127}));
  connect(gain_FH.y, HeatPower.Q_flow) annotation(
    Line(points = {{39, 106}, {42.8, 106}, {42.8, 115}, {48, 115}}, color = {0, 0, 127}));
  connect(HeatPower.port, mixingVolume.heatPort) annotation(
    Line(points = {{66, 115}, {72, 115}, {72, 134}, {30, 134}}, color = {191, 0, 0}));
  connect(heaPum.port_a2, pump_HP_sou.port_b) annotation(
    Line(points = {{-10, -17}, {-3, -17}, {-3, -18}, {4, -18}}, color = {0, 127, 255}));
  connect(pump_HP_sou.port_a, MAG_HP_sou.ports[1]) annotation(
    Line(points = {{16, -18}, {26, -18}, {26, -20}, {32, -20}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_a2, pump_HP_sou.port_a) annotation(
    Line(points = {{-3, -59}, {6.5, -59}, {6.5, -47}, {16, -47}, {16, -18}}, color = {0, 127, 255}));
  connect(T_QP1.port_2, pump_solCol.port_a) annotation(
    Line(points = {{6, -96}, {6, -125}, {-26, -125}, {-26, -138}}, color = {0, 127, 255}));
  connect(thermalCollector.port_b, Temp_Out_solCol.port_b) annotation(
    Line(points = {{48, -138}, {52, -138}}, color = {0, 127, 255}));
  connect(T_QP2.port_1, Temp_Out_solCol.port_a) annotation(
    Line(points = {{42, -66}, {70, -66}, {70, -138}, {66, -138}}, color = {0, 127, 255}));
  connect(pump_solCol.port_b, Temp_In_solCol.port_b) annotation(
    Line(points = {{-14, -138}, {-4, -138}}, color = {0, 127, 255}));
  connect(MAG_solCol.ports[1], pump_solCol.port_a) annotation(
    Line(points = {{-34, -130}, {-31, -130}, {-31, -138}, {-26, -138}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_3, Temp_In_HP.port_a) annotation(
    Line(points = {{-63, 8}, {-63, -8}, {-62, -8}}, color = {0, 127, 255}));
  connect(Temp_In_HP.port_b, heaPum.port_a1) annotation(
    Line(points = {{-52, -8}, {-48, -8}, {-48, -3}, {-38, -3}}, color = {0, 127, 255}));
  connect(heaPum.port_b1, Temp_HP_Out.port_a) annotation(
    Line(points = {{-10, -2}, {-4, -2}, {-4, 1}, {8, 1}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_1, MAG_HP_loa.ports[1]) annotation(
    Line(points = {{64, 17}, {60, 17}, {60, 22}, {18, 22}, {18, 18}}, color = {0, 127, 255}));
  connect(TWW.T[5], hyst_TWW.u) annotation(
    Line(points = {{-55, 100}, {-64, 100}, {-64, 66}, {-158, 66}, {-158, 55}, {-155, 55}}, color = {0, 0, 127}));
  connect(massflow_HP_loa.y, prod_mflow_FH.u1) annotation(
    Line(points = {{80, 82}, {90, 82}, {90, 86}, {102, 86}}, color = {0, 0, 127}));
  connect(hyst_FH.y, not_FH.u) annotation(
    Line(points = {{34.5, 75}, {39, 75}}, color = {255, 0, 255}));
  connect(not_FH.y, btr_FH.u) annotation(
    Line(points = {{50.5, 75}, {56.5, 75}, {56.5, 97}, {61, 97}}, color = {255, 0, 255}));
  connect(btr_FH.y, prod_mflow_FH.u2) annotation(
    Line(points = {{72.5, 97}, {76.5, 97}, {76.5, 92}, {102, 92}}, color = {0, 0, 127}));
  connect(prod_mflow_HPsou.u2, massflow_HP_sou.y) annotation(
    Line(points = {{-58, -48}, {-70, -48}}, color = {0, 0, 127}));
  connect(integerToReal.y, prod_mflow_HPsou.u1) annotation(
    Line(points = {{-70, -72}, {-63.6, -72}, {-63.6, -54}, {-58, -54}}, color = {0, 0, 127}));
  connect(Temp_HP_Out.port_b, mixingVolume1.ports[1]) annotation(
    Line(points = {{18, 1}, {25, 1}, {25, 16}, {42, 16}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_1, mixingVolume1.ports[2]) annotation(
    Line(points = {{64, 17}, {42, 17}, {42, 16}}, color = {0, 127, 255}));
  connect(prod_eheat_TWW.u2, Eheater_pow.y) annotation(
    Line(points = {{136, 12}, {136, 20}, {174, 20}}, color = {0, 0, 127}));
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
    Line(points = {{79, -66}, {74, -66}, {74, -92}, {59, -92}, {59, -131}}, color = {0, 0, 127}));
  connect(max.u1, add.y) annotation(
    Line(points = {{111.4, -153.8}, {116.4, -153.8}, {116.4, -152.8}, {125.9, -152.8}}, color = {0, 0, 127}));
  connect(add.u1, integrator_WP_El.y) annotation(
    Line(points = {{137, -150}, {141, -150}, {141, -148}, {145, -148}}, color = {0, 0, 127}));
  connect(add.u2, integrator.y) annotation(
    Line(points = {{137, -156}, {141, -156}, {141, -168}, {147, -168}}, color = {0, 0, 127}));
  connect(integrator.u, prod_eheat_TWW.y) annotation(
    Line(points = {{161, -168}, {162, -168}, {162, -24}, {124.5, -24}, {124.5, 9}}, color = {0, 0, 127}));
  connect(pump_solCol.m_flow_in, massflow_solCol.y) annotation(
    Line(points = {{-20, -145.2}, {-54, -145.2}, {-54, -126}, {-66, -126}}, color = {0, 0, 127}));
  connect(btr_TWW.y, product_contHP.u2) annotation(
    Line(points = {{-89.5, 49}, {-86, 49}, {-86, 34}, {-172, 34}, {-172, 24}, {-163, 24}}, color = {0, 0, 127}));
  connect(Tset_TWW.y, product_contHP.u1) annotation(
    Line(points = {{-176, 20}, {-163, 20}}, color = {0, 0, 127}));
  connect(product_contHP.y, max_contHP.u1) annotation(
    Line(points = {{-154, 22}, {-150, 22}, {-150, 12}, {-141, 12}}, color = {0, 0, 127}));
  connect(btr_TWW.y, gain_TWW.u) annotation(
    Line(points = {{-89.5, 49}, {-76.5, 49}}, color = {0, 0, 127}));
  connect(gain_TWW.y, pump_HP_TWW.m_flow_in) annotation(
    Line(points = {{-63, 50}, {-23, 50}, {-23, 90}}, color = {0, 0, 127}));
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
    Line(points = {{172, 82}, {170, 82}, {170, 127}, {130, 127}}, color = {0, 127, 255}));
  connect(and_Eheater.u2, not_temp_sou.y) annotation(
    Line(points = {{-131.2, -91.2}, {-141.2, -91.2}, {-141.2, -73.2}, {-133.2, -73.2}}, color = {255, 0, 255}));
  connect(not_temp_sou.u, hysteresis.y) annotation(
    Line(points = {{-123, -75}, {-115, -75}, {-115, -85}, {-104.5, -85}}, color = {255, 0, 255}));
  connect(and_HP.u1, hysteresis.y) annotation(
    Line(points = {{-135.2, -50}, {-141.2, -50}, {-141.2, -66}, {-109.2, -66}, {-109.2, -85}, {-104.5, -85}}, color = {255, 0, 255}));
  connect(pump_HP_FH.m_flow_in, sw_FH.y) annotation(
    Line(points = {{162, 74}, {156, 74}, {156, 73}, {151, 73}}, color = {0, 0, 127}));
  connect(gain_TWW.y, gr_FH.u) annotation(
    Line(points = {{-63, 50}, {22, 50}, {22, 53}, {71, 53}}, color = {0, 0, 127}));
  connect(prod_mflow_FH.y, sw_FH.u3) annotation(
    Line(points = {{114, 90}, {122, 90}, {122, 78}, {134, 78}}, color = {0, 0, 127}));
  connect(sw_FH.u1, constant2.y) annotation(
    Line(points = {{134, 68}, {132, 68}, {132, 46}, {126, 46}}, color = {0, 0, 127}));
  connect(not_FH.y, and2.u2) annotation(
    Line(points = {{50.5, 75}, {64, 75}, {64, 68}, {104, 68}}, color = {255, 0, 255}));
  connect(gr_FH.y, and2.u1) annotation(
    Line(points = {{87, 53}, {98, 53}, {98, 64}, {104, 64}}, color = {255, 0, 255}));
  connect(and2.y, sw_FH.u2) annotation(
    Line(points = {{118, 64}, {122, 64}, {122, 74}, {134, 74}}, color = {255, 0, 255}));
  connect(hysteresis.u, Quelle_Puffer.T[4]) annotation(
    Line(points = {{-93, -85}, {-54.5, -85}, {-54.5, -73}, {-28, -73}, {-28, -62}, {-17, -62}}, color = {0, 0, 127}));
  connect(Temp_In_solCol.port_a, thermalCollector.port_a) annotation(
    Line(points = {{10, -138}, {28, -138}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_2, pump_HP_FH.port_a) annotation(
    Line(points = {{74, 17}, {90, 17}, {90, 38}, {172, 38}, {172, 68}}, color = {0, 127, 255}));
  connect(pump_HP_TWW.port_a, teeJunctionIdeal1.port_3) annotation(
    Line(points = {{-16, 100}, {-12, 100}, {-12, 36}, {69, 36}, {69, 22}}, color = {0, 127, 255}));
  connect(pVSimpleOriented.P, batteryControl.PV_power) annotation(
    Line(points = {{25, -157}, {-74, -157}, {-74, -149}, {-128.5, -149}, {-128.5, -143}, {-119, -143}}, color = {0, 0, 127}));
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{-156, -164}, {-138, -164}, {-138, -170}, {-118, -170}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{-176, -164}, {-198, -164}, {-198, 162}, {-92, 162}, {-92, 168}}));
  connect(bat.SOC, batteryControl.SOC) annotation(
    Line(points = {{-97, -164}, {-87, -164}, {-87, -118}, {-135, -118}, {-135, -131}, {-119, -131}}, color = {0, 0, 127}));
  connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{46, -164}, {71, -164}, {71, -178}, {-143.5, -178}, {-143.5, -164}, {-156, -164}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{-192, -130}, {-192, -129.75}, {-194, -129.75}, {-194, -129.5}, {-198, -129.5}, {-198, 163}, {-92, 163}, {-92, 168}}));
  connect(batteryControl.P, bat.P) annotation(
    Line(points = {{-99, -134}, {-92, -134}, {-92, -152}, {-108, -152}, {-108, -160}}, color = {0, 0, 127}));
  connect(weaDat1.weaBus, pVSimpleOriented.weaBus);
  connect(calTim.hour, itr_time.u) annotation(
    Line(points = {{-179, -96}, {-174, -96}, {-174, -97}, {-175, -97}}, color = {255, 127, 0}));
  connect(itr_time.y, gre_time.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-190, -88}, {-190, -78}, {-180, -78}}, color = {0, 0, 127}));
  connect(HDU.y[9], add_pow.u1) annotation(
    Line(points = {{-6, 168}, {-58, 168}, {-58, 152}, {-198, 152}, {-198, -114}, {-146, -114}, {-146, -126}, {-150, -126}}, color = {0, 0, 127}));
  connect(heaPum.P, add_pow.u2) annotation(
    Line(points = {{-8, -10}, {184, -10}, {184, -112}, {-138, -112}, {-138, -114}, {-144, -114}, {-144, -130}, {-150, -130}}, color = {0, 0, 127}));
  connect(prod_eheat_TWW.y, add_pow.u3) annotation(
    Line(points = {{124, 10}, {120, 10}, {120, -32}, {182, -32}, {182, -114}, {-136, -114}, {-136, -134}, {-150, -134}}, color = {0, 0, 127}));
  connect(pump_HP_sou.m_flow_in, prod_mflow_HPsou.y) annotation(
    Line(points = {{10, -26}, {10, -36}, {-40, -36}, {-40, -50}, {-46, -50}}, color = {0, 0, 127}));
  connect(mixingVolume.ports[3], Temp_FH.port) annotation(
    Line(points = {{36, 128}, {36, 122}, {10, 122}, {10, 80}}, color = {0, 127, 255}));
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
    Line(points = {{12, 76}, {24, 76}}, color = {0, 0, 127}));
  connect(itr_time.y, gre_TWW.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-192, -88}, {-192, 43}, {-181, 43}}, color = {0, 0, 127}));
  connect(itr_time.y, less_TWW.u) annotation(
    Line(points = {{-164, -96}, {-162, -96}, {-162, -88}, {-192, -88}, {-192, 59}, {-181, 59}}, color = {0, 0, 127}));
  connect(not_TWW.y, and_TWW2.u2) annotation(
    Line(points = {{-127.5, 55}, {-121, 55}}, color = {255, 0, 255}));
  connect(and_TWW2.y, btr_TWW.u) annotation(
    Line(points = {{-109.5, 51}, {-106, 51}, {-106, 49}, {-101, 49}}, color = {255, 0, 255}));
  connect(and_TWW2.u1, and_TWW1.y) annotation(
    Line(points = {{-120, 52}, {-122, 52}, {-122, 44}, {-128, 44}}, color = {255, 0, 255}));
  connect(and_TWW2.y, or1.u1) annotation(
    Line(points = {{-110, 52}, {-106, 52}, {-106, 38}, {-96, 38}, {-96, -32}, {-184, -32}, {-184, -42}}, color = {255, 0, 255}));
  connect(and_TWW1.u1, gre_TWW.y) annotation(
    Line(points = {{-138, 44}, {-170, 44}}, color = {255, 0, 255}));
  connect(and_TWW1.u2, less_TWW.y) annotation(
    Line(points = {{-138, 48}, {-166, 48}, {-166, 60}, {-170, 60}}, color = {255, 0, 255}));
  connect(not_FH_T.u, hyst_FH_T.y) annotation(
    Line(points = {{98, 116}, {106, 116}}, color = {255, 0, 255}));
  connect(hyst_FH_T.u, temperature_floor_heat.T) annotation(
    Line(points = {{118, 116}, {126, 116}, {126, 122}}, color = {0, 0, 127}));
  connect(not_FH_T.y, or1.u2) annotation(
    Line(points = {{86, 116}, {82, 116}, {82, -32}, {-186, -32}, {-186, -46}, {-184, -46}}, color = {255, 0, 255}));
  connect(add_pow.y, gain_el.u) annotation(
    Line(points = {{-164, -130}, {-164, -131}, {-168, -131}, {-168, -140}, {-154, -140}, {-154, -146}, {-160, -146}}, color = {0, 0, 127}));
  connect(RL.Pow, gain_el.y) annotation(
    Line(points = {{-176, -130}, {-172, -130}, {-172, -140}, {-182, -140}, {-182, -148}, {-176, -148}, {-176, -146}}, color = {0, 0, 127}));
  connect(add_pow.y, batteryControl.power_cons) annotation(
    Line(points = {{-164, -130}, {-166, -130}, {-166, -138}, {-120, -138}}, color = {0, 0, 127}));
  connect(pump_HP_TWW.port_b, TWW.port_HX_1_a) annotation(
    Line(points = {{-30, 100}, {-34, 100}, {-34, 90}, {-40, 90}}, color = {0, 127, 255}));
  connect(TWW.port_HX_1_b, teeJunctionIdeal.port_2) annotation(
    Line(points = {{-40, 88}, {-34, 88}, {-34, 26}, {-74, 26}, {-74, 14}, {-68, 14}}, color = {0, 127, 255}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {34, 172}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-62, 26}, {62, -26}}), Rectangle(origin = {-99, 88}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{95, -56}, {-95, 56}}), Rectangle(origin = {97, 88}, fillColor = {255, 166, 187}, fillPattern = FillPattern.Solid, extent = {{99, -56}, {-99, 56}}), Rectangle(origin = {57, 1}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{139, -29}, {-139, 29}}), Rectangle(origin = {-139, -69}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-55, 39}, {55, -39}}), Rectangle(origin = {1, -145}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{83, -35}, {-83, 35}}), Rectangle(origin = {141, -145}, fillColor = {204, 142, 255}, fillPattern = FillPattern.Solid, extent = {{-55, 35}, {55, -35}}), Rectangle(origin = {57, -69}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{139, -39}, {-139, 39}}), Rectangle(origin = {-139, 1}, fillColor = {207, 207, 207}, fillPattern = FillPattern.Solid, extent = {{-55, 29}, {55, -29}}), Rectangle(origin = {-139, -145}, fillColor = {223, 223, 0}, fillPattern = FillPattern.Solid, extent = {{55, -35}, {-55, 35}}), Rectangle(origin = {-99, 172}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-35, 26}, {35, -26}})}, coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-6, Interval = 3600),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end HDU_Full;
