within RoofKIT.EnergyConcept_HDU.WholeConcept.D5_Puffer_Variations;

model HDU_PufferSink_Time
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
    package Medium_loa = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.35, property_T = 283.15);
  package Medium_heat = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal = 0.278 "Source heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = per.hea.mLoa_flow "Load heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mHeat_flow_nominal = 0.1;
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(visible = true, transformation(extent = {{-204, 130}, {-184, 150}}, rotation = 0), iconTransformation(extent = {{148, 50}, {168, 70}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{136, 136}, {116, 156}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 125.5) annotation(
    Placement(visible = true, transformation(origin = {22, 116}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 0, nperiod = 1, offset = 5 * Gebaeude_modell.A_f, period = 86400, width = 100) annotation(
    Placement(visible = true, transformation(origin = {4, 102}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {117, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  RoofKIT.Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(A_f = 56.4, A_opaque = 81.3, A_win = {15.12, 0, 5.84, 5.84}, C_mass = 25000000, Hysterese_Irradiance = 10, Irr_shading = 150, U_opaque = 0.12, U_win = 1.0, V_room = 251, f_WRG = 0.8, g_factor = {0.5, 0.5, 0.5, 0.5}, latitude(displayUnit = "rad") = 0.015882496193148, surfaceAzimut = {207 / 180 * pi, 297 / 180 * pi, 27 / 180 * pi, 117 / 180 * pi}, win_frame = {0.3, 0.3, 0.3, 0.3}) annotation(
    Placement(visible = true, transformation(origin = {81, 117}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-64, -70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {-24, -9}, extent = {{-14, -11}, {14, 11}}, rotation = 0)));
  Buildings.Controls.SetPoints.SupplyReturnTemperatureReset watRes(TOut_nominal = (-12) + 273.15, TRet_nominal = 30 + 273.15, TSup_nominal = 50 + 273.15, m = 1.2) annotation(
    Placement(visible = true, transformation(origin = {-223, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.MovingMean movMea(delta = 3600 * 12) annotation(
    Placement(visible = true, transformation(origin = {-205, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = 22 + 273.15, uLow = 20 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-165, 101}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-143, 101}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mflow_heat(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-165, 117}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-123, 101}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-96, 104}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {0, -54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_loa(redeclare replaceable package Medium = Medium_loa, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {45, -2}, extent = {{-7, 8}, {7, -8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {4, -10}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage Pufferspeicher(redeclare package Medium = Medium_loa, redeclare package Medium_HX_1 = Medium_loa, redeclare package Medium_HX_2 = Medium_loa, Ele_HX_2 = 4, HX_1 = false, HX_2 = true, UA_HX_2 = 2000, V = 0.120, height = 1, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-31, 62}, extent = {{-15, -16}, {15, 16}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {33, 76}, extent = {{7, -8}, {-7, 8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_heat(redeclare package Medium = Medium_heat, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {83, 81}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {-184, 100}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-156, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-158, -34}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-131, -37}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uHigh = 2, uLow = -2) annotation(
    Placement(visible = true, transformation(origin = {-164, -14}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-185, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 1.62 * 16, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 0.00154 * 16) annotation(
    Placement(visible = true, transformation(origin = {42, -54}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.RadiantSlabs.SingleCircuitSlab sla(redeclare package Medium = Medium_heat, A = 19, disPip = 0.2, iLayPip = 1, layers = layer, m_flow_nominal = mHeat_flow_nominal, pipe = pipe, sysTyp = Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Floor) annotation(
    Placement(visible = true, transformation(origin = {60, 76}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic layer(material = {Buildings.HeatTransfer.Data.Solids.Generic(x = 0.08, k = 1.13, c = 1000, d = 1400, nSta = 5), Buildings.HeatTransfer.Data.Solids.Generic(x = 0.05, k = 0.04, c = 1400, d = 10), Buildings.HeatTransfer.Data.Solids.Generic(x = 0.2, k = 1.8, c = 1100, d = 2400)}, nLay = 3) annotation(
    Placement(visible = true, transformation(origin = {118, 86}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter Buildings.Fluid.Data.Pipes.Generic pipe(d(displayUnit = "kg/m3") = 983, dIn = 0.02, dOut = 0.025, k = 0.35, roughness = 0.002E-3) annotation(
    Placement(visible = true, transformation(origin = {118, 70}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-51, -5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 2000 / mLoa_flow_nominal / 4200 + senTem.T) annotation(
    Placement(visible = true, transformation(origin = {-220, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_heat1(redeclare package Medium = Medium_heat) annotation(
    Placement(visible = true, transformation(origin = {11, 75}, extent = {{5, -5}, {-5, 5}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_heat2(redeclare package Medium = Medium_heat) annotation(
    Placement(visible = true, transformation(origin = {9, 41}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_sou2(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-32, -54}, extent = {{-6, -4}, {6, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = Medium_heat, dpValve_nominal = 6000, m_flow_nominal = mHeat_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium = Medium_heat, dpValve_nominal = 6000, m_flow_nominal = mHeat_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {10, 60}, extent = {{-4, 4}, {4, -4}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant const1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {78, 60}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Controls.Continuous.LimPID conPID(Ti = 2000, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.01, strict = true, yMax = 0.95, yMin = 0.05) annotation(
    Placement(visible = true, transformation(origin = {121, 49}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {33, 57}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Steigung(k = -0.245) annotation(
    Placement(visible = true, transformation(origin = {199, 55}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Offset(k = 366.605) annotation(
    Placement(visible = true, transformation(origin = {173, 45}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {173, 59}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {145, 49}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_sou1(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {63, -54}, extent = {{-7, -6}, {7, 6}}, rotation = 180)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_heat, redeclare package Medium_HX_1 = Medium_loa, redeclare package Medium_HX_2 = Medium_loa, HX_1 = false, HX_2 = false, T_start = 43 + 273.15, V = 0.185, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-58, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 63}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_heat, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 71}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_heat, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 47}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse(amplitude = 0.04167, period = 86400, startTime = 43200, width = 4.167) annotation(
    Placement(visible = true, transformation(origin = {-161, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {-57, 11}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val10(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {86, 0}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val11(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {66, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal1(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {67, -1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val12(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 48}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis4(uHigh = 53 + 273.15, uLow = 43 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-183, 15}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3 annotation(
    Placement(visible = true, transformation(origin = {-143, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add5(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-105, 25}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-166, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not11 annotation(
    Placement(visible = true, transformation(origin = {-163, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse1(amplitude = 1, period = 86400, startTime = 43200, width = 4.167) annotation(
    Placement(visible = true, transformation(origin = {-161, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-143, -11}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger annotation(
    Placement(visible = true, transformation(origin = {-100, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_heat1(redeclare package Medium = Medium_heat, m_flow_nominal = mHeat_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {80, 41}, extent = {{-6, 5}, {6, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {20, -40}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not2 annotation(
    Placement(visible = true, transformation(origin = {-55, -97}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uHigh = 4 + 273.15, uLow = 0 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-71, -101}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-22, -98}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add6 annotation(
    Placement(visible = true, transformation(origin = {87, -101}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_Th annotation(
    Placement(visible = true, transformation(origin = {112, -102}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = Medium_sou, V = 0.0003, m_flow_nominal = mSou_flow_nominal, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {-15, -57}, extent = {{-3, 3}, {3, -3}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_Heizstab annotation(
    Placement(visible = true, transformation(origin = {22, -98}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division JAZ annotation(
    Placement(visible = true, transformation(origin = {59, -101}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_El annotation(
    Placement(visible = true, transformation(origin = {156, -102}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation(
    Placement(visible = true, transformation(origin = {-40, -96}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(visible = true, transformation(origin = {-27, -71}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {58, -18}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP2(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {76, -18}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val8(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {58, -34}, extent = {{4, 4}, {-4, -4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP1(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {-52, -42}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Blocks.Math.IntegerToReal integerToReal1 annotation(
    Placement(visible = true, transformation(origin = {-94, -42}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add7(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-73, -47}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-94, -54}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const6(k = 1500) annotation(
    Placement(visible = true, transformation(origin = {-52, -112}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uHigh = 95 + 273.15, uLow = 85 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-67, -133}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = -3000) annotation(
    Placement(visible = true, transformation(origin = {-50, -142}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product4 annotation(
    Placement(visible = true, transformation(origin = {-32, -130}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal2 annotation(
    Placement(visible = true, transformation(origin = {-50, -130}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(
    Placement(visible = true, transformation(origin = {-17, -129}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 1500) annotation(
    Placement(visible = true, transformation(origin = {172, -78}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 6000) annotation(
    Placement(visible = true, transformation(origin = {136, -76}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {67, -130}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {98, -134}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Utilities.Time.CalendarTime calTim(day(start = 1), hour(start = 0), zerTim = Buildings.Utilities.Time.Types.ZeroTime.Custom) annotation(
    Placement(visible = true, transformation(origin = {-232, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal2 annotation(
    Placement(visible = true, transformation(origin = {-202, -94}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater annotation(
    Placement(visible = true, transformation(origin = {-168, -108}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Less less annotation(
    Placement(visible = true, transformation(origin = {-168, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-121, -11}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.And and2 annotation(
    Placement(visible = true, transformation(origin = {-133, -91}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant4(k = 6) annotation(
    Placement(visible = true, transformation(origin = {-198, -118}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant5(k = 22) annotation(
    Placement(visible = true, transformation(origin = {-198, -68}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
equation
//Connections
  connect(weaDat1.weaBus, weaBus) annotation(
    Line(points = {{116, 146}, {-194, 146}, {-194, 140}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation(
    Line(points = {{116, 146}, {81, 146}, {81, 132}}, color = {255, 204, 51}, thickness = 0.5));
  connect(hysteresis.y, not1.u) annotation(
    Line(points = {{-159.5, 101}, {-149, 101}}, color = {255, 0, 255}));
  connect(not1.y, booleanToReal.u) annotation(
    Line(points = {{-137.5, 101}, {-129, 101}}, color = {255, 0, 255}));
  connect(booleanToReal.y, product.u2) annotation(
    Line(points = {{-117.5, 101}, {-117.5, 100}, {-103, 100}}, color = {0, 0, 127}));
  connect(temperatureSensor.T, hysteresis.u) annotation(
    Line(points = {{-178, 100}, {-171, 100}, {-171, 101}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.port_air, temperatureSensor.port) annotation(
    Line(points = {{66, 129}, {-190, 129}, {-190, 100}}, color = {191, 0, 0}));
  connect(weaBus.TDryBul, watRes.TOut) annotation(
    Line(points = {{-194, 140}, {-194, 94}, {-242, 94}, {-242, -12}, {-229, -12}}, color = {0, 0, 127}));
  connect(add.y, hysteresis1.u) annotation(
    Line(points = {{-179.5, -15}, {-174.25, -15}, {-174.25, -14}, {-171, -14}}, color = {0, 0, 127}));
  connect(mflow_heat.y, product.u1) annotation(
    Line(points = {{-159.5, 117}, {-107.5, 117}, {-107.5, 107}, {-103.5, 107}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation(
    Line(points = {{64.8, 112.2}, {45.8, 112.2}, {45.8, 116.2}, {28.8, 116.2}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation(
    Line(points = {{64.8, 107.4}, {45.8, 107.4}, {45.8, 102.4}, {9.8, 102.4}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.port_air, Pufferspeicher.heatPort) annotation(
    Line(points = {{66, 129}, {-31, 129}, {-31, 79}}, color = {191, 0, 0}));
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{116, 146}, {106, 146}, {106, -76}, {35, -76}, {35, -64}, {36, -64}}, color = {255, 204, 51}, thickness = 0.5));
  connect(pump_heat.port_a, sla.port_b) annotation(
    Line(points = {{40, 76}, {52, 76}}, color = {0, 127, 255}));
  connect(sla.port_a, bou_heat.ports[1]) annotation(
    Line(points = {{68, 76}, {74, 76}, {74, 81}, {80, 81}}, color = {0, 127, 255}));
  connect(sla.surf_a, Gebaeude_modell.port_surf) annotation(
    Line(points = {{56.8, 84}, {56.8, 124}, {65.8, 124}}, color = {191, 0, 0}));
  connect(movMea.y, add.u2) annotation(
    Line(points = {{-199, -15}, {-186, -15}, {-186, -18}, {-191, -18}}, color = {0, 0, 127}));
  connect(realExpression.y, heaPum.TSet) annotation(
    Line(points = {{-209, 2}, {-80, 2}, {-80, 1}, {-40, 1}}, color = {0, 0, 127}));
  connect(T_heat2.port_2, STemp_heat1.port_a) annotation(
    Line(points = {{14, 41}, {74, 41}}, color = {0, 127, 255}));
  connect(STemp_heat1.port_b, sla.port_a) annotation(
    Line(points = {{86, 41}, {90, 41}, {90, 76}, {68, 76}}, color = {0, 127, 255}));
  connect(T_heat1.port_3, val2.port_b) annotation(
    Line(points = {{11, 70}, {11, 66}, {10, 66}, {10, 64}}, color = {0, 127, 255}));
  connect(val2.port_a, T_heat2.port_3) annotation(
    Line(points = {{10, 56}, {9, 56}, {9, 46}}, color = {0, 127, 255}));
  connect(val1.port_b, T_heat1.port_1) annotation(
    Line(points = {{2, 74}, {4, 74}, {4, 76}, {6, 76}}, color = {0, 127, 255}));
  connect(T_heat1.port_2, pump_heat.port_b) annotation(
    Line(points = {{16, 75}, {26, 75}}, color = {0, 127, 255}));
  connect(STemp_heat1.T, conPID.u_m) annotation(
    Line(points = {{80, 35.5}, {80, 36}, {121, 36}, {121, 43}}, color = {0, 0, 127}));
  connect(val1.y, conPID.y) annotation(
    Line(points = {{-2, 69.2}, {-2, 49}, {115.5, 49}}, color = {0, 0, 127}));
  connect(val2.y, add1.y) annotation(
    Line(points = {{14.8, 60}, {20.8, 60}, {20.8, 57}, {28.3, 57}}, color = {0, 0, 127}));
  connect(conPID.y, add1.u1) annotation(
    Line(points = {{115.5, 49}, {48, 49}, {48, 54}, {40, 54}}, color = {0, 0, 127}));
  connect(add1.u2, const1.y) annotation(
    Line(points = {{39, 60}, {74, 60}}, color = {0, 0, 127}));
  connect(product2.u2, Steigung.y) annotation(
    Line(points = {{179, 56}, {190, 56}, {190, 55}, {193.5, 55}}, color = {0, 0, 127}));
  connect(add2.u2, product2.y) annotation(
    Line(points = {{151, 52}, {157, 52}, {157, 59}, {167.5, 59}}, color = {0, 0, 127}));
  connect(add2.u1, Offset.y) annotation(
    Line(points = {{151, 46}, {163, 46}, {163, 45}, {167.5, 45}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, product2.u1) annotation(
    Line(points = {{-194, 140}, {114, 140}, {114, 110}, {190, 110}, {190, 62}, {179, 62}}, color = {0, 0, 127}));
  connect(conPID.u_s, add2.y) annotation(
    Line(points = {{127, 49}, {139.5, 49}}, color = {0, 0, 127}));
  connect(thermalCollector.port_b, STemp_sou1.port_b) annotation(
    Line(points = {{52, -54}, {56, -54}}, color = {0, 127, 255}));
  connect(const.y, product1.u1) annotation(
    Line(points = {{-152, -48}, {-144.7, -48}, {-144.7, -40}, {-137, -40}}, color = {0, 0, 127}));
  connect(integerToReal.y, product1.u2) annotation(
    Line(points = {{-154, -34}, {-137, -34}}, color = {0, 0, 127}));
  connect(Pufferspeicher.port_HX_2_a, val1.port_a) annotation(
    Line(points = {{-20.5, 70}, {-13.25, 70}, {-13.25, 74}, {-6, 74}}, color = {0, 127, 255}));
  connect(Pufferspeicher.port_HX_2_b, T_heat2.port_1) annotation(
    Line(points = {{-20.5, 66.8}, {-14, 66.8}, {-14, 40.8}, {4, 40.8}}, color = {0, 127, 255}));
  connect(TWW.port_a2, pump_TWW.port_a) annotation(
    Line(points = {{-64, 66}, {-72, 66}, {-72, 64}, {-86, 64}}, color = {0, 127, 255}));
  connect(product.y, pump_heat.m_flow_in) annotation(
    Line(points = {{-90, 104}, {-8, 104}, {-8, 88}, {34, 88}, {34, 86}}, color = {0, 0, 127}));
  connect(Pufferspeicher.T[2], add.u1) annotation(
    Line(points = {{-42, 72}, {-78, 72}, {-78, 88}, {-196, 88}, {-196, -12}, {-191, -12}}, color = {0, 0, 127}));
  connect(pulse.y, pump_TWW.m_flow_in) annotation(
    Line(points = {{-155.5, 79}, {-146, 79}, {-146, 86}, {-90, 86}, {-90, 70}}, color = {0, 0, 127}));
  connect(val10.port_a, Pufferspeicher.port_a2) annotation(
    Line(points = {{90, 0}, {94, 0}, {94, 86}, {-20, 86}, {-20, 76}}, color = {0, 127, 255}));
  connect(bou_loa.ports[1], pump_loa.port_a) annotation(
    Line(points = {{8, -10}, {38, -10}, {38, -2}}, color = {0, 127, 255}));
  connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 72}, {-104, 72}, {-104, 64}, {-96, 64}}, color = {0, 127, 255}));
  connect(val11.port_a, TWW.port_b1) annotation(
    Line(points = {{66, 16}, {66, 28}, {-46, 28}, {-46, 66}, {-50, 66}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_2, TWW.port_a1) annotation(
    Line(points = {{-62, 11}, {-62, 11.25}, {-68, 11.25}, {-68, 27.5}, {-50, 27.5}, {-50, 48}}, color = {0, 127, 255}));
  connect(Pufferspeicher.port_b2, teeJunctionIdeal.port_1) annotation(
    Line(points = {{-20, 48}, {-20, 11}, {-52, 11}}, color = {0, 127, 255}));
  connect(heaPum.port_a1, senTem.port_b) annotation(
    Line(points = {{-38, -2.4}, {-46, -2.4}, {-46, -5}}, color = {0, 127, 255}));
  connect(heaPum.port_b1, pump_loa.port_a) annotation(
    Line(points = {{-10, -2.4}, {38, -2.4}}, color = {0, 127, 255}));
  connect(pump_loa.port_b, teeJunctionIdeal1.port_1) annotation(
    Line(points = {{52, -2}, {62, -2}, {62, -1}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_3, val11.port_b) annotation(
    Line(points = {{67, 4}, {67, 8}, {66, 8}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_2, val10.port_b) annotation(
    Line(points = {{72, -1}, {88, -1}, {88, 0}, {82, 0}}, color = {0, 127, 255}));
  connect(Wasseranschluss.ports[1], val12.port_b) annotation(
    Line(points = {{-110, 48}, {-94, 48}}, color = {0, 127, 255}));
  connect(TWW.port_b2, val12.port_a) annotation(
    Line(points = {{-64, 48}, {-86, 48}}, color = {0, 127, 255}));
  connect(TWW.T[3], hysteresis4.u) annotation(
    Line(points = {{-50, 62}, {-48, 62}, {-48, 36}, {-192, 36}, {-192, 15}, {-191, 15}}, color = {0, 0, 127}));
  connect(const5.y, add5.u2) annotation(
    Line(points = {{-162, 30}, {-142, 30}, {-142, 28}, {-111, 28}}, color = {0, 0, 127}));
  connect(add5.y, val10.y) annotation(
    Line(points = {{-99.5, 25}, {86, 25}, {86, 4}}, color = {0, 0, 127}));
  connect(hysteresis4.y, not11.u) annotation(
    Line(points = {{-175, 15}, {-172.25, 15}, {-172.25, 13}, {-169, 13}}, color = {255, 0, 255}));
  connect(not11.y, booleanToReal3.u) annotation(
    Line(points = {{-157.5, 13}, {-149, 13}}, color = {255, 0, 255}));
  connect(booleanToReal3.y, add5.u1) annotation(
    Line(points = {{-137.5, 13}, {-118, 13}, {-118, 22}, {-110, 22}}, color = {0, 0, 127}));
  connect(booleanToReal3.y, val11.y) annotation(
    Line(points = {{-137.5, 13}, {62, 13}, {62, 12}}, color = {0, 0, 127}));
  connect(pulse1.y, val12.y) annotation(
    Line(points = {{-156, 60}, {-142, 60}, {-142, 34}, {-90, 34}, {-90, 44}}, color = {0, 0, 127}));
  connect(watRes.TSup, movMea.u) annotation(
    Line(points = {{-218, -12}, {-214, -12}, {-214, -15}, {-211, -15}}, color = {0, 0, 127}));
  connect(hysteresis1.y, or1.u2) annotation(
    Line(points = {{-157, -14}, {-154.25, -14}, {-154.25, -17}, {-151, -17}}, color = {255, 0, 255}));
  connect(teeJunctionIdeal.port_3, senTem.port_a) annotation(
    Line(points = {{-57, 6}, {-57, -5}, {-56, -5}}, color = {0, 127, 255}));
  connect(not11.y, or1.u1) annotation(
    Line(points = {{-157.5, 13}, {-154, 13}, {-154, -11}, {-151, -11}}, color = {255, 0, 255}));
  connect(booleanToInteger.y, heaPum.uMod) annotation(
    Line(points = {{-94, -16}, {-64, -16}, {-64, -8}, {-40, -8}}, color = {255, 127, 0}));
  connect(booleanToInteger.y, integerToReal.u) annotation(
    Line(points = {{-94, -16}, {-90, -16}, {-90, -30}, {-168, -30}, {-168, -34}, {-162, -34}}, color = {255, 127, 0}));
  connect(product1.y, pump_loa.m_flow_in) annotation(
    Line(points = {{-125.5, -37}, {-121.75, -37}, {-121.75, -31}, {46, -31}, {46, -12}}, color = {0, 0, 127}));
  connect(pump_sou.port_b, thermalCollector.port_a) annotation(
    Line(points = {{6, -54}, {32, -54}}, color = {0, 127, 255}));
  connect(const3.y, pump_sou.m_flow_in) annotation(
    Line(points = {{16, -40}, {9, -40}, {9, -46}, {0, -46}}, color = {0, 0, 127}));
  connect(bou_sou.ports[1], STemp_sou2.port_b) annotation(
    Line(points = {{-60, -70}, {-47, -70}, {-47, -54}, {-38, -54}}, color = {0, 127, 255}));
  connect(vol.ports[1], pump_sou.port_a) annotation(
    Line(points = {{-14, -54}, {-6, -54}}, color = {0, 127, 255}));
  connect(STemp_sou2.port_a, vol.ports[2]) annotation(
    Line(points = {{-26, -54}, {-14, -54}}, color = {0, 127, 255}));
  connect(STemp_sou2.port_b, T_QP1.port_2) annotation(
    Line(points = {{-38, -54}, {-52, -54}, {-52, -46}}, color = {0, 127, 255}));
  connect(T_QP1.port_1, heaPum.port_b2) annotation(
    Line(points = {{-52, -38}, {-52, -16}, {-38, -16}}, color = {0, 127, 255}));
  connect(STemp_sou1.port_a, T_QP2.port_1) annotation(
    Line(points = {{70, -54}, {86, -54}, {86, -18}, {80, -18}}, color = {0, 127, 255}));
  connect(T_QP1.port_3, val8.port_a) annotation(
    Line(points = {{-48, -42}, {-27, -42}, {-27, -34}, {54, -34}}, color = {0, 127, 255}));
  connect(booleanToInteger.y, integerToReal1.u) annotation(
    Line(points = {{-94, -16}, {-87.5, -16}, {-87.5, -34}, {-99, -34}, {-99, -42}}, color = {255, 127, 0}));
  connect(constant1.y, add7.u2) annotation(
    Line(points = {{-90, -54}, {-78, -54}, {-78, -50}}, color = {0, 0, 127}));
  connect(add7.u1, integerToReal1.y) annotation(
    Line(points = {{-78, -44}, {-90, -44}, {-90, -42}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation(
    Line(points = {{-24, -70}, {-20, -70}, {-20, -56}, {-18, -56}}, color = {191, 0, 0}));
  connect(not2.y, booleanToReal1.u) annotation(
    Line(points = {{-49.5, -97}, {-48, -97}, {-48, -96}, {-45, -96}}, color = {255, 0, 255}));
  connect(hysteresis2.y, not2.u) annotation(
    Line(points = {{-65.5, -101}, {-62, -101}, {-62, -96}, {-60, -96}}, color = {255, 0, 255}));
  connect(const6.y, product3.u1) annotation(
    Line(points = {{-48, -112}, {-26, -112}, {-26, -100}}, color = {0, 0, 127}));
  connect(booleanToReal1.y, product3.u2) annotation(
    Line(points = {{-36, -96}, {-26, -96}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow.Q_flow, product3.y) annotation(
    Line(points = {{-30, -70}, {-34, -70}, {-34, -84}, {-10, -84}, {-10, -98}, {-18, -98}}, color = {0, 0, 127}));
  connect(STemp_sou2.T, hysteresis2.u) annotation(
    Line(points = {{-32, -58}, {-32, -64}, {-44, -64}, {-44, -88}, {-80, -88}, {-80, -101}, {-77, -101}}, color = {0, 0, 127}));
  connect(product3.y, integrator_Heizstab.u) annotation(
    Line(points = {{-18, -98}, {15, -98}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.y, JAZ.u1) annotation(
    Line(points = {{106, -102}, {102, -102}, {102, -88}, {74, -88}, {74, -96}, {68, -96}}, color = {0, 0, 127}));
  connect(integrator_WP_El.y, add6.u2) annotation(
    Line(points = {{150, -102}, {142, -102}, {142, -118}, {100, -118}, {100, -98}, {94, -98}}, color = {0, 0, 127}));
  connect(integrator_Heizstab.y, add6.u1) annotation(
    Line(points = {{29, -98}, {30, -98}, {30, -118}, {94, -118}, {94, -104}}, color = {0, 0, 127}));
  connect(T_QP2.port_2, val7.port_b) annotation(
    Line(points = {{72, -18}, {62, -18}}, color = {0, 127, 255}));
  connect(T_QP2.port_3, val8.port_b) annotation(
    Line(points = {{76, -22}, {76, -34}, {62, -34}}, color = {0, 127, 255}));
  connect(val7.port_a, heaPum.port_a2) annotation(
    Line(points = {{54, -18}, {36, -18}, {36, -16}, {-10, -16}}, color = {0, 127, 255}));
  connect(integerToReal1.y, val7.y) annotation(
    Line(points = {{-90, -42}, {-86, -42}, {-86, -22}, {58, -22}}, color = {0, 0, 127}));
  connect(val8.y, add7.y) annotation(
    Line(points = {{58, -30}, {-64, -30}, {-64, -46}, {-68, -46}}, color = {0, 0, 127}));
  connect(hysteresis3.u, STemp_sou2.T) annotation(
    Line(points = {{-72, -132}, {-80, -132}, {-80, -86}, {-42, -86}, {-42, -66}, {-32, -66}, {-32, -58}}, color = {0, 0, 127}));
  connect(hysteresis3.y, booleanToReal2.u) annotation(
    Line(points = {{-62, -132}, {-58, -132}, {-58, -130}, {-54, -130}}, color = {255, 0, 255}));
  connect(booleanToReal2.y, product4.u2) annotation(
    Line(points = {{-46, -130}, {-42, -130}, {-42, -128}, {-36, -128}}, color = {0, 0, 127}));
  connect(product4.u1, constant2.y) annotation(
    Line(points = {{-36, -132}, {-36, -142}, {-46, -142}}, color = {0, 0, 127}));
  connect(product4.y, prescribedHeatFlow1.Q_flow) annotation(
    Line(points = {{-28, -130}, {-20, -130}, {-20, -128}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow1.port, vol.heatPort) annotation(
    Line(points = {{-14, -128}, {-4, -128}, {-4, -76}, {-18, -76}, {-18, -56}}, color = {191, 0, 0}));
  connect(constant3.y, max.u2) annotation(
    Line(points = {{94, -134}, {75, -134}, {75, -133}}, color = {0, 0, 127}));
  connect(add6.y, max.u1) annotation(
    Line(points = {{82, -100}, {78, -100}, {78, -124}, {76, -124}}, color = {0, 0, 127}));
  connect(max.y, JAZ.u2) annotation(
    Line(points = {{60, -128}, {54, -128}, {54, -114}, {68, -114}, {68, -106}}, color = {0, 0, 127}));
  connect(limiter.y, integrator_WP_El.u) annotation(
    Line(points = {{166, -78}, {164, -78}, {164, -102}}, color = {0, 0, 127}));
  connect(limiter.u, heaPum.P) annotation(
    Line(points = {{180, -78}, {182, -78}, {182, -10}, {-8, -10}}, color = {0, 0, 127}));
  connect(limiter1.u, heaPum.QLoa_flow) annotation(
    Line(points = {{143, -76}, {158, -76}, {158, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.u, limiter1.y) annotation(
    Line(points = {{120, -102}, {124, -102}, {124, -76}, {130, -76}}, color = {0, 0, 127}));
  connect(calTim.hour, integerToReal2.u) annotation(
    Line(points = {{-221, -78}, {-214.5, -78}, {-214.5, -94}, {-212, -94}}, color = {255, 127, 0}));
  connect(or1.y, and1.u1) annotation(
    Line(points = {{-136, -10}, {-130, -10}}, color = {255, 0, 255}));
  connect(and1.y, booleanToInteger.u) annotation(
    Line(points = {{-114, -10}, {-108, -10}, {-108, -16}}, color = {255, 0, 255}));
  connect(and2.u1, less.y) annotation(
    Line(points = {{-142, -90}, {-150, -90}, {-150, -80}, {-157, -80}}, color = {255, 0, 255}));
  connect(and2.u2, greater.y) annotation(
    Line(points = {{-142, -96}, {-150, -96}, {-150, -108}, {-157, -108}}, color = {255, 0, 255}));
  connect(and2.y, and1.u2) annotation(
    Line(points = {{-126, -90}, {-114, -90}, {-114, -24}, {-134, -24}, {-134, -16}, {-130, -16}}, color = {255, 0, 255}));
  connect(constant5.y, less.u2) annotation(
    Line(points = {{-194, -68}, {-180, -68}, {-180, -72}}, color = {0, 0, 127}));
  connect(less.u1, integerToReal2.y) annotation(
    Line(points = {{-180, -80}, {-186, -80}, {-186, -94}, {-194, -94}}, color = {0, 0, 127}));
  connect(greater.u1, integerToReal2.y) annotation(
    Line(points = {{-180, -108}, {-184, -108}, {-184, -94}, {-194, -94}}, color = {0, 0, 127}));
  connect(greater.u2, constant4.y) annotation(
    Line(points = {{-180, -116}, {-194, -116}, {-194, -118}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {9, 115}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-91, 23}, {91, -23}}), Rectangle(origin = {-47, 61}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{35, -29}, {-35, 29}}), Rectangle(origin = {45, 61}, fillColor = {255, 121, 161}, fillPattern = FillPattern.Solid, extent = {{55, -29}, {-55, 29}}), Rectangle(origin = {9, 2}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{91, -28}, {-91, 28}}), Rectangle(origin = {-166, 6}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-82, 132}, {82, -132}}), Rectangle(origin = {51, -91}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{133, -63}, {-133, 63}}), Rectangle(origin = {-111, 61}, fillColor = {169, 255, 169}, fillPattern = FillPattern.Solid, extent = {{27, -29}, {-27, 29}}), Rectangle(origin = {157, 32}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-55, 58}, {55, -58}})}),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600));
end HDU_PufferSink_Time;
