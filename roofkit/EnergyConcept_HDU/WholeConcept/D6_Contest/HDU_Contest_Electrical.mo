within RoofKIT.EnergyConcept_HDU.WholeConcept.D6_Contest;

model HDU_Contest_Electrical
  // 3.1536e+07 stop time
  // StartTime = 13392000, StopTime = 13996800 // Sunny week
  // StartTime = 14509700, StopTime = 15114500 // Cloudy week
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = 300 / 3600 "Nominal mass flow rate";
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {54, 166}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //DIN ISO 13790
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat_TWW(redeclare replaceable package Medium = Medium_wat, addPowerToMedium = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 0) annotation(
    Placement(visible = true, transformation(origin = {37, 94}, extent = {{7, -8}, {-7, 8}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage TWW(redeclare package Medium = Medium_wat, redeclare package Medium_HX_1 = Medium_wat, redeclare package Medium_HX_2 = Medium_wat, HX_1 = true, HX_2 = false, T_start = 50 + 273.15, UA_HX_1 = 20000, UA_HX_2 = 20000, V = 0.185, height = 0.5, nEle = 5, thickness_ins = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-38, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_TWW(redeclare replaceable package Medium = Medium_wat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-91, 105}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Waschbecken(redeclare package Medium = Medium_wat, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 111}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT Wasseranschluss(redeclare package Medium = Medium_wat, T = 12 + 273.15, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-119, 85}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val12(redeclare package Medium = Medium_wat, dpValve_nominal = 6000, m_flow_nominal = mLoa_flow_nominal, riseTime = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, 86}, extent = {{4, 4}, {-4, -4}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hyst_TWW(uHigh = 43 + 273.15, uLow = 40 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-149, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0) annotation(
    Placement(visible = true, transformation(origin = {-156, 130}, extent = {{8, 8}, {-8, -8}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-149, 95}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_eheat_TWW annotation(
    Placement(visible = true, transformation(origin = {146, 73}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal btr_TWW annotation(
    Placement(visible = true, transformation(origin = {-95, 49}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not_TWW annotation(
    Placement(visible = true, transformation(origin = {-133, 55}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 16, V_nominal = 400, azi(displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {-44, -126}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 480 / 480, eta = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-142, -136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 480, f = 60) annotation(
    Placement(visible = true, transformation(origin = {-92, 178}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(origin = {-165, -100}, extent = {{-7, -8}, {7, 8}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 18000000, SOC_start = 0.4, V_nominal = 110) annotation(
    Placement(visible = true, transformation(origin = {-88, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Utilities.Time.CalendarTime calTim(day(start = 1), hour(start = 0), zerTim = Buildings.Utilities.Time.Types.ZeroTime.Custom) annotation(
    Placement(visible = true, transformation(origin = {-38, 32}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal itr_time annotation(
    Placement(visible = true, transformation(origin = {-67, 31}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add_pow annotation(
    Placement(visible = true, transformation(origin = {-138, -100}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold less_TWW(threshold = 15) annotation(
    Placement(visible = true, transformation(origin = {-175, 59}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterThreshold gre_TWW(threshold = 9) annotation(
    Placement(visible = true, transformation(origin = {-175, 43}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW1 annotation(
    Placement(visible = true, transformation(origin = {-133, 43}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and_TWW2 annotation(
    Placement(visible = true, transformation(origin = {-115, 51}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {-151, -117}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temp_ret_TWW(redeclare package Medium = Medium_wat, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {27, 73}, extent = {{-5, 5}, {5, -5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temp_sup_TWW(redeclare package Medium = Medium_wat, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {63, 95}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Fluid.MixingVolumes.MixingVolume heater_TWW(redeclare package Medium = Medium_wat, T_start = 35 + 273.15, V = 0.15, m_flow_nominal = mLoa_flow_nominal, nPorts = 2) annotation(
    Placement(visible = true, transformation(origin = {56, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Eheater_TWW annotation(
    Placement(visible = true, transformation(origin = {97, 59}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT MAG_TWW(redeclare package Medium = Medium_wat, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {88, 106}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse TWW_cons(amplitude = 100 / 20 / 60, period = 86400, startTime = 36000, width = 20 * 60 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-53, 137}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temp_TWW(redeclare package Medium = Medium_wat, m_flow_nominal = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-71, 105}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.HeatTransfer.Sources.FixedTemperature temp_Kern(T = 25 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {5, 117}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression reg_Eheat(y = max(mLoa_flow_nominal * 4200 * (43 + 273.15 - temp_ret_TWW.T), 3000)) annotation(
    Placement(visible = true, transformation(origin = {172, 97}, extent = {{10, -7}, {-10, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Product prod_pump annotation(
    Placement(visible = true, transformation(origin = {54, 123}, extent = {{5, 5}, {-5, -5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant pump_flow(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {78, 132}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Gain COP(k = 1 / 5.8) annotation(
    Placement(visible = true, transformation(origin = {56, 34}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse TWW_cons_short(amplitude = 50 / 10 / 60, period = 86400, startTime = 43200, width = 10 * 60 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-53, 121}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add_TWW annotation(
    Placement(visible = true, transformation(origin = {-81, 125}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl_Contest batteryControl_Contest annotation(
    Placement(visible = true, transformation(origin = {-83, -100}, extent = {{-11, -12}, {11, 12}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Oven(amplitude = 2500, period = 86400, startTime = 68400, width = 3600 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-49, -37}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Stove(amplitude = 3000, period = 86400, startTime = 64800, width = 3600 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-49, -17}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Dishwasher(amplitude = 1800, period = 86400, startTime = 50400, width = 3600 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-49, 5}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Washmachine(amplitude = 1900, period = 86400, startTime = 55000, width = 3600 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-23, 7}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Blinds(amplitude = 1400, period = 43200, startTime = 9 * 3600, width = 60 * 100 / 28800) annotation(
    Placement(visible = true, transformation(origin = {-49, -53}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Skylight(amplitude = 800, period = 43200, startTime = 32400, width = 60 * 100 / 28800) annotation(
    Placement(visible = true, transformation(origin = {-21, -31}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Lighting(amplitude = 360, period = 86400, startTime = 72000, width =  2.35 * 456 * 3600 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-23, -11}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Refrigerator(k = 100) annotation(
    Placement(visible = true, transformation(origin = {-20, -54}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant BMS(k = 25) annotation(
    Placement(visible = true, transformation(origin = {-140, -70}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum var_load(nu = 10) annotation(
    Placement(visible = true, transformation(origin = {-90, -28}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_h annotation(
    Placement(visible = true, transformation(origin = {166, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_s annotation(
    Placement(visible = true, transformation(origin = {164, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_g annotation(
    Placement(visible = true, transformation(origin = {94, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_f annotation(
    Placement(visible = true, transformation(origin = {30, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_c annotation(
    Placement(visible = true, transformation(origin = {125, -25}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_eb(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {82, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression I_sc(y = (E_g.y - E_f.y) / E_g.y) annotation(
    Placement(visible = true, transformation(origin = {28, 1}, extent = {{10, -7}, {-10, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_grid(k = -1) annotation(
    Placement(visible = true, transformation(origin = {66, -60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter lim_grid(limitsAtInit = true, uMax = 100000, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {40, -60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = grid.P.real) annotation(
    Placement(visible = true, transformation(origin = {156, -65}, extent = {{10, -7}, {-10, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_c_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {122, 8}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_eb_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {56, -2}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Others(amplitude = 100, period = 86400, startTime = 3600*8, width = 3600*14 * 100 / 86400) annotation(
    Placement(visible = true, transformation(origin = {-87, -61}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum load_syste(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {-146, -34}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant vent_facade(k = 6) annotation(
    Placement(visible = true, transformation(origin = {-172, -46}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse vent_exhaust(amplitude = 20, period = 28800, startTime = 3600*8, width = 3600 * 100 / 28800) annotation(
    Placement(visible = true, transformation(origin = {-173, -15}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Mobility(amplitude = 125, period = 864000, startTime = 3600 * 8, width = 3600 * 4 * 100 / 864000) annotation(
    Placement(visible = true, transformation(origin = {-7, -65}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
equation
//Connections
  connect(Waschbecken.ports[1], pump_TWW.port_b) annotation(
    Line(points = {{-110, 111}, {-104, 111}, {-104, 105}, {-96, 105}}, color = {0, 127, 255}));
  connect(Wasseranschluss.ports[1], val12.port_b) annotation(
    Line(points = {{-110, 85}, {-102, 85}, {-102, 86}, {-94, 86}}, color = {0, 127, 255}));
  connect(greaterEqualThreshold2.y, booleanToReal.u) annotation(
    Line(points = {{-165, 130}, {-174.5, 130}, {-174.5, 95}, {-155, 95}}, color = {255, 0, 255}));
  connect(booleanToReal.y, val12.y) annotation(
    Line(points = {{-143.5, 95}, {-150, 95}, {-150, 72}, {-90, 72}, {-90, 81}}, color = {0, 0, 127}));
  connect(val12.port_a, TWW.port_a1) annotation(
    Line(points = {{-86, 86}, {-75, 86}, {-75, 85}, {-45, 85}}, color = {0, 127, 255}));
  connect(hyst_TWW.y, not_TWW.u) annotation(
    Line(points = {{-143.5, 55}, {-139, 55}}, color = {255, 0, 255}));
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{-132, -136}, {-118, -136}, {-118, -140}, {-98, -140}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{-152, -136}, {-198, -136}, {-198, 162}, {-92, 162}, {-92, 168}}));
  connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{-34, -126}, {-25, -126}, {-25, -146}, {-123.5, -146}, {-123.5, -136}, {-132, -136}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{-172, -100}, {-172, -101.5}, {-198, -101.5}, {-198, 163}, {-92, 163}, {-92, 168}}));
  connect(weaDat1.weaBus, pVSimpleOriented.weaBus);
  connect(calTim.hour, itr_time.u) annotation(
    Line(points = {{-45, 36}, {-58.4, 36}, {-58.4, 31}, {-61, 31}}, color = {255, 127, 0}));
  connect(itr_time.y, gre_TWW.u) annotation(
    Line(points = {{-72.5, 31}, {-84, 31}, {-84, 28}, {-192, 28}, {-192, 43}, {-181, 43}}, color = {0, 0, 127}));
  connect(itr_time.y, less_TWW.u) annotation(
    Line(points = {{-72.5, 31}, {-84, 31}, {-84, 28}, {-192, 28}, {-192, 59}, {-181, 59}}, color = {0, 0, 127}));
  connect(not_TWW.y, and_TWW2.u2) annotation(
    Line(points = {{-127.5, 55}, {-121, 55}}, color = {255, 0, 255}));
  connect(and_TWW2.y, btr_TWW.u) annotation(
    Line(points = {{-109.5, 51}, {-106, 51}, {-106, 49}, {-101, 49}}, color = {255, 0, 255}));
  connect(and_TWW2.u1, and_TWW1.y) annotation(
    Line(points = {{-120, 52}, {-122, 52}, {-122, 44}, {-128, 44}}, color = {255, 0, 255}));
  connect(and_TWW1.u1, gre_TWW.y) annotation(
    Line(points = {{-138, 44}, {-170, 44}}, color = {255, 0, 255}));
  connect(and_TWW1.u2, less_TWW.y) annotation(
    Line(points = {{-138, 48}, {-166, 48}, {-166, 60}, {-170, 60}}, color = {255, 0, 255}));
  connect(gain_el.u, add_pow.y) annotation(
    Line(points = {{-142.6, -117}, {-136.6, -117}, {-136.6, -109}, {-148.6, -109}, {-148.6, -101}, {-144.6, -101}}, color = {0, 0, 127}));
  connect(RL.Pow, gain_el.y) annotation(
    Line(points = {{-158, -100}, {-154, -100}, {-154, -110}, {-166, -110}, {-166, -116}, {-158, -116}}, color = {0, 0, 127}));
  connect(TWW.port_HX_1_a, pump_heat_TWW.port_b) annotation(
    Line(points = {{-31, 90}, {-26, 90}, {-26, 94}, {30, 94}}, color = {0, 127, 255}));
  connect(temp_ret_TWW.port_a, TWW.port_HX_1_b) annotation(
    Line(points = {{22, 73}, {-26, 73}, {-26, 88}, {-31, 88}}, color = {0, 127, 255}));
  connect(temp_ret_TWW.port_b, heater_TWW.ports[1]) annotation(
    Line(points = {{32, 73}, {56, 73}, {56, 74}}, color = {0, 127, 255}));
  connect(heater_TWW.heatPort, Eheater_TWW.port) annotation(
    Line(points = {{62, 68}, {74, 68}, {74, 59}, {88, 59}}, color = {191, 0, 0}));
  connect(pump_heat_TWW.port_a, temp_sup_TWW.port_a) annotation(
    Line(points = {{44, 94}, {50, 94}, {50, 96}, {58, 96}}, color = {0, 127, 255}));
  connect(temp_sup_TWW.port_b, heater_TWW.ports[2]) annotation(
    Line(points = {{68, 95}, {84, 95}, {84, 73}, {56, 73}}, color = {0, 127, 255}));
  connect(MAG_TWW.ports[1], pump_heat_TWW.port_a) annotation(
    Line(points = {{84, 106}, {44, 106}, {44, 94}}, color = {0, 127, 255}));
  connect(TWW.port_b1, temp_TWW.port_b) annotation(
    Line(points = {{-45, 103}, {-60, 103}, {-60, 105}, {-66, 105}}, color = {0, 127, 255}));
  connect(pump_TWW.port_a, temp_TWW.port_a) annotation(
    Line(points = {{-86, 106}, {-76, 106}, {-76, 105}}, color = {0, 127, 255}));
  connect(TWW.heatPort, temp_Kern.port) annotation(
    Line(points = {{-38, 104}, {-38, 118}, {-2, 118}}, color = {191, 0, 0}));
  connect(pump_flow.y, prod_pump.u2) annotation(
    Line(points = {{74, 132}, {70, 132}, {70, 126}, {60, 126}}, color = {0, 0, 127}));
  connect(prod_pump.y, pump_heat_TWW.m_flow_in) annotation(
    Line(points = {{48, 124}, {38, 124}, {38, 104}}, color = {0, 0, 127}));
  connect(btr_TWW.y, prod_pump.u1) annotation(
    Line(points = {{-90, 50}, {134, 50}, {134, 120}, {60, 120}}, color = {0, 0, 127}));
  connect(btr_TWW.y, prod_eheat_TWW.u1) annotation(
    Line(points = {{-90, 50}, {164, 50}, {164, 70}, {152, 70}}, color = {0, 0, 127}));
  connect(prod_eheat_TWW.u2, reg_Eheat.y) annotation(
    Line(points = {{152, 76}, {154, 76}, {154, 98}, {162, 98}}, color = {0, 0, 127}));
  connect(Eheater_TWW.Q_flow, prod_eheat_TWW.y) annotation(
    Line(points = {{106, 60}, {122, 60}, {122, 74}, {140, 74}}, color = {0, 0, 127}));
  connect(TWW.T[3], hyst_TWW.u) annotation(
    Line(points = {{-46, 100}, {-50, 100}, {-50, 66}, {-160, 66}, {-160, 56}, {-154, 56}}, color = {0, 0, 127}));
  connect(add_TWW.u2, TWW_cons_short.y) annotation(
    Line(points = {{-74, 122}, {-58, 122}}, color = {0, 0, 127}));
  connect(TWW_cons.y, add_TWW.u1) annotation(
    Line(points = {{-58.5, 137}, {-70, 137}, {-70, 128}, {-74, 128}}, color = {0, 0, 127}));
  connect(pump_TWW.m_flow_in, add_TWW.y) annotation(
    Line(points = {{-90, 112}, {-92, 112}, {-92, 126}, {-86, 126}}, color = {0, 0, 127}));
  connect(add_TWW.y, greaterEqualThreshold2.u) annotation(
    Line(points = {{-86, 126}, {-90, 126}, {-90, 130}, {-146, 130}}, color = {0, 0, 127}));
  connect(bat.P, batteryControl_Contest.P) annotation(
    Line(points = {{-88, -130}, {-88, -120}, {-64, -120}, {-64, -100}, {-71, -100}}, color = {0, 0, 127}));
  connect(pVSimpleOriented.P, batteryControl_Contest.PV_power) annotation(
    Line(points = {{-54, -118}, {-60, -118}, {-60, -116}, {-104, -116}, {-104, -110.5}, {-95, -110.5}}, color = {0, 0, 127}));
  connect(bat.SOC, batteryControl_Contest.SOC) annotation(
    Line(points = {{-76, -134}, {-68, -134}, {-68, -84}, {-102, -84}, {-102, -97}, {-96, -97}}, color = {0, 0, 127}));
  connect(add_pow.y, batteryControl_Contest.power_cons) annotation(
    Line(points = {{-144, -100}, {-146, -100}, {-146, -108}, {-108, -108}, {-108, -105}, {-95, -105}}, color = {0, 0, 127}));
  connect(Dishwasher.y, var_load.u[1]) annotation(
    Line(points = {{-54, 6}, {-76, 6}, {-76, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(Stove.y, var_load.u[2]) annotation(
    Line(points = {{-54.5, -17}, {-70, -17}, {-70, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(Oven.y, var_load.u[3]) annotation(
    Line(points = {{-54.5, -37}, {-76, -37}, {-76, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(var_load.u[4], Washmachine.y) annotation(
    Line(points = {{-84, -28}, {-78, -28}, {-78, 14}, {-32, 14}, {-32, 8}, {-28, 8}}, color = {0, 0, 127}));
  connect(Lighting.y, var_load.u[5]) annotation(
    Line(points = {{-28, -10}, {-80, -10}, {-80, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(Skylight.y, var_load.u[6]) annotation(
    Line(points = {{-26, -30}, {-84, -30}, {-84, -28}}, color = {0, 0, 127}));
  connect(Blinds.y, var_load.u[7]) annotation(
    Line(points = {{-54.5, -53}, {-78, -53}, {-78, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(add_pow.u3, var_load.y) annotation(
    Line(points = {{-130, -104}, {-120, -104}, {-120, -28}, {-98, -28}}, color = {0, 0, 127}));
  connect(prod_eheat_TWW.y, COP.u) annotation(
    Line(points = {{140, 74}, {130, 74}, {130, 34}, {64, 34}}, color = {0, 0, 127}));
  connect(add_pow.u1, BMS.y) annotation(
    Line(points = {{-130, -96}, {-126, -96}, {-126, -72}, {-136, -72}, {-136, -70}}, color = {0, 0, 127}));
  connect(Refrigerator.y, var_load.u[8]) annotation(
    Line(points = {{-24, -54}, {-30, -54}, {-30, -44}, {-68, -44}, {-68, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(E_c.u1, E_h.y) annotation(
    Line(points = {{136, -20}, {144, -20}, {144, 0}, {156, 0}}, color = {0, 0, 127}));
  connect(E_c.u2, E_s.y) annotation(
    Line(points = {{136, -30}, {144, -30}, {144, -38}, {154, -38}}, color = {0, 0, 127}));
  connect(E_c.y, E_eb.u1) annotation(
    Line(points = {{116, -24}, {108, -24}, {108, 4}, {94, 4}}, color = {0, 0, 127}));
  connect(E_g.y, E_eb.u2) annotation(
    Line(points = {{83, -42}, {74, -42}, {74, -24}, {102, -24}, {102, -8}, {94, -8}}, color = {0, 0, 127}));
  connect(var_load.y, E_h.u) annotation(
    Line(points = {{-98, -28}, {-100, -28}, {-100, 18}, {184, 18}, {184, 0}, {178, 0}}, color = {0, 0, 127}));
  connect(pVSimpleOriented.P, E_g.u) annotation(
    Line(points = {{-54, -118}, {-56, -118}, {-56, -98}, {112, -98}, {112, -42}, {106, -42}}, color = {0, 0, 127}));
  connect(gain_grid.y, lim_grid.u) annotation(
    Line(points = {{59, -60}, {47, -60}}, color = {0, 0, 127}));
  connect(lim_grid.y, E_f.u) annotation(
    Line(points = {{33, -60}, {27.5, -60}, {27.5, -46}, {50, -46}, {50, -28}, {42, -28}}, color = {0, 0, 127}));
  connect(gain_grid.u, realExpression.y) annotation(
    Line(points = {{73, -60}, {84, -60}, {84, -65}, {145, -65}}, color = {0, 0, 127}));
  connect(E_eb_kwh.u, E_eb.y) annotation(
    Line(points = {{63, -2}, {71, -2}}, color = {0, 0, 127}));
  connect(E_c.y, E_c_kwh.u) annotation(
    Line(points = {{116, -24}, {114, -24}, {114, -4}, {134, -4}, {134, 8}, {130, 8}}, color = {0, 0, 127}));
  connect(Others.y, var_load.u[9]) annotation(
    Line(points = {{-92.5, -61}, {-96, -61}, {-96, -42}, {-74, -42}, {-74, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(add_pow.u2, load_syste.y) annotation(
    Line(points = {{-130, -100}, {-124, -100}, {-124, -34}, {-138, -34}}, color = {0, 0, 127}));
  connect(load_syste.y, E_s.u) annotation(
    Line(points = {{-138, -34}, {-114, -34}, {-114, -72}, {186, -72}, {186, -38}, {176, -38}}, color = {0, 0, 127}));
  connect(COP.y, load_syste.u[1]) annotation(
    Line(points = {{50, 34}, {14, 34}, {14, 14}, {-158, 14}, {-158, -34}, {-152, -34}}, color = {0, 0, 127}));
  connect(vent_exhaust.y, load_syste.u[2]) annotation(
    Line(points = {{-168, -14}, {-164, -14}, {-164, -34}, {-152, -34}}, color = {0, 0, 127}));
  connect(vent_facade.y, load_syste.u[3]) annotation(
    Line(points = {{-168, -46}, {-162, -46}, {-162, -34}, {-152, -34}}, color = {0, 0, 127}));
  connect(Mobility.y, var_load.u[10]) annotation(
    Line(points = {{-12.5, -65}, {-70, -65}, {-70, -28}, {-84, -28}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {34, 172}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-62, 26}, {62, -26}}), Rectangle(origin = {1, 83}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{195, -61}, {-195, 61}}), Rectangle(origin = {101, -30}, fillColor = {204, 142, 255}, fillPattern = FillPattern.Solid, extent = {{-93, 50}, {93, -50}}), Rectangle(origin = {-101, -117}, fillColor = {223, 223, 0}, fillPattern = FillPattern.Solid, extent = {{77, -35}, {-77, 35}}), Rectangle(origin = {-99, 172}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-35, 26}, {35, -26}}), Rectangle(origin = {-95, -30}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{99, -50}, {-99, 50}})}, coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 14509700, StopTime = 15114500, Tolerance = 1e-6, Interval = 3600),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end HDU_Contest_Electrical;
