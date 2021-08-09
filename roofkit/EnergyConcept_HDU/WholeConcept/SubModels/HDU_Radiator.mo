within RoofKIT.EnergyConcept_HDU.WholeConcept.SubModels;

model HDU_Radiator
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
    package Medium_loa = Buildings.Media.Water;
    package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.3, property_T = 283.15);
    package Medium_heat = Buildings.Media.Water;
  parameter Modelica.SIunits.MassFlowRate mSou_flow_nominal = per.hea.mSou_flow "Source heat exchanger nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mLoa_flow_nominal = per.hea.mLoa_flow "Load heat exchanger nominal mass flow rate";
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
    Placement(visible = true, transformation(extent = {{-204, 104}, {-184, 124}}, rotation = 0), iconTransformation(extent = {{148, 50}, {168, 70}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{136, 124}, {116, 144}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 125.5) annotation(
    Placement(visible = true, transformation(origin = {22, 104}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 0, nperiod = 1, offset = 5 * Gebaeude_modell.A_f, period = 86400, width = 100) annotation(
    Placement(visible = true, transformation(origin = {4, 90}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW per annotation(
    Placement(visible = true, transformation(origin = {1, -33}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  //DIN ISO 13790
  RoofKIT.Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(A_f = 56.4, A_opaque = 81.3, A_win = {15.12, 0, 5.84, 5.84}, C_mass = 25000000, Hysterese_Irradiance = 10, Irr_shading = 150, U_opaque = 0.12, U_win = 1.0, V_room = 251, f_WRG = 0.8, g_factor = {0.5, 0.5, 0.5, 0.5}, latitude(displayUnit = "rad") = 0.015882496193148, surfaceAzimut = {207 / 180 * pi, 297 / 180 * pi, 27 / 180 * pi, 117 / 180 * pi}, win_frame = {0.3, 0.3, 0.3, 0.3}) annotation(
    Placement(visible = true, transformation(origin = {81, 105}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_sou(redeclare package Medium = Medium_sou, nPorts = 1, use_T_in = true) annotation(
    Placement(visible = true, transformation(origin = {-58, -30}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_loa, redeclare package Medium2 = Medium_sou, T1_start = 293.15, T2_start = 283.15, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = per) annotation(
    Placement(visible = true, transformation(origin = {2, -17}, extent = {{-14, -11}, {14, 11}}, rotation = 0)));
  Buildings.Controls.SetPoints.SupplyReturnTemperatureReset watRes(TOut_nominal = (-12) + 273.15, TRet_nominal = 30 + 273.15, TSup_nominal = 40 + 273.15, m = 1.2) annotation(
    Placement(visible = true, transformation(origin = {-171, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.MovingMean movMea(delta = 3600 * 6) annotation(
    Placement(visible = true, transformation(origin = {-153, -7}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uHigh = 22 + 273.15, uLow = 20 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-159, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1 annotation(
    Placement(visible = true, transformation(origin = {-137, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToInteger booleanToInteger annotation(
    Placement(visible = true, transformation(origin = {-81, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mflow_heat(k = 0.3) annotation(
    Placement(visible = true, transformation(origin = {-115, 91}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(visible = true, transformation(origin = {-117, 69}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-90, 72}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_sou(redeclare replaceable package Medium = Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mSou_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-32, -30}, extent = {{8, 8}, {-8, -8}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_loa(redeclare replaceable package Medium = Medium_loa, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {81, -10}, extent = {{-7, 8}, {7, -8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_loa(redeclare package Medium = Medium_loa, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {36, 2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage storage(redeclare package Medium = Medium_loa, redeclare package Medium_HX_1 = Medium_loa, redeclare package Medium_HX_2 = Medium_loa, Ele_HX_2 = 4, HX_1 = false, HX_2 = true, V = 0.2, height = 1.5, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-47, 38}, extent = {{-15, -16}, {15, 16}}, rotation = 0)));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare package Medium = Medium_loa, Q_flow_nominal = 8000, TAir_nominal = 293.15, TRad_nominal(displayUnit = "K") = 293.15, T_a_nominal(displayUnit = "K") = 308.15, T_b_nominal(displayUnit = "K") = 298.15, T_start = 313.15, dp_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 0.2) "Radiator" annotation(
    Placement(visible = true, transformation(extent = {{70, 40}, {50, 60}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pump_heat(redeclare replaceable package Medium = Medium_heat, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = mLoa_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {33, 50}, extent = {{7, -8}, {-7, 8}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT bou_heat(redeclare package Medium = Medium_heat, nPorts = 1) annotation(
    Placement(visible = true, transformation(origin = {52, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(visible = true, transformation(origin = {-178, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-109, -53}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.IntegerToReal integerToReal annotation(
    Placement(visible = true, transformation(origin = {-109, -37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-86, -54}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uHigh = 2, uLow = 0) annotation(
    Placement(visible = true, transformation(origin = {-111, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {-125, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-95, -17}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Greater greater annotation(
    Placement(visible = true, transformation(origin = {-155, -29}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-187, -45}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  RoofKIT.Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 60, T_start = 10 + 273.15, capColl = 0, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.3, volSol = 2) annotation(
    Placement(visible = true, transformation(origin = {12, -94}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = mLoa_flow_nominal) annotation(
    Placement(visible = true, transformation(origin = {-141, -83}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {-87, -91}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const3(k = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-141, -103}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation
//Connections
  connect(weaDat1.weaBus, weaBus) annotation(
    Line(points = {{116, 134}, {-194, 134}, {-194, 114}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation(
    Line(points = {{116, 134}, {81, 134}, {81, 120}}, color = {255, 204, 51}, thickness = 0.5));
  connect(hysteresis.y, not1.u) annotation(
    Line(points = {{-153.5, 69}, {-143, 69}}, color = {255, 0, 255}));
  connect(heaPum.port_b1, pump_loa.port_a) annotation(
    Line(points = {{16, -10.4}, {46, -10.4}, {46, -10}, {74, -10}}, color = {0, 127, 255}));
  connect(not1.y, booleanToReal.u) annotation(
    Line(points = {{-131.5, 69}, {-123, 69}}, color = {255, 0, 255}));
  connect(booleanToReal.y, product.u2) annotation(
    Line(points = {{-111.5, 69}, {-111.5, 68.4}, {-97.2, 68.4}}, color = {0, 0, 127}));
  connect(booleanToInteger.y, heaPum.uMod) annotation(
    Line(points = {{-75.5, -17}, {-13.4, -17}}, color = {255, 127, 0}));
  connect(pump_sou.port_b, bou_sou.ports[1]) annotation(
    Line(points = {{-40, -30}, {-52, -30}}, color = {0, 127, 255}));
  connect(rad.port_b, pump_heat.port_a) annotation(
    Line(points = {{50, 50}, {40, 50}}, color = {0, 127, 255}));
  connect(temperatureSensor.T, hysteresis.u) annotation(
    Line(points = {{-172, 68}, {-165, 68}, {-165, 69}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.port_air, temperatureSensor.port) annotation(
    Line(points = {{66, 117}, {-184, 117}, {-184, 68}}, color = {191, 0, 0}));
  connect(movMea.y, heaPum.TSet) annotation(
    Line(points = {{-147, -7}, {-80, -7}, {-80, -7.1}, {-13.96, -7.1}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, watRes.TOut) annotation(
    Line(points = {{-194, 114}, {-194, -4}, {-177, -4}}, color = {0, 0, 127}));
  connect(integerToReal.y, product1.u1) annotation(
    Line(points = {{-103.5, -37}, {-98, -37}, {-98, -50.4}, {-93.2, -50.4}}, color = {0, 0, 127}));
  connect(pump_loa.m_flow_in, product1.y) annotation(
    Line(points = {{81, -19.6}, {81, -54}, {-79.4, -54}}, color = {0, 0, 127}));
  connect(watRes.TSup, movMea.u) annotation(
    Line(points = {{-165.5, -4}, {-161.5, -4}, {-161.5, -7}, {-159, -7}}, color = {0, 0, 127}));
  connect(add.y, hysteresis1.u) annotation(
    Line(points = {{-119.5, -17}, {-117, -17}}, color = {0, 0, 127}));
  connect(movMea.y, add.u2) annotation(
    Line(points = {{-147, -7}, {-140, -7}, {-140, -20}, {-131, -20}}, color = {0, 0, 127}));
  connect(storage.T[4], add.u1) annotation(
    Line(points = {{-58.1, 48.24}, {-136.1, 48.24}, {-136.1, -14}, {-131, -14}}, color = {0, 0, 127}));
  connect(pump_heat.port_b, storage.port_HX_2_a) annotation(
    Line(points = {{26, 50}, {-5.25, 50}, {-5.25, 46}, {-36.5, 46}}, color = {0, 127, 255}));
  connect(mflow_heat.y, product.u1) annotation(
    Line(points = {{-109.5, 91}, {-101.5, 91}, {-101.5, 75.6}, {-97.2, 75.6}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation(
    Line(points = {{64.8, 100.2}, {45.8, 100.2}, {45.8, 104}, {28.6, 104}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation(
    Line(points = {{64.8, 95.4}, {45.8, 95.4}, {45.8, 90}, {10.6, 90}}, color = {0, 0, 127}));
  connect(product.y, pump_heat.m_flow_in) annotation(
    Line(points = {{-83.4, 72}, {33, 72}, {33, 59.6}}, color = {0, 0, 127}));
  connect(rad.port_a, storage.port_HX_2_b) annotation(
    Line(points = {{70, 50}, {70, 32}, {-20, 32}, {-20, 42.8}, {-36.5, 42.8}}, color = {0, 127, 255}));
  connect(bou_heat.ports[1], rad.port_a) annotation(
    Line(points = {{58, 22}, {70, 22}, {70, 50}}, color = {0, 127, 255}));
  connect(storage.port_b2, heaPum.port_a1) annotation(
    Line(points = {{-36.5, 23.6}, {-32, 23.6}, {-32, -10.4}, {-12, -10.4}}, color = {0, 127, 255}));
  connect(bou_loa.ports[1], pump_loa.port_a) annotation(
    Line(points = {{42, 2}, {58, 2}, {58, -10}, {74, -10}}, color = {0, 127, 255}));
  connect(pump_loa.port_b, storage.port_a2) annotation(
    Line(points = {{88, -10}, {94, -10}, {94, 64}, {-32, 64}, {-32, 52.4}, {-36.5, 52.4}}, color = {0, 127, 255}));
  connect(heaPum.port_b2, pump_sou.port_a) annotation(
    Line(points = {{-12, -23.6}, {-20, -23.6}, {-20, -30}, {-24, -30}}, color = {0, 127, 255}));
  connect(const.y, product1.u2) annotation(
    Line(points = {{-103.5, -53}, {-102, -53}, {-102, -57.6}, {-93.2, -57.6}}, color = {0, 0, 127}));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation(
    Line(points = {{58, 57.2}, {58, 111}, {66, 111}}, color = {191, 0, 0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation(
    Line(points = {{62, 57.2}, {62, 117}, {66, 117}}, color = {191, 0, 0}));
  connect(Gebaeude_modell.port_air, storage.heatPort) annotation(
    Line(points = {{66, 117}, {-47, 117}, {-47, 54.64}}, color = {191, 0, 0}));
  connect(hysteresis1.y, and1.u1) annotation(
    Line(points = {{-105.5, -17}, {-101, -17}}, color = {255, 0, 255}));
  connect(and1.y, booleanToInteger.u) annotation(
    Line(points = {{-89.5, -17}, {-87, -17}, {-87, -17}}, color = {255, 0, 255}));
  connect(greater.y, and1.u2) annotation(
    Line(points = {{-149.5, -29}, {-104, -29}, {-104, -21}, {-101, -21}}, color = {255, 0, 255}));
  connect(const1.y, greater.u2) annotation(
    Line(points = {{-181.5, -45}, {-173.5, -45}, {-173.5, -33}, {-161, -33}}, color = {0, 0, 127}));
  connect(booleanToInteger.y, integerToReal.u) annotation(
    Line(points = {{-75.5, -17}, {-73.5, -17}, {-73.5, -27}, {-127.5, -27}, {-127.5, -37}, {-115, -37}}, color = {255, 127, 0}));
  connect(weaDat1.weaBus, thermalCollector.WeaBusWeaPar) annotation(
    Line(points = {{116, 134}, {106, 134}, {106, -120}, {5.6, -120}, {5.6, -104}}, color = {255, 204, 51}, thickness = 0.5));
  connect(heaPum.port_a2, thermalCollector.port_b) annotation(
    Line(points = {{16, -23.6}, {42, -23.6}, {42, -94}, {22, -94}}, color = {0, 127, 255}));
  connect(pump_sou.port_b, thermalCollector.port_a) annotation(
    Line(points = {{-40, -30}, {-46, -30}, {-46, -94}, {2, -94}}, color = {0, 127, 255}));
  connect(weaBus.HDifHor, greater.u1) annotation(
    Line(points = {{-194, 114}, {-194, -29}, {-161, -29}}, color = {0, 0, 127}));
  connect(weaBus.TDryBul, bou_sou.T_in) annotation(
    Line(points = {{-194, 114}, {-194, -27.6}, {-65.2, -27.6}}, color = {0, 0, 127}));
  connect(pump_sou.m_flow_in, switch1.y) annotation(
    Line(points = {{-32, -39.6}, {-32, -91}, {-79.3, -91}}, color = {0, 0, 127}));
  connect(and1.y, switch1.u2) annotation(
    Line(points = {{-89.5, -17}, {-88, -17}, {-88, -72}, {-124, -72}, {-124, -91}, {-95.4, -91}}, color = {255, 0, 255}));
  connect(const2.y, switch1.u1) annotation(
    Line(points = {{-135.5, -83}, {-110, -83}, {-110, -85.4}, {-95.4, -85.4}}, color = {0, 0, 127}));
  connect(const3.y, switch1.u3) annotation(
    Line(points = {{-135.5, -103}, {-110, -103}, {-110, -96.6}, {-95.4, -96.6}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {15, 103}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-85, 23}, {85, -23}}), Rectangle(origin = {45, 46}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{55, -32}, {-55, 32}}), Rectangle(origin = {-41, 46}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{29, -32}, {-29, 32}}), Rectangle(origin = {45, 46}, fillColor = {255, 121, 161}, fillPattern = FillPattern.Solid, extent = {{55, -32}, {-55, 32}}), Rectangle(origin = {15, -30}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{85, -42}, {-85, 42}}), Rectangle(origin = {-138, -5}, fillColor = {181, 181, 181}, fillPattern = FillPattern.Solid, extent = {{-66, 131}, {66, -131}}), Rectangle(origin = {15, -105}, fillColor = {62, 186, 91}, fillPattern = FillPattern.Solid, extent = {{85, -31}, {-85, 31}})}));
end HDU_Radiator;
