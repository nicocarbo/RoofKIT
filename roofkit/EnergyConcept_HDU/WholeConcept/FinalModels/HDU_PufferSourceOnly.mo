within RoofKIT.EnergyConcept_HDU.WholeConcept.FinalModels;

model HDU_PufferSourceOnly
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
  package Medium_loa = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.35, property_T = 283.15);
  //package Medium_heat = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal = 0.35 "Source heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = per.hea.mLoa_flow "Load heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mHeat_flow_nominal = 0.1;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{172, 130}, {152, 150}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 125.5) annotation(
    Placement(visible = true, transformation(origin = {22, 116}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 0, nperiod = 1, offset = 5 * Gebaeude_modell.A_f, period = 86400, width = 100) annotation(
    Placement(visible = true, transformation(origin = {4, 102}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {117, 7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  RoofKIT.Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(A_f = 56.4, A_opaque = 81.3, A_win = {15.12, 0, 5.84, 5.84}, C_mass = 25000000, Hysterese_Irradiance = 10, Irr_shading = 150, U_opaque = 0.12, U_win = 1.0, V_room = 251, f_WRG = 0.8, g_factor = {0.5, 0.5, 0.5, 0.5}, latitude(displayUnit = "rad") = 0.015882496193148, surfaceAzimut = {207 / 180 * pi, 297 / 180 * pi, 27 / 180 * pi, 117 / 180 * pi}, win_frame = {0.3, 0.3, 0.3, 0.3}) annotation(
    Placement(visible = true, transformation(origin = {81, 117}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-32, -70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {-24, -9}, extent = {{-14, -11}, {14, 11}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = 24 + 273.15, uLow = 20 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-203, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-221, 101}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou1(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {10, -16}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_loa(redeclare replaceable package Medium = Medium_loa, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {45, -2}, extent = {{-7, 8}, {7, -8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {12, 10}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_heat(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {83, 81}, extent = {{3, -3}, {-3, 3}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {-184, 100}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-156, -66}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-158, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-131, -55}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 1.62 * 14, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 0.00154 * 14) annotation(
    Placement(visible = true, transformation(origin = {42, -82}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.RadiantSlabs.SingleCircuitSlab sla(redeclare package Medium = Medium_loa, A = 19, disPip = 0.2, iLayPip = 1, layers = layer, m_flow_nominal = mHeat_flow_nominal, pipe = pipe, sysTyp = Buildings.Fluid.HeatExchangers.RadiantSlabs.Types.SystemType.Floor) annotation(
    Placement(visible = true, transformation(origin = {60, 76}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic layer(material = {Buildings.HeatTransfer.Data.Solids.Generic(x = 0.08, k = 1.13, c = 1000, d = 1400, nSta = 5), Buildings.HeatTransfer.Data.Solids.Generic(x = 0.05, k = 0.04, c = 1400, d = 10), Buildings.HeatTransfer.Data.Solids.Generic(x = 0.2, k = 1.8, c = 1100, d = 2400)}, nLay = 3) annotation(
    Placement(visible = true, transformation(origin = {118, 106}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter Buildings.Fluid.Data.Pipes.Generic pipe(d(displayUnit = "kg/m3") = 983, dIn = 0.02, dOut = 0.025, k = 0.35, roughness = 0.002E-3) annotation(
    Placement(visible = true, transformation(origin = {140, 106}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-51, -3}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_heat1(redeclare package Medium = Medium_loa, m_flow_nominal = mHeat_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {80, 41}, extent = {{-6, 5}, {6, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_sou1(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {67, -82}, extent = {{-7, -6}, {7, 6}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const6(k = 1500) annotation(
    Placement(visible = true, transformation(origin = {-34, -116}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uHigh = 4 + 273.15, uLow = 0 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-69, -109}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation(
    Placement(visible = true, transformation(origin = {-34, -106}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-10, -112}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_loa, redeclare package Medium_HX_1 = Medium_loa, redeclare package Medium_HX_2 = Medium_loa, HX_1 = false, HX_2 = false, T_start = 70 + 273.15, V = 0.185, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-58, 56}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_loa, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 63}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_loa, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 71}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_loa, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 47}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = Medium_sou, V = 0.0003, m_flow_nominal = mSou_flow_nominal, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {21, -79}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse(amplitude = 0.04167, period = 86400, startTime = 43200, width = 4.167) annotation(
    Placement(visible = true, transformation(origin = {-161, 79}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {-59, 11}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val10(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {86, 0}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val11(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {66, 12}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal teeJunctionIdeal1(redeclare package Medium = Medium_loa) annotation(
    Placement(visible = true, transformation(origin = {67, -1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val12(redeclare package Medium = Medium_loa, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 48}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis4(uHigh = 53 + 273.15, uLow = 43 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-181, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal3 annotation(
    Placement(visible = true, transformation(origin = {-143, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add5(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-109, 25}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-166, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not11 annotation(
    Placement(visible = true, transformation(origin = {-163, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse pulse1(amplitude = 1, period = 86400, startTime = 43200, width = 4.167) annotation(
    Placement(visible = true, transformation(origin = {-161, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-144, -10}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger annotation(
    Placement(visible = true, transformation(origin = {-100, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(visible = true, transformation(origin = {9, -77}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage Quelle_Puffer(redeclare package Medium = Medium_sou, redeclare package Medium_HX_1 = Medium_sou, redeclare package Medium_HX_2 = Medium_sou, HX_1 = true, HX_2 = false, T_start = 20 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 2000, V = 0.12, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-10, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-20, -82}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_sou1(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {38, -22}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add6(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {127, -39}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis5(uHigh = 4, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {147, -39}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -42}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val8(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{4, 4}, {-4, -4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP1(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {-46, -60}, extent = {{-2, -2}, {2, 2}}, rotation = -90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP2(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {38, -42}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal4 annotation(
    Placement(visible = true, transformation(origin = {165, -39}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add7(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {149, -63}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {180, -72}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_El annotation(
    Placement(visible = true, transformation(origin = {72, -142}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not2 annotation(
    Placement(visible = true, transformation(origin = {-51, -107}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-105, -69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {7, -82}, extent = {{-7, -6}, {7, 6}}, rotation = 180)));
  Modelica.Blocks.Continuous.Integrator integrator_Heizstab annotation(
    Placement(visible = true, transformation(origin = {-38, -142}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_Th annotation(
    Placement(visible = true, transformation(origin = {38, -142}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division JAZ annotation(
    Placement(visible = true, transformation(origin = {-15, -141}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(visible = true, transformation(extent = {{-204, 130}, {-184, 150}}, rotation = 0), iconTransformation(extent = {{148, 50}, {168, 70}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-126, 4}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-223, 63}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {-62, 78}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 1000) annotation(
    Placement(visible = true, transformation(origin = {-26, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(
    Placement(visible = true, transformation(origin = {-31, 77}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum multiSum(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {12, -142}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_Heizstab_Puffer annotation(
    Placement(visible = true, transformation(origin = {128, -142}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Product product4 annotation(
    Placement(visible = true, transformation(origin = {169, 65}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Offset(k = 366.605) annotation(
    Placement(visible = true, transformation(origin = {169, 51}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Steigung(k = -0.245) annotation(
    Placement(visible = true, transformation(origin = {195, 61}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2 annotation(
    Placement(visible = true, transformation(origin = {141, 55}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Buildings.Controls.Continuous.LimPID conPID(Ti = 2000, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.01, strict = true, yMax = 0.95, yMin = 0.05) annotation(
    Placement(visible = true, transformation(origin = {117, 55}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 273.15 + 35) annotation(
    Placement(visible = true, transformation(origin = {-178, -22}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {-71, -49}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant4(k = 273.15 + 55) annotation(
    Placement(visible = true, transformation(origin = {-178, 0}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {-105, 1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
//Connections
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation(
    Line(points = {{152, 140}, {84.5, 140}, {84.5, 134}, {83.75, 134}, {83.75, 132}, {81, 132}}, color = {255, 204, 51}, thickness = 0.5));
  connect(hysteresis.y, not1.u) annotation(
    Line(points = {{-208.5, 101}, {-215, 101}}, color = {255, 0, 255}));
  connect(temperatureSensor.T, hysteresis.u) annotation(
    Line(points = {{-190, 100}, {-197, 100}, {-197, 101}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.port_air, temperatureSensor.port) annotation(
    Line(points = {{66, 129}, {-178, 129}, {-178, 100}}, color = {191, 0, 0}));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation(
    Line(points = {{64.8, 112.2}, {45.8, 112.2}, {45.8, 116.2}, {28.8, 116.2}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation(
    Line(points = {{64.8, 107.4}, {45.8, 107.4}, {45.8, 102.4}, {9.8, 102.4}}, color = {0, 0, 127}));
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{152, 140}, {106, 140}, {106, -92}, {36, -92}}, color = {255, 204, 51}, thickness = 0.5));
  connect(sla.port_a, bou_heat.ports[1]) annotation(
    Line(points = {{68, 76}, {74, 76}, {74, 81}, {80, 81}}, color = {0, 127, 255}));
  connect(sla.surf_a, Gebaeude_modell.port_surf) annotation(
    Line(points = {{56.8, 84}, {56.8, 124}, {65.8, 124}}, color = {191, 0, 0}));
  connect(STemp_heat1.port_b, sla.port_a) annotation(
    Line(points = {{86, 41}, {90, 41}, {90, 76}, {68, 76}}, color = {0, 127, 255}));
  connect(thermalCollector.port_b, STemp_sou1.port_b) annotation(
    Line(points = {{52, -82}, {60, -82}}, color = {0, 127, 255}));
  connect(booleanToReal1.y, product3.u2) annotation(
    Line(points = {{-29.6, -106}, {-22.1, -106}, {-22.1, -110}, {-14.6, -110}}, color = {0, 0, 127}));
  connect(const6.y, product3.u1) annotation(
    Line(points = {{-29.6, -116}, {-20.1, -116}, {-20.1, -114}, {-14.6, -114}}, color = {0, 0, 127}));
  connect(const.y, product1.u1) annotation(
    Line(points = {{-152, -66}, {-144.3, -66}, {-144.3, -58}, {-137, -58}}, color = {0, 0, 127}));
  connect(integerToReal.y, product1.u2) annotation(
    Line(points = {{-154, -48}, {-145.5, -48}, {-145.5, -52}, {-137, -52}}, color = {0, 0, 127}));
  connect(bou_sou.ports[1], pump_sou.port_a) annotation(
    Line(points = {{-28, -70}, {-28, -82}, {-26, -82}}, color = {0, 127, 255}));
  connect(TWW.port_a2, pump_TWW.port_a) annotation(
    Line(points = {{-64, 66}, {-72, 66}, {-72, 64}, {-86, 64}}, color = {0, 127, 255}));
  connect(vol.ports[1], thermalCollector.port_a) annotation(
    Line(points = {{21, -82}, {32, -82}}, color = {0, 127, 255}));
  connect(pulse.y, pump_TWW.m_flow_in) annotation(
    Line(points = {{-155.5, 79}, {-146, 79}, {-146, 86}, {-90, 86}, {-90, 70}}, color = {0, 0, 127}));
  connect(bou_loa.ports[1], pump_loa.port_a) annotation(
    Line(points = {{16, 10}, {23, 10}, {23, -2}, {38, -2}}, color = {0, 127, 255}));
  connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 72}, {-104, 72}, {-104, 64}, {-96, 64}}, color = {0, 127, 255}));
  connect(val11.port_a, TWW.port_b1) annotation(
    Line(points = {{66, 16}, {66, 28}, {-46, 28}, {-46, 66}, {-50, 66}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_2, TWW.port_a1) annotation(
    Line(points = {{-64, 11}, {-64, 11.25}, {-68, 11.25}, {-68, 27.5}, {-50, 27.5}, {-50, 48}}, color = {0, 127, 255}));
  connect(heaPum.port_a1, senTem.port_b) annotation(
    Line(points = {{-38, -2.4}, {-46, -2.4}, {-46, -3}}, color = {0, 127, 255}));
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
  connect(const5.y, add5.u2) annotation(
    Line(points = {{-162, 30}, {-142, 30}, {-142, 28}, {-115, 28}}, color = {0, 0, 127}));
  connect(hysteresis4.y, not11.u) annotation(
    Line(points = {{-175.5, 13}, {-169, 13}}, color = {255, 0, 255}));
  connect(not11.y, booleanToReal3.u) annotation(
    Line(points = {{-157.5, 13}, {-149, 13}}, color = {255, 0, 255}));
  connect(pulse1.y, val12.y) annotation(
    Line(points = {{-156, 60}, {-142, 60}, {-142, 34}, {-90, 34}, {-90, 44}}, color = {0, 0, 127}));
  connect(teeJunctionIdeal.port_3, senTem.port_a) annotation(
    Line(points = {{-58, 6}, {-58, -3}, {-56, -3}}, color = {0, 127, 255}));
  connect(not11.y, or1.u1) annotation(
    Line(points = {{-157.5, 13}, {-154, 13}, {-154, -10}, {-152, -10}}, color = {255, 0, 255}));
  connect(booleanToInteger.y, heaPum.uMod) annotation(
    Line(points = {{-94, -16}, {-64, -16}, {-64, -8}, {-40, -8}}, color = {255, 127, 0}));
  connect(booleanToInteger.y, integerToReal.u) annotation(
    Line(points = {{-94, -16}, {-90, -16}, {-90, -30}, {-168, -30}, {-168, -48}, {-163, -48}}, color = {255, 127, 0}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation(
    Line(points = {{12, -77}, {16, -77}, {16, -78}, {18, -78}}, color = {191, 0, 0}));
  connect(prescribedHeatFlow.Q_flow, product3.y) annotation(
    Line(points = {{6, -77}, {-6, -77}, {-6, -112}}, color = {0, 0, 127}));
  connect(heaPum.port_b2, Quelle_Puffer.port_a1) annotation(
    Line(points = {{-38, -16}, {-46, -16}, {-46, -51}, {-17, -51}}, color = {0, 127, 255}));
  connect(heaPum.port_a2, pump_sou1.port_b) annotation(
    Line(points = {{-10, -16}, {4, -16}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_b1, pump_sou1.port_a) annotation(
    Line(points = {{-16, -32}, {-20, -32}, {-20, -28}, {26, -28}, {26, -16}, {16, -16}}, color = {0, 127, 255}));
  connect(product1.y, pump_loa.m_flow_in) annotation(
    Line(points = {{-125.5, -55}, {-122, -55}, {-122, -34}, {-78, -34}, {-78, -30}, {46, -30}, {46, -12}}, color = {0, 0, 127}));
  connect(pump_sou1.port_a, bou_sou1.ports[1]) annotation(
    Line(points = {{16, -16}, {28, -16}, {28, -22}, {34, -22}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.T[1], add6.u2) annotation(
    Line(points = {{-18, -36}, {121, -36}}, color = {0, 0, 127}));
  connect(add6.y, hysteresis5.u) annotation(
    Line(points = {{132.5, -39}, {141, -39}}, color = {0, 0, 127}));
  connect(T_QP1.port_1, Quelle_Puffer.port_HX_1_b) annotation(
    Line(points = {{-46, -58}, {-46, -56}, {2, -56}, {2, -48}, {-2, -48}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_HX_1_a, val7.port_a) annotation(
    Line(points = {{-2, -46}, {7, -46}, {7, -42}, {16, -42}}, color = {0, 127, 255}));
  connect(val7.port_b, T_QP2.port_2) annotation(
    Line(points = {{24, -42}, {34, -42}}, color = {0, 127, 255}));
  connect(T_QP1.port_3, val8.port_a) annotation(
    Line(points = {{-44, -60}, {16, -60}}, color = {0, 127, 255}));
  connect(val8.port_b, T_QP2.port_3) annotation(
    Line(points = {{24, -60}, {38, -60}, {38, -46}}, color = {0, 127, 255}));
  connect(add6.u1, STemp_sou1.T) annotation(
    Line(points = {{121, -42}, {116, -42}, {116, -116}, {67, -116}, {67, -89}}, color = {0, 0, 127}));
  connect(hysteresis5.y, booleanToReal4.u) annotation(
    Line(points = {{152.5, -39}, {159, -39}}, color = {255, 0, 255}));
  connect(booleanToReal4.y, val7.y) annotation(
    Line(points = {{170, -38}, {176, -38}, {176, -50}, {20, -50}, {20, -46}}, color = {0, 0, 127}));
  connect(add7.u1, booleanToReal4.y) annotation(
    Line(points = {{156, -60}, {190, -60}, {190, -38}, {170, -38}}, color = {0, 0, 127}));
  connect(val8.y, add7.y) annotation(
    Line(points = {{20, -56}, {20, -52}, {138, -52}, {138, -62}, {144, -62}}, color = {0, 0, 127}));
  connect(const3.y, add7.u2) annotation(
    Line(points = {{176, -72}, {166, -72}, {166, -66}, {156, -66}}, color = {0, 0, 127}));
  connect(STemp_heat1.port_a, val10.port_a) annotation(
    Line(points = {{74, 42}, {70, 42}, {70, 28}, {96, 28}, {96, 0}, {90, 0}}, color = {0, 127, 255}));
  connect(sla.port_b, teeJunctionIdeal.port_1) annotation(
    Line(points = {{52, 76}, {48, 76}, {48, 20}, {-42, 20}, {-42, 10}, {-54, 10}, {-54, 12}}, color = {0, 127, 255}));
  connect(not1.y, or1.u2) annotation(
    Line(points = {{-226.5, 101}, {-229.25, 101}, {-229.25, 91}, {-202, 91}, {-202, -14}, {-152, -14}}, color = {255, 0, 255}));
  connect(booleanToReal1.u, not2.y) annotation(
    Line(points = {{-38.8, -106}, {-46.8, -106}}, color = {255, 0, 255}));
  connect(not2.u, hysteresis2.y) annotation(
    Line(points = {{-57, -107}, {-65, -107}, {-65, -109}}, color = {255, 0, 255}));
  connect(temperatureTwoPort.port_a, vol.ports[2]) annotation(
    Line(points = {{14, -82}, {22, -82}}, color = {0, 127, 255}));
  connect(temperatureTwoPort.port_b, pump_sou.port_b) annotation(
    Line(points = {{0, -82}, {-14, -82}}, color = {0, 127, 255}));
  connect(temperatureTwoPort.T, hysteresis2.u) annotation(
    Line(points = {{8, -88}, {8, -130}, {-80, -130}, {-80, -109}, {-75, -109}}, color = {0, 0, 127}));
  connect(pump_sou.m_flow_in, constant1.y) annotation(
    Line(points = {{-20, -90}, {-93.5, -90}, {-93.5, -69.5}, {-99.5, -69.5}, {-99.5, -69}}, color = {0, 0, 127}));
  connect(STemp_sou1.port_a, T_QP2.port_1) annotation(
    Line(points = {{74, -82}, {78, -82}, {78, -42}, {42, -42}}, color = {0, 127, 255}));
  connect(pump_sou.port_a, T_QP1.port_2) annotation(
    Line(points = {{-26, -82}, {-46, -82}, {-46, -62}}, color = {0, 127, 255}));
  connect(or1.y, booleanToInteger.u) annotation(
    Line(points = {{-138, -10}, {-108, -10}, {-108, -16}}, color = {255, 0, 255}));
  connect(integrator_Heizstab.u, product3.y) annotation(
    Line(points = {{-45, -142}, {-54.5, -142}, {-54.5, -134}, {-54, -134}, {-54, -131}, {-2, -131}, {-2, -112.5}, {-6, -112.5}, {-6, -112}}, color = {0, 0, 127}));
  connect(heaPum.QLoa_flow, integrator_WP_Th.u) annotation(
    Line(points = {{-8, 0}, {-4, 0}, {-4, -18}, {58, -18}, {58, -142}, {46, -142}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.y, JAZ.u1) annotation(
    Line(points = {{32, -142}, {26, -142}, {26, -134}, {0, -134}, {0, -137}, {-7, -137}}, color = {0, 0, 127}));
  connect(weaBus, weaDat1.weaBus) annotation(
    Line(points = {{-194, 140}, {152, 140}}, thickness = 0.5));
  connect(booleanToReal3.y, product.u2) annotation(
    Line(points = {{-138, 14}, {-130, 14}, {-130, 6}}, color = {0, 0, 127}));
  connect(not1.y, booleanToReal.u) annotation(
    Line(points = {{-226, 102}, {-232, 102}, {-232, 63}, {-229, 63}}, color = {255, 0, 255}));
  connect(multiProduct.u[1], booleanToReal.y) annotation(
    Line(points = {{-68, 78}, {-76, 78}, {-76, 94}, {-174, 94}, {-174, 62}, {-217.5, 62}, {-217.5, 63}}, color = {0, 0, 127}));
  connect(multiProduct.u[2], booleanToReal3.y) annotation(
    Line(points = {{-68, 78}, {-74, 78}, {-74, 14}, {-138, 14}}, color = {0, 0, 127}));
  connect(constant3.y, multiProduct.u[3]) annotation(
    Line(points = {{-22, 54}, {-16, 54}, {-16, 84}, {-72, 84}, {-72, 78}, {-68, 78}}, color = {0, 0, 127}));
  connect(multiProduct.y, prescribedHeatFlow1.Q_flow) annotation(
    Line(points = {{-54, 78}, {-51, 78}, {-51, 77}, {-36, 77}}, color = {0, 0, 127}));
  connect(multiSum.y, JAZ.u2) annotation(
    Line(points = {{4, -142}, {-6, -142}, {-6, -146}}, color = {0, 0, 127}));
  connect(integrator_Heizstab.y, multiSum.u[1]) annotation(
    Line(points = {{-32, -142}, {-28, -142}, {-28, -134}, {22, -134}, {22, -142}, {18, -142}}, color = {0, 0, 127}));
  connect(integrator_WP_El.y, multiSum.u[2]) annotation(
    Line(points = {{65, -142}, {18, -142}}, color = {0, 0, 127}));
  connect(integrator_Heizstab_Puffer.y, multiSum.u[3]) annotation(
    Line(points = {{121, -142}, {100, -142}, {100, -144}, {18, -144}, {18, -142}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow1.Q_flow, integrator_Heizstab_Puffer.u) annotation(
    Line(points = {{-36, 77}, {-37, 77}, {-37, 65}, {135, 65}, {135, -142}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow1.port, TWW.heatPort) annotation(
    Line(points = {{-26, 77}, {-26, 70}, {-60, 70}, {-60, 66}, {-58, 66}}, color = {191, 0, 0}));
  connect(Steigung.y, product4.u2) annotation(
    Line(points = {{190, 62}, {176, 62}}, color = {0, 0, 127}));
  connect(Offset.y, add2.u1) annotation(
    Line(points = {{164, 52}, {148, 52}}, color = {0, 0, 127}));
  connect(product4.y, add2.u2) annotation(
    Line(points = {{164, 66}, {148, 66}, {148, 58}}, color = {0, 0, 127}));
  connect(STemp_heat1.T, conPID.u_m) annotation(
    Line(points = {{80, 36}, {118, 36}, {118, 50}}, color = {0, 0, 127}));
  connect(add2.y, conPID.u_s) annotation(
    Line(points = {{136, 56}, {124, 56}}, color = {0, 0, 127}));
  connect(product4.u1, weaBus.TDryBul) annotation(
    Line(points = {{176, 68}, {190, 68}, {190, 140}, {-194, 140}}, color = {0, 0, 127}));
  connect(integerToReal.y, product2.u2) annotation(
    Line(points = {{-154, -48}, {-76, -48}, {-76, -46}}, color = {0, 0, 127}));
  connect(constant1.y, product2.u1) annotation(
    Line(points = {{-100, -68}, {-76, -68}, {-76, -52}}, color = {0, 0, 127}));
  connect(pump_sou1.m_flow_in, product2.y) annotation(
    Line(points = {{10, -24}, {-66, -24}, {-66, -48}}, color = {0, 0, 127}));
  connect(constant4.y, product.u1) annotation(
    Line(points = {{-174, 0}, {-130, 0}, {-130, 2}}, color = {0, 0, 127}));
  connect(constant2.y, max.u2) annotation(
    Line(points = {{-174, -22}, {-110, -22}, {-110, -2}}, color = {0, 0, 127}));
  connect(product.y, max.u1) annotation(
    Line(points = {{-122, 4}, {-110, 4}}, color = {0, 0, 127}));
  connect(max.y, heaPum.TSet) annotation(
    Line(points = {{-100, 2}, {-71, 2}, {-71, 0}, {-40, 0}}, color = {0, 0, 127}));
  connect(TWW.T[3], hysteresis4.u) annotation(
    Line(points = {{-50, 62}, {-40, 62}, {-40, 32}, {-186, 32}, {-186, 14}}, color = {0, 0, 127}));
  connect(booleanToReal3.y, val11.y) annotation(
    Line(points = {{-138, 14}, {-80, 14}, {-80, 24}, {56, 24}, {56, 12}, {62, 12}}, color = {0, 0, 127}));
  connect(add5.u1, booleanToReal3.y) annotation(
    Line(points = {{-114, 22}, {-132, 22}, {-132, 14}, {-138, 14}}, color = {0, 0, 127}));
  connect(add5.y, val10.y) annotation(
    Line(points = {{-104, 26}, {86, 26}, {86, 4}}, color = {0, 0, 127}));
  connect(integrator_WP_El.u, heaPum.P) annotation(
    Line(points = {{80, -142}, {92, -142}, {92, -10}, {-8, -10}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {9, 115}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-91, 23}, {91, -23}}), Rectangle(origin = {-47, 61}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{35, -29}, {-35, 29}}), Rectangle(origin = {45, 61}, fillColor = {255, 121, 161}, fillPattern = FillPattern.Solid, extent = {{55, -29}, {-55, 29}}), Rectangle(origin = {9, 2}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{91, -28}, {-91, 28}}), Rectangle(origin = {-165, -10}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-81, 146}, {81, -146}}), Rectangle(origin = {9, -96}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{91, -32}, {-91, 32}}), Rectangle(origin = {-111, 61}, fillColor = {169, 255, 169}, fillPattern = FillPattern.Solid, extent = {{27, -29}, {-27, 29}}), Rectangle(origin = {193, -298}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-91, 12}, {91, -12}}), Rectangle(origin = {155, -8}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-53, 146}, {53, -146}}), Rectangle(origin = {9, -45}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{91, -17}, {-91, 17}})}, coordinateSystem(extent = {{-150, -150}, {150, 150}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-6, Interval = 3600),
  Icon(coordinateSystem(extent = {{-150, -150}, {150, 150}})));
end HDU_PufferSourceOnly;
