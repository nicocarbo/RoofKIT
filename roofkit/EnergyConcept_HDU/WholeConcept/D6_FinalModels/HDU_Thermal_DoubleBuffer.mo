within RoofKIT.EnergyConcept_HDU.WholeConcept.D6_FinalModels;

model HDU_Thermal_DoubleBuffer
  // 3.1536e+07 stop time
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
    package Medium_loa = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.35, property_T = 283.15);
  package Medium_heat = Buildings.Media.Water;
  
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal = 1000 / 3600 "Source heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = 1000 / 3600 "Load heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mHeat_flow_nominal = 0.0556;
  
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{136, 136}, {116, 156}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {117, 15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  Buildings.Fluid.Sources.Boundary_pT bou_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-32, -70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {-24, -9}, extent = {{-14, -11}, {14, 11}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou1(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {10, -16}, extent = {{6, 6}, {-6, -6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_loa(redeclare replaceable package Medium = Medium_loa, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {45, -2}, extent = {{-7, 8}, {7, -8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {10, 18}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 400 / 3600) annotation(
    Placement(visible = true, transformation(origin = {-176, -96}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-162, -72}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-130, -75}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 1.62 * 12, Eta_zero = 0.535, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 0.00154 * 12) annotation(
    Placement(visible = true, transformation(origin = {42, -82}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-51, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort STemp_sou1(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {67, -82}, extent = {{-7, -6}, {7, 6}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant const6(k = -3000) annotation(
    Placement(visible = true, transformation(origin = {-30, -116}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uHigh = 90 + 273.15, uLow = 70 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-65, -109}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1 annotation(
    Placement(visible = true, transformation(origin = {-30, -106}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-6, -112}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_heat, redeclare package Medium_HX_1 = Medium_heat, redeclare package Medium_HX_2 = Medium_loa, HX_1 = false, HX_2 = true, T_start = 70 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 200, V = 0.185, nEle = 5, thickness_ins = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-58, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 63}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_heat, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 71}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_heat, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 47}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(redeclare package Medium = Medium_sou, V = 0.0003, m_flow_nominal = mSou_flow_nominal, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {21, -79}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {-105, 25}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const5(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-164, 30}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not11 annotation(
    Placement(visible = true, transformation(origin = {-163, 13}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-144, -10}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger annotation(
    Placement(visible = true, transformation(origin = {-100, -16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(visible = true, transformation(origin = {9, -71}, extent = {{-3, -3}, {3, 3}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage Quelle_Puffer(redeclare package Medium = Medium_sou, redeclare package Medium_HX_1 = Medium_sou, redeclare package Medium_HX_2 = Medium_sou, HX_1 = true, HX_2 = false, T_start = 20 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 2000, V = 1.0, height = 1.1, nEle = 5, thickness_ins = 0.15, thickness_wall = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-10, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-20, -82}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_sou1(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {38, -22}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add6(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {119, -39}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis5(uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {135, -39}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -42}, extent = {{4, -4}, {-4, 4}}, rotation = 180)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val8(redeclare package Medium = Medium_sou, dpValve_nominal = 6000, m_flow_nominal = mSou_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{4, 4}, {-4, -4}}, rotation = 180)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP1(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {-48, -62}, extent = {{-4, -4}, {4, 4}}, rotation = -90)));
  Modelica.Fluid.Fittings.TeeJunctionIdeal T_QP2(redeclare package Medium = Medium_sou) annotation(
    Placement(visible = true, transformation(origin = {38, -42}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal4 annotation(
    Placement(visible = true, transformation(origin = {151, -39}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add7(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {151, -71}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {176, -80}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort(redeclare package Medium = Medium_sou, m_flow_nominal = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {3, -82}, extent = {{-7, -6}, {7, 6}}, rotation = 180)));
  Modelica.Blocks.Nonlinear.Limiter limiter(limitsAtInit = true, uMax = 1500) annotation(
    Placement(visible = true, transformation(origin = {172, -148}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max annotation(
    Placement(visible = true, transformation(origin = {-11, -148}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_Th annotation(
    Placement(visible = true, transformation(origin = {118, -132}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Division JAZ annotation(
    Placement(visible = true, transformation(origin = {-63, -143}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator_WP_El annotation(
    Placement(visible = true, transformation(origin = {148, -148}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = 50) annotation(
    Placement(visible = true, transformation(origin = {44, -152}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter1(limitsAtInit = true, uMax = 6000) annotation(
    Placement(visible = true, transformation(origin = {142, -128}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = mSou_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-68, -84}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable HDU(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/Inputs/HDU_input.txt", table = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tableName = "HDU", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {54, 110}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -54) annotation(
    Placement(visible = true, transformation(origin = {8, 62}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 1 / 60) annotation(
    Placement(visible = true, transformation(origin = {-59, 83}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {-152, 94}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-161, 47}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort1(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {7, -3}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(
    Placement(visible = true, transformation(origin = {131, 29}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-110, -42}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = 2, uLow = -2) annotation(
    Placement(visible = true, transformation(origin = {-155, -57}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperature_floor_heat(redeclare package Medium = Medium_loa, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {83, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-189, -51}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Max max1 annotation(
    Placement(visible = true, transformation(origin = {-103, -1}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = 273.15 + 35) annotation(
    Placement(visible = true, transformation(origin = {-196, -28}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant4(k = 273.15 + 55) annotation(
    Placement(visible = true, transformation(origin = {-178, -2}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-124, 2}, extent = {{-4, 4}, {4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 50 / 54) annotation(
    Placement(visible = true, transformation(origin = {-190, 108}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Logical.And and2 annotation(
    Placement(visible = true, transformation(origin = {-136, -56}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = (-2) + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-119, -107}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Logical.And and3 annotation(
    Placement(visible = true, transformation(origin = {-118, -14}, extent = {{-6, 6}, {6, -6}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume1(redeclare package Medium = Medium_loa, V = 0.03, m_flow_nominal = mSou_flow_nominal, T_start = 35 + 273.15, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {30, 6}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-145, -109}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2 annotation(
    Placement(visible = true, transformation(origin = {37, 59}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume mixingVolume(redeclare package Medium = Medium_loa, T_start = 35 + 273.15, V = 0.033, m_flow_nominal = mSou_flow_nominal, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {66, 56}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-118, 12}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Max max2 annotation(
    Placement(visible = true, transformation(origin = {-145, -71}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal5 annotation(
    Placement(visible = true, transformation(origin = {-161, -85}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = 4.3 + senTem.T) annotation(
    Placement(visible = true, transformation(origin = {-268, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Max max3 annotation(
    Placement(visible = true, transformation(origin = {-233, -9}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Min min annotation(
    Placement(visible = true, transformation(origin = {-250, -24}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression1(y = 12.9 + senTem.T) annotation(
    Placement(visible = true, transformation(origin = {-276, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Controls.Continuous.LimPID conPID(Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 4, strict = true, yMax = 3000, yMin = 0) annotation(
    Placement(visible = true, transformation(origin = {167, 29}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {150, 11}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));

equation
//Connections
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{116, 146}, {106, 146}, {106, -92}, {36, -92}}, color = {255, 204, 51}, thickness = 0.5));
  connect(thermalCollector.port_b, STemp_sou1.port_b) annotation(
    Line(points = {{52, -82}, {60, -82}}, color = {0, 127, 255}));
  connect(booleanToReal1.y, product3.u2) annotation(
    Line(points = {{-25.6, -106}, {-18.1, -106}, {-18.1, -110}, {-10.6, -110}}, color = {0, 0, 127}));
  connect(const6.y, product3.u1) annotation(
    Line(points = {{-25.6, -116}, {-16.1, -116}, {-16.1, -114}, {-10.6, -114}}, color = {0, 0, 127}));
  connect(const.y, product1.u1) annotation(
    Line(points = {{-172, -96}, {-144.3, -96}, {-144.3, -78}, {-136, -78}}, color = {0, 0, 127}));
  connect(bou_sou.ports[1], pump_sou.port_a) annotation(
    Line(points = {{-28, -70}, {-28, -82}, {-26, -82}}, color = {0, 127, 255}));
  connect(STemp_sou1.T, hysteresis2.u) annotation(
    Line(points = {{67, -89}, {67, -124.6}, {-77, -124.6}, {-77, -109}, {-71, -109}}, color = {0, 0, 127}));
  connect(vol.ports[1], thermalCollector.port_a) annotation(
    Line(points = {{21, -82}, {32, -82}}, color = {0, 127, 255}));
  connect(bou_loa.ports[1], pump_loa.port_a) annotation(
    Line(points = {{14, 18}, {23, 18}, {23, -2}, {38, -2}}, color = {0, 127, 255}));
  connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 72}, {-104, 72}, {-104, 64}, {-96, 64}}, color = {0, 127, 255}));
  connect(heaPum.port_a1, senTem.port_b) annotation(
    Line(points = {{-38, -2.4}, {-46, -2.4}, {-46, -7}}, color = {0, 127, 255}));
  connect(pump_loa.port_b, teeJunctionIdeal1.port_1) annotation(
    Line(points = {{52, -2}, {62, -2}, {62, -1}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_3, val11.port_b) annotation(
    Line(points = {{67, 4}, {67, 8}, {66, 8}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal1.port_2, val10.port_b) annotation(
    Line(points = {{72, -1}, {88, -1}, {88, 0}, {82, 0}}, color = {0, 127, 255}));
  connect(Wasseranschluss.ports[1], val12.port_b) annotation(
    Line(points = {{-110, 48}, {-94, 48}}, color = {0, 127, 255}));
  connect(const5.y, add5.u2) annotation(
    Line(points = {{-160, 30}, {-142, 30}, {-142, 28}, {-111, 28}}, color = {0, 0, 127}));
  connect(hysteresis4.y, not11.u) annotation(
    Line(points = {{-175.5, 13}, {-169, 13}}, color = {255, 0, 255}));
  connect(not11.y, booleanToReal3.u) annotation(
    Line(points = {{-157.5, 13}, {-149, 13}}, color = {255, 0, 255}));
  connect(teeJunctionIdeal.port_3, senTem.port_a) annotation(
    Line(points = {{-58, 6}, {-58, -6}, {-56, -6}}, color = {0, 127, 255}));
  connect(not11.y, or1.u1) annotation(
    Line(points = {{-157.5, 13}, {-154, 13}, {-154, -10}, {-152, -10}}, color = {255, 0, 255}));
  connect(booleanToInteger.y, heaPum.uMod) annotation(
    Line(points = {{-94, -16}, {-64, -16}, {-64, -8}, {-40, -8}}, color = {255, 127, 0}));
  connect(booleanToInteger.y, integerToReal.u) annotation(
    Line(points = {{-94, -16}, {-90, -16}, {-90, -32}, {-168, -32}, {-168, -72}, {-167, -72}}, color = {255, 127, 0}));
  connect(hysteresis2.y, booleanToReal1.u) annotation(
    Line(points = {{-59.5, -109}, {-47.5, -109}, {-47.5, -106}, {-35, -106}}, color = {255, 0, 255}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation(
    Line(points = {{12, -71}, {16, -71}, {16, -78}, {18, -78}}, color = {191, 0, 0}));
  connect(prescribedHeatFlow.Q_flow, product3.y) annotation(
    Line(points = {{6, -71}, {-2, -71}, {-2, -112}}, color = {0, 0, 127}));
  connect(heaPum.port_b2, Quelle_Puffer.port_a1) annotation(
    Line(points = {{-38, -16}, {-46, -16}, {-46, -51}, {-17, -51}}, color = {0, 127, 255}));
  connect(heaPum.port_a2, pump_sou1.port_b) annotation(
    Line(points = {{-10, -16}, {4, -16}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_b1, pump_sou1.port_a) annotation(
    Line(points = {{-16, -32}, {-20, -32}, {-20, -28}, {24, -28}, {24, -16}, {16, -16}}, color = {0, 127, 255}));
  connect(product1.y, pump_loa.m_flow_in) annotation(
    Line(points = {{-124.5, -75}, {-122, -75}, {-122, -34}, {-78, -34}, {-78, -30}, {46, -30}, {46, -12}}, color = {0, 0, 127}));
  connect(product1.y, pump_sou1.m_flow_in) annotation(
    Line(points = {{-124.5, -75}, {-122, -75}, {-122, -34}, {-78, -34}, {-78, -30}, {10, -30}, {10, -24}}, color = {0, 0, 127}));
  connect(pump_sou1.port_a, bou_sou1.ports[1]) annotation(
    Line(points = {{16, -16}, {28, -16}, {28, -22}, {34, -22}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.T[1], add6.u2) annotation(
    Line(points = {{-18, -36}, {113, -36}}, color = {0, 0, 127}));
  connect(add6.y, hysteresis5.u) annotation(
    Line(points = {{124.5, -39}, {129, -39}}, color = {0, 0, 127}));
  connect(T_QP1.port_1, Quelle_Puffer.port_HX_1_b) annotation(
    Line(points = {{-48, -58}, {-48, -56}, {2, -56}, {2, -48}, {-2, -48}}, color = {0, 127, 255}));
  connect(Quelle_Puffer.port_HX_1_a, val7.port_a) annotation(
    Line(points = {{-2, -46}, {7, -46}, {7, -42}, {16, -42}}, color = {0, 127, 255}));
  connect(val7.port_b, T_QP2.port_2) annotation(
    Line(points = {{24, -42}, {34, -42}}, color = {0, 127, 255}));
  connect(T_QP1.port_3, val8.port_a) annotation(
    Line(points = {{-44, -62}, {-14, -62}, {-14, -60}, {16, -60}}, color = {0, 127, 255}));
  connect(val8.port_b, T_QP2.port_3) annotation(
    Line(points = {{24, -60}, {38, -60}, {38, -46}}, color = {0, 127, 255}));
  connect(add6.u1, STemp_sou1.T) annotation(
    Line(points = {{113, -42}, {110, -42}, {110, -96}, {67, -96}, {67, -89}}, color = {0, 0, 127}));
  connect(val8.y, add7.y) annotation(
    Line(points = {{20, -56}, {20, -54}, {138, -54}, {138, -71}, {145.5, -71}}, color = {0, 0, 127}));
  connect(const3.y, add7.u2) annotation(
    Line(points = {{172, -80}, {162.5, -80}, {162.5, -74}, {157, -74}}, color = {0, 0, 127}));
  connect(pump_sou.port_b, temperatureTwoPort.port_b) annotation(
    Line(points = {{-14, -82}, {-4, -82}}, color = {0, 127, 255}));
  connect(temperatureTwoPort.port_a, vol.ports[2]) annotation(
    Line(points = {{10, -82}, {22, -82}}, color = {0, 127, 255}));
  connect(constant3.y, max.u2) annotation(
    Line(points = {{40, -152}, {-3, -152}}, color = {0, 0, 127}));
  connect(JAZ.u2, max.y) annotation(
    Line(points = {{-55, -147}, {-36, -147}, {-36, -148}, {-19, -148}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.y, JAZ.u1) annotation(
    Line(points = {{111, -132}, {84, -132}, {84, -139}, {-55, -139}}, color = {0, 0, 127}));
  connect(integrator_WP_Th.u, limiter1.y) annotation(
    Line(points = {{125, -132}, {131, -132}, {131, -128}, {136, -128}}, color = {0, 0, 127}));
  connect(integrator_WP_El.u, limiter.y) annotation(
    Line(points = {{155.2, -148}, {165.2, -148}}, color = {0, 0, 127}));
  connect(limiter1.u, heaPum.QLoa_flow) annotation(
    Line(points = {{150, -128}, {188, -128}, {188, 2}, {77, 2}, {77, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(limiter.u, heaPum.P) annotation(
    Line(points = {{180, -148}, {194, -148}, {194, -10}, {-8, -10}}, color = {0, 0, 127}));
  connect(STemp_sou1.port_a, T_QP2.port_1) annotation(
    Line(points = {{74, -82}, {78, -82}, {78, -42}, {42, -42}}, color = {0, 127, 255}));
  connect(pump_sou.port_a, T_QP1.port_2) annotation(
    Line(points = {{-26, -82}, {-48, -82}, {-48, -66}}, color = {0, 127, 255}));
  connect(integrator_WP_El.y, max.u1) annotation(
    Line(points = {{142, -148}, {130, -148}, {130, -144}, {-3, -144}}, color = {0, 0, 127}));
  connect(constant1.y, pump_sou.m_flow_in) annotation(
    Line(points = {{-64, -84}, {-64, -85}, {-60, -85}, {-60, -92}, {-20, -92}, {-20, -90}}, color = {0, 0, 127}));
  connect(hysteresis5.y, booleanToReal4.u) annotation(
    Line(points = {{140.5, -39}, {145, -39}}, color = {255, 0, 255}));
  connect(booleanToReal4.y, add7.u1) annotation(
    Line(points = {{156, -38}, {174, -38}, {174, -68}, {158, -68}}, color = {0, 0, 127}));
  connect(booleanToReal4.y, val7.y) annotation(
    Line(points = {{156, -38}, {160, -38}, {160, -50}, {20, -50}, {20, -46}}, color = {0, 0, 127}));
  connect(gain.u, HDU.y[3]) annotation(
    Line(points = {{-2, 62}, {-6, 62}, {-6, 110}, {43, 110}}, color = {0, 0, 127}));
  connect(gain1.u, HDU.y[10]) annotation(
    Line(points = {{-50, 84}, {-44, 84}, {-44, 110}, {43, 110}}, color = {0, 0, 127}));
  connect(gain1.y, pump_TWW.m_flow_in) annotation(
    Line(points = {{-66, 84}, {-90, 84}, {-90, 70}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold2.y, booleanToReal.u) annotation(
    Line(points = {{-161, 94}, {-170.5, 94}, {-170.5, 47}, {-167, 47}}, color = {255, 0, 255}));
  connect(gain1.y, greaterEqualThreshold2.u) annotation(
    Line(points = {{-66, 84}, {-66, 94}, {-142, 94}}, color = {0, 0, 127}));
  connect(booleanToReal.y, val12.y) annotation(
    Line(points = {{-155.5, 47}, {-150, 47}, {-150, 34}, {-90, 34}, {-90, 44}}, color = {0, 0, 127}));
  connect(heaPum.port_b1, temperatureTwoPort1.port_a) annotation(
    Line(points = {{-10, -2}, {0, -2}, {0, -3}, {2, -3}}, color = {0, 127, 255}));
  connect(val12.port_a, TWW.port_a1) annotation(
    Line(points = {{-86, 48}, {-64, 48}}, color = {0, 127, 255}));
  connect(pump_TWW.port_a, TWW.port_b1) annotation(
    Line(points = {{-86, 64}, {-76, 64}, {-76, 66}, {-64, 66}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_2, TWW.port_HX_2_b) annotation(
    Line(points = {{-64, 12}, {-74, 12}, {-74, 28}, {-44, 28}, {-44, 60}, {-50, 60}}, color = {0, 127, 255}));
  connect(val11.port_a, TWW.port_HX_2_a) annotation(
    Line(points = {{66, 16}, {66, 28}, {-30, 28}, {-30, 62}, {-50, 62}}, color = {0, 127, 255}));
  connect(val10.port_a, temperature_floor_heat.port_b) annotation(
    Line(points = {{90, 0}, {96, 0}, {96, 50}, {88, 50}}, color = {0, 127, 255}));
  connect(hysteresis.u, add1.y) annotation(
    Line(points = {{-161, -57}, {-172.25, -57}, {-172.25, -51}, {-183.5, -51}}, color = {0, 0, 127}));
  connect(temperature_floor_heat.T, add1.u2) annotation(
    Line(points = {{84, 54}, {112, 54}, {112, 130}, {-224.5, 130}, {-224.5, -54}, {-195, -54}}, color = {0, 0, 127}));
  connect(constant4.y, product.u1) annotation(
    Line(points = {{-174, -2}, {-160, -2}, {-160, 0}, {-128, 0}}, color = {0, 0, 127}));
  connect(booleanToReal3.y, product.u2) annotation(
    Line(points = {{-138, 14}, {-134, 14}, {-134, 4}, {-128, 4}}, color = {0, 0, 127}));
  connect(product.y, max1.u1) annotation(
    Line(points = {{-120, 2}, {-108, 2}}, color = {0, 0, 127}));
  connect(constant2.y, max1.u2) annotation(
    Line(points = {{-192, -28}, {-166, -28}, {-166, -4}, {-108, -4}}, color = {0, 0, 127}));
  connect(HDU.y[3], greaterEqualThreshold.u) annotation(
    Line(points = {{44, 110}, {-180, 110}, {-180, 108}}, color = {0, 0, 127}));
  connect(add1.u1, constant2.y) annotation(
    Line(points = {{-194, -48}, {-202, -48}, {-202, -40}, {-184, -40}, {-184, -28}, {-192, -28}}, color = {0, 0, 127}));
  connect(hysteresis.y, and2.u1) annotation(
    Line(points = {{-149.5, -57}, {-143.5, -57}}, color = {255, 0, 255}));
  connect(greaterEqualThreshold.y, and2.u2) annotation(
    Line(points = {{-199, 108}, {-208, 108}, {-208, -51}, {-143, -51}}, color = {255, 0, 255}));
  connect(and2.y, or1.u2) annotation(
    Line(points = {{-129, -56}, {-128, -56}, {-128, -34}, {-164, -34}, {-164, -14}, {-152, -14}}, color = {255, 0, 255}));
  connect(and3.y, booleanToInteger.u) annotation(
    Line(points = {{-111, -14}, {-113.5, -14}, {-113.5, -16}, {-108, -16}}, color = {255, 0, 255}));
  connect(or1.y, and3.u2) annotation(
    Line(points = {{-138, -10}, {-131, -10}, {-131, -9}, {-125, -9}}, color = {255, 0, 255}));
  connect(mixingVolume1.ports[1], temperatureTwoPort1.port_b) annotation(
    Line(points = {{30, 0}, {12, 0}, {12, -2}}, color = {0, 127, 255}));
  connect(mixingVolume1.ports[2], pump_loa.port_a) annotation(
    Line(points = {{30, 0}, {38, 0}, {38, -2}}, color = {0, 127, 255}));
  connect(mixingVolume1.heatPort, prescribedHeatFlow1.port) annotation(
    Line(points = {{36, 6}, {42, 6}, {42, 22}, {110, 22}, {110, 30}, {122, 30}}, color = {191, 0, 0}));
  connect(lessEqualThreshold.y, not1.u) annotation(
    Line(points = {{-126, -106}, {-136, -106}, {-136, -108}, {-138, -108}}, color = {255, 0, 255}));
  connect(and3.u1, not1.y) annotation(
    Line(points = {{-126, -14}, {-130, -14}, {-130, -24}, {-154, -24}, {-154, -108}, {-150, -108}}, color = {255, 0, 255}));
  connect(or1.y, and1.u2) annotation(
    Line(points = {{-138, -10}, {-138, -38}, {-118, -38}}, color = {255, 0, 255}));
  connect(lessEqualThreshold.y, and1.u1) annotation(
    Line(points = {{-126, -106}, {-126, -82}, {-120, -82}, {-120, -42}, {-118, -42}}, color = {255, 0, 255}));
  connect(prescribedHeatFlow2.Q_flow, gain.y) annotation(
    Line(points = {{28, 60}, {23, 60}, {23, 62}, {17, 62}}, color = {0, 0, 127}));
  connect(temperature_floor_heat.port_a, mixingVolume.ports[1]) annotation(
    Line(points = {{78, 50}, {66, 50}}, color = {0, 127, 255}));
  connect(teeJunctionIdeal.port_1, mixingVolume.ports[2]) annotation(
    Line(points = {{-54, 12}, {-4, 12}, {-4, 40}, {34, 40}, {34, 50}, {66, 50}}, color = {0, 127, 255}));
  connect(mixingVolume.heatPort, prescribedHeatFlow2.port) annotation(
    Line(points = {{60, 56}, {56, 56}, {56, 60}, {46, 60}}, color = {191, 0, 0}));
  connect(gain3.u, booleanToReal3.y) annotation(
    Line(points = {{-125, 12}, {-138, 12}, {-138, 14}}, color = {0, 0, 127}));
  connect(gain3.y, val11.y) annotation(
    Line(points = {{-111, 12}, {61, 12}}, color = {0, 0, 127}));
  connect(add5.y, val10.y) annotation(
    Line(points = {{-99.5, 25}, {86, 25}, {86, 4}}, color = {0, 0, 127}));
  connect(add5.u1, gain3.y) annotation(
    Line(points = {{-110, 22}, {-111, 22}, {-111, 12}}, color = {0, 0, 127}));
  connect(Quelle_Puffer.T[2], lessEqualThreshold.u) annotation(
    Line(points = {{-18, -36}, {-70, -36}, {-70, -70}, {-102, -70}, {-102, -106}, {-110, -106}}, color = {0, 0, 127}));
  connect(product1.u2, max2.y) annotation(
    Line(points = {{-136, -72}, {-140, -72}, {-140, -70}}, color = {0, 0, 127}));
  connect(integerToReal.y, max2.u1) annotation(
    Line(points = {{-158, -72}, {-156, -72}, {-156, -68}, {-150, -68}}, color = {0, 0, 127}));
  connect(and1.y, booleanToReal5.u) annotation(
    Line(points = {{-104, -42}, {-94, -42}, {-94, -64}, {-176, -64}, {-176, -84}, {-166, -84}}, color = {255, 0, 255}));
  connect(booleanToReal5.y, max2.u2) annotation(
    Line(points = {{-156, -84}, {-150, -84}, {-150, -74}}, color = {0, 0, 127}));
  connect(max1.y, min.u2) annotation(
    Line(points = {{-98, 0}, {-90, 0}, {-90, -40}, {-266, -40}, {-266, -28}, {-258, -28}}, color = {0, 0, 127}));
  connect(min.u1, realExpression1.y) annotation(
    Line(points = {{-258, -20}, {-260, -20}, {-260, -18}, {-264, -18}}, color = {0, 0, 127}));
  connect(min.y, max3.u2) annotation(
    Line(points = {{-244, -24}, {-242, -24}, {-242, -12}, {-239, -12}}, color = {0, 0, 127}));
  connect(max3.y, heaPum.TSet) annotation(
    Line(points = {{-228, -8}, {-208, -8}, {-208, -6}, {-46, -6}, {-46, 0}, {-40, 0}}, color = {0, 0, 127}));
  connect(realExpression.y, max3.u1) annotation(
    Line(points = {{-256, 10}, {-252, 10}, {-252, -6}, {-238, -6}}, color = {0, 0, 127}));
  connect(max1.y, conPID.u_s) annotation(
    Line(points = {{-98, 0}, {-94, 0}, {-94, 20}, {188, 20}, {188, 29}, {173, 29}}, color = {0, 0, 127}));
  connect(prescribedHeatFlow1.Q_flow, product2.y) annotation(
    Line(points = {{140, 30}, {144, 30}, {144, 12}}, color = {0, 0, 127}));
  connect(product2.u2, conPID.y) annotation(
    Line(points = {{156, 14}, {160, 14}, {160, 29}, {161.5, 29}}, color = {0, 0, 127}));
  connect(max2.y, product2.u1) annotation(
    Line(points = {{-140, -70}, {-138, -70}, {-138, -68}, {-86, -68}, {-86, -32}, {110, -32}, {110, -4}, {174, -4}, {174, 8}, {156, 8}}, color = {0, 0, 127}));
  connect(hysteresis4.u, TWW.T[4]) annotation(
    Line(points = {{-186, 14}, {-194, 14}, {-194, 38}, {-74, 38}, {-74, 62}, {-66, 62}}, color = {0, 0, 127}));
  connect(temperatureTwoPort1.T, conPID.u_m) annotation(
    Line(points = {{8, 2}, {12, 2}, {12, 10}, {22, 10}, {22, 36}, {110, 36}, {110, 42}, {168, 42}, {168, 36}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {9, 115}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-91, 23}, {91, -23}}), Rectangle(origin = {-47, 61}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{35, -29}, {-35, 29}}), Rectangle(origin = {45, 61}, fillColor = {255, 121, 161}, fillPattern = FillPattern.Solid, extent = {{55, -29}, {-55, 29}}), Rectangle(origin = {9, 2}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{91, -28}, {-91, 28}}), Rectangle(origin = {-165, -10}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-81, 146}, {81, -146}}), Rectangle(origin = {9, -96}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{91, -32}, {-91, 32}}), Rectangle(origin = {-111, 61}, fillColor = {169, 255, 169}, fillPattern = FillPattern.Solid, extent = {{27, -29}, {-27, 29}}), Rectangle(origin = {9, -142}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-91, 12}, {91, -12}}), Rectangle(origin = {155, -8}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-53, 146}, {53, -146}}), Rectangle(origin = {9, -45}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{91, -17}, {-91, 17}})}, coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-6, Interval = 3600),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end HDU_Thermal_DoubleBuffer;
