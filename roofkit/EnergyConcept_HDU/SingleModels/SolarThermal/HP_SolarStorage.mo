within RoofKIT.EnergyConcept_HDU.SingleModels.SolarThermal;

model HP_SolarStorage "Example for a heat pump system with solar heat storage"
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
  package Medium_sin = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Water;
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare package Medium = Medium_sin, Q_flow_nominal = 8000, TAir_nominal = 293.15, TRad_nominal(displayUnit = "K") = 293.15, T_a_nominal(displayUnit = "K") = 308.15, T_b_nominal(displayUnit = "K") = 298.15, T_start = 313.15, dp_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 8000 / 4180 / 5) "Radiator" annotation(
    Placement(transformation(extent = {{-150, 126}, {-170, 106}})));
  Buildings.Fluid.Sources.Boundary_pT watSouRad(redeclare package Medium = Medium_sin, T = 313.15, nPorts = 1) "Source for water for the radiator" annotation(
    Placement(transformation(extent = {{-100, 134}, {-80, 154}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation(
    Placement(visible = true, transformation(extent = {{174, 36}, {194, 56}}, rotation = 0), iconTransformation(extent = {{148, 50}, {168, 70}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT_a1(redeclare final package Medium = Medium_sin, final m_flow_nominal = 1, final transferHeat = true, final allowFlowReversal = true) "Temperature at sink inlet" annotation(
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, origin = {-132, 116})));
  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(A_f = 640, A_opaque = 963, A_win = {30.54, 31.54, 39.46, 31.46}, C_mass = 165000 * 640, Hysterese_Irradiance = 50, U_opaque = 0.2, U_win = 1.3, V_room = 2176, f_WRG = 0.5, latitude(displayUnit = "rad") = 0.015882496193148, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, win_frame = {0.2, 0.2, 0.2, 0.2}) annotation(
    Placement(transformation(extent = {{106, 120}, {126, 140}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation(
    Placement(transformation(extent = {{182, 140}, {162, 160}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation(
    Placement(transformation(extent = {{-50, 132}, {-30, 152}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation(
    Placement(transformation(extent = {{22, 114}, {42, 134}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature storageRoomTemp(T = 288.15) annotation(
    Placement(transformation(extent = {{-172, -8}, {-152, 12}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(redeclare package Medium = Medium_sin, m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation(
    Placement(transformation(extent = {{-92, 126}, {-112, 106}})));
  Buildings.Controls.Continuous.LimPID conPI(Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.2, yMax = 5, yMin = 0) annotation(
    Placement(visible = true, transformation(origin = {-134, 60}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetP(k = 273.15 + 40) annotation(
    Placement(visible = true, transformation(extent = {{-88, 50}, {-108, 70}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT watSouHP(redeclare package Medium = Medium_sin, T = 313.15, nPorts = 1) "Source for warter for source side heat pump" annotation(
    Placement(visible = true, transformation(extent = {{98, 40}, {78, 60}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(redeclare package Medium = Medium_sin, m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation(
    Placement(visible = true, transformation(extent = {{64, 40}, {44, 60}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mflow_souHP(k = 0.4) annotation(
    Placement(visible = true, transformation(origin = {-36, 68}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage storage(redeclare package Medium = Medium_sin, redeclare package Medium_HX_1 = Medium_sin, redeclare package Medium_HX_2 = Medium_sin, height = 1.5, V = 3.1, nEle = 5, HX_1 = false, Ele_HX_2 = 4) annotation(
    Placement(transformation(extent = {{-120, -10}, {-86, 20}})));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package Medium1 = Medium_sin, redeclare package Medium2 = Medium_sou, T1_start = 281.4, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, per = perHP) "Water to Water heat pump" annotation(
    Placement(visible = true, transformation(extent = {{40, -44}, {92, 6}}, rotation = 0)));
  parameter RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW perHP "Reverse heat pump performance data" annotation(
    Placement(visible = true, transformation(extent = {{162, 2}, {182, 22}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerConstant integerMode(k = 1) annotation(
    Placement(visible = true, transformation(extent = {{6, -26}, {20, -12}}, rotation = 0)));
  Buildings.Controls.SetPoints.SupplyReturnTemperatureReset watRes(TOut_nominal(displayUnit = "K") = 265.15, TRet_nominal(displayUnit = "K") = 308.15, TRoo(displayUnit = "K") = 294.15, TRoo_nominal(displayUnit = "K") = 294.15, TSup_nominal(displayUnit = "K") = 313.15, dTOutHeaBal = 6, m = 1.2, use_TRoo_in = false) annotation(
    Placement(visible = true, transformation(extent = {{-32, 2}, {-12, 22}}, rotation = 0)));
  Buildings.Controls.OBC.CDL.Continuous.MovingMean movMea(delta = 3600 * 12) annotation(
    Placement(visible = true, transformation(origin = {12, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort(redeclare final package Medium = Medium_sin, allowFlowReversal = true, m_flow_nominal = 1, transferHeat = true) annotation(
    Placement(visible = true, transformation(origin = {128, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT sou_water(T(displayUnit = "K") = 273.15 + 10, redeclare package Medium = Medium_sou, nPorts = 1) annotation(
    Placement(transformation(extent = {{184, -116}, {164, -96}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Inlet_T(redeclare package Medium = Medium_sou, m_flow_nominal = 0.5) annotation(
    Placement(transformation(extent = {{80, -116}, {60, -96}})));
  Components.Solar.Thermal.ThermalCollector thermalCollector(redeclare package Medium = Medium_sou, A_coll = 60, T_start(displayUnit = "K") = 273.15 + 20, dp_nominal(displayUnit = "Pa") = 50, m_flow_nominal = 0.5, volSol = 1) annotation(
    Placement(visible = true, transformation(origin = {34, -106}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Fluid.FixedResistances.PressureDrop pipeSC(redeclare package Medium = Medium_sou, m_flow_nominal = 0.4, dp_nominal = 50) annotation(
    Placement(visible = true, transformation(origin = {-78, -170}, extent = {{42, 70}, {62, 50}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = Medium_sou, m_flow_nominal = 0.5, addPowerToMedium = false, dp_nominal = 100) annotation(
    Placement(transformation(extent = {{114, -116}, {94, -96}})));
  Modelica.Blocks.Sources.Constant mflow_solCol(k = 0.25) annotation(
    Placement(transformation(extent = {{130, -86}, {114, -70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort solTh_Return_T(redeclare package Medium = Medium_sou, m_flow_nominal = 0.5) annotation(
    Placement(visible = true, transformation(origin = {-124, -226}, extent = {{-92, 136}, {-112, 116}}, rotation = 270)));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val1(redeclare package Medium = Medium_sou, riseTime = 30, m_flow_nominal = 0.5, dpValve_nominal = 50, dpFixed_nominal = {5, 5}) annotation(
    Placement(transformation(extent = {{150, -116}, {130, -96}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal annotation(
    Placement(transformation(extent = {{-36, -158}, {-18, -140}})));
  Buildings.Fluid.Sources.Boundary_pT sink_water(T(displayUnit = "K") = 273.15 + 10, redeclare package Medium = Medium_sou, nPorts = 1) annotation(
    Placement(transformation(extent = {{184, -146}, {164, -126}})));
  Buildings.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val2(redeclare package Medium = Medium_sou, riseTime = 30, m_flow_nominal = 0.5, dpValve_nominal = 50, dpFixed_nominal = {5, 5}) annotation(
    Placement(transformation(extent = {{150, -126}, {130, -146}})));
  Modelica.Blocks.Logical.Hysteresis hysSollCircuit(pre_y_start = true, uLow = 273.15 + 6, uHigh = 273.15 + 10) annotation(
    Placement(transformation(extent = {{-102, -158}, {-84, -140}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis" annotation(
    Placement(transformation(extent = {{9, -9}, {-9, 9}}, origin = {-61, -149}, rotation = 180)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage storage1(
  redeclare package Medium = Medium_sou, 
  redeclare package Medium_HX_1 = Medium_sou, 
  redeclare package Medium_HX_2 = Medium_sou, Ele_HX_1 = 2, HX_1 = true, HX_2 = false, 
  T_start = 273 + 40, V = 3.1, 
  height = 1.5, nEle = 5) annotation(
    Placement(visible = true, transformation(origin = {-73, -97}, extent = {{-17, -15}, {17, 15}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan3(redeclare package Medium = Medium_sou, addPowerToMedium = false, dp_nominal = 50, m_flow_nominal = 0.5) annotation(
    Placement(transformation(extent = {{-46, -74}, {-26, -54}})));
  Modelica.Blocks.Sources.Constant mflow_sinHP(k = 0.4) annotation(
    Placement(transformation(extent = {{-186, -66}, {-174, -54}})));
  Modelica.Blocks.Continuous.Integrator energy_HP(k = 1) annotation(
    Placement(visible = true, transformation(extent = {{130, -42}, {150, -22}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_kWh energy_sim_kWh annotation(
    Placement(visible = true, transformation(extent = {{164, -42}, {184, -22}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 288.15) annotation(
    Placement(visible = true, transformation(origin = {-108, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT boundary_pT(redeclare package Medium = Medium_sou, T(displayUnit = "K") = 273.15 + 25, nPorts = 1, use_T_in = false) annotation(
    Placement(visible = true, transformation(origin = {-142, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(
    Placement(transformation(extent = {{106, 92}, {126, 112}})));
equation
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation(
    Line(points = {{162, 150}, {116, 150}, {116, 140}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation(
    Line(points = {{105.2, 126.8}, {81.6, 126.8}, {81.6, 142}, {-29, 142}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation(
    Line(points = {{105.2, 123.6}, {86, 123.6}, {86, 124}, {43, 124}}, color = {0, 0, 127}));
  connect(weaBus, weaDat1.weaBus) annotation(
    Line(points = {{184, 46}, {184, 96}, {162, 96}, {162, 150}}, color = {255, 204, 51}, thickness = 0.5));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation(
    Line(points = {{-162, 108.8}, {-162, 88}, {88, 88}, {88, 134}, {106, 134}}, color = {191, 0, 0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation(
    Line(points = {{-158, 108.8}, {-158, 92}, {84, 92}, {84, 138}, {106, 138}}, color = {191, 0, 0}));
  connect(senT_a1.port_b, rad.port_a) annotation(
    Line(points = {{-142, 116}, {-150, 116}}, color = {0, 127, 255}));
  connect(fan1.port_b, senT_a1.port_a) annotation(
    Line(points = {{-112, 116}, {-122, 116}}, color = {0, 127, 255}));
  connect(conPI.u_s, TSetP.y) annotation(
    Line(points = {{-122, 60}, {-109, 60}}, color = {0, 0, 127}));
  connect(senT_a1.T, conPI.u_m) annotation(
    Line(points = {{-132, 105}, {-132, 78}, {-134, 78}, {-134, 72}}, color = {0, 0, 127}));
  connect(conPI.y, fan1.m_flow_in) annotation(
    Line(points = {{-145, 60}, {-152, 60}, {-152, 82}, {-102, 82}, {-102, 104}}, color = {0, 0, 127}));
  connect(watSouRad.ports[1], fan1.port_a) annotation(
    Line(points = {{-80, 144}, {-72, 144}, {-72, 116}, {-92, 116}}, color = {0, 127, 255}));
  connect(mflow_souHP.y, fan2.m_flow_in) annotation(
    Line(points = {{-27.2, 68}, {54, 68}, {54, 62}}, color = {0, 0, 127}));
  connect(watSouHP.ports[1], fan2.port_a) annotation(
    Line(points = {{78, 50}, {64, 50}}, color = {0, 127, 255}));
  connect(fan2.port_b, storage.port_a2) annotation(
    Line(points = {{44, 50}, {-58, 50}, {-58, 18}, {-74, 18}, {-74, 18.5}, {-91.1, 18.5}}, color = {0, 127, 255}));
  connect(fan1.port_a, storage.port_HX_2_b) annotation(
    Line(points = {{-92, 116}, {-72, 116}, {-72, 9.5}, {-91.1, 9.5}}, color = {0, 127, 255}));
  connect(rad.port_b, storage.port_HX_2_a) annotation(
    Line(points = {{-170, 116}, {-182, 116}, {-182, 40}, {-84, 40}, {-84, 12.5}, {-91.1, 12.5}}, color = {0, 127, 255}));
  connect(storage.heatPort, storageRoomTemp.port) annotation(
    Line(points = {{-103, 20.6}, {-140, 20.6}, {-140, 2}, {-152, 2}}, color = {191, 0, 0}));
  connect(integerMode.y, heaPum.uMod) annotation(
    Line(points = {{20.7, -19}, {37.4, -19}}, color = {255, 127, 0}));
  connect(storage.port_b2, heaPum.port_a1) annotation(
    Line(points = {{-91.1, -8.5}, {-74, -8.5}, {-74, -4}, {40, -4}}, color = {0, 127, 255}));
  connect(watRes.TOut, weaBus.TDryBul) annotation(
    Line(points = {{-34, 18}, {-48, 18}, {-48, 32}, {184, 32}, {184, 46}}, color = {0, 0, 127}));
  connect(temperatureSensor.port, Gebaeude_modell.port_air) annotation(
    Line(points = {{106, 102}, {98, 102}, {98, 138}, {106, 138}}, color = {191, 0, 0}));
  connect(heaPum.TSet, movMea.y) annotation(
    Line(points = {{36.36, 3.5}, {24, 3.5}, {24, 14}}, color = {0, 0, 127}));
  connect(watRes.TSup, movMea.u) annotation(
    Line(points = {{-11, 18}, {0, 18}, {0, 14}}, color = {0, 0, 127}));
  connect(heaPum.port_b1, temperatureTwoPort.port_a) annotation(
    Line(points = {{92, -4}, {105, -4}, {105, 4}, {118, 4}}, color = {0, 127, 255}));
  connect(temperatureTwoPort.port_b, fan2.port_a) annotation(
    Line(points = {{138, 4}, {148, 4}, {148, 22}, {68, 22}, {68, 48}, {64, 48}, {64, 50}}, color = {0, 127, 255}));
  connect(mflow_solCol.y, fan.m_flow_in) annotation(
    Line(points = {{113.2, -78}, {104, -78}, {104, -94}}, color = {0, 0, 127}));
  connect(solTh_Inlet_T.port_a, fan.port_b) annotation(
    Line(points = {{80, -106}, {94, -106}}, color = {0, 127, 255}));
  connect(pipeSC.port_b, solTh_Return_T.port_b) annotation(
    Line(points = {{-16, -110}, {2, -110}, {2, -114}}, color = {0, 127, 255}));
  connect(val1.port_2, fan.port_a) annotation(
    Line(points = {{130, -106}, {114, -106}}, color = {0, 127, 255}));
  connect(sou_water.ports[1], val1.port_1) annotation(
    Line(points = {{164, -106}, {150, -106}}, color = {0, 127, 255}));
  connect(booleanToReal.y, val1.y) annotation(
    Line(points = {{-17.1, -149}, {192, -149}, {192, -82}, {140, -82}, {140, -94}}, color = {0, 0, 127}));
  connect(val2.port_2, solTh_Return_T.port_a) annotation(
    Line(points = {{130, -136}, {2, -136}, {2, -134}}, color = {0, 127, 255}));
  connect(val2.port_3, val1.port_3) annotation(
    Line(points = {{140, -126}, {140, -116}}, color = {0, 127, 255}));
  connect(val2.port_1, sink_water.ports[1]) annotation(
    Line(points = {{150, -136}, {164, -136}}, color = {0, 127, 255}));
  connect(val2.y, val1.y) annotation(
    Line(points = {{140, -148}, {140, -150}, {192, -150}, {192, -82}, {140, -82}, {140, -94}}, color = {0, 0, 127}));
  connect(solTh_Inlet_T.port_b, thermalCollector.port_a) annotation(
    Line(points = {{60, -106}, {44, -106}, {44, -106}}, color = {0, 127, 255}));
  connect(hysSollCircuit.u, solTh_Return_T.T) annotation(
    Line(points = {{-103.8, -149}, {-110, -149}, {-110, -124}, {-9, -124}}, color = {0, 0, 127}));
  connect(thermalCollector.WeaBusWeaPar, weaBus) annotation(
    Line(points = {{40.4, -96}, {42, -96}, {42, -80}, {76, -80}, {76, -62}, {190, -62}, {190, 46}, {184, 46}}, color = {255, 204, 51}, thickness = 0.5),
    Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}, horizontalAlignment = TextAlignment.Left));
  connect(mflow_sinHP.y, fan3.m_flow_in) annotation(
    Line(points = {{-173.4, -60}, {-160, -60}, {-160, -52}, {-36, -52}}, color = {0, 0, 127}));
  connect(hysSollCircuit.y, not2.u) annotation(
    Line(points = {{-83.1, -149}, {-76.55, -149}, {-76.55, -149}, {-71.8, -149}}, color = {255, 0, 255}));
  connect(booleanToReal.u, not2.y) annotation(
    Line(points = {{-37.8, -149}, {-51.1, -149}}, color = {255, 0, 255}));
  connect(fan3.port_b, heaPum.port_a2) annotation(
    Line(points = {{-26, -64}, {42, -64}, {42, -52}, {110, -52}, {110, -34}, {92, -34}}, color = {0, 127, 255}));
  connect(energy_sim_kWh.u, energy_HP.u) annotation(
    Line(points = {{162, -32}, {128, -32}}, color = {0, 0, 127}));
  connect(energy_HP.u, heaPum.P) annotation(
    Line(points = {{128, -32}, {120, -32}, {120, -20}, {94, -20}}, color = {0, 0, 127}));
  connect(storage1.heatPort, fixedTemperature.port) annotation(
    Line(points = {{-73, -81}, {-98, -81}, {-98, -80}}, color = {191, 0, 0}));
  connect(fan3.port_a, boundary_pT.ports[1]) annotation(
    Line(points = {{-46, -64}, {-132, -64}, {-132, -82}}, color = {0, 127, 255}));
  connect(storage1.port_a2, fan3.port_a) annotation(
    Line(points = {{-61, -83.5}, {-54, -83.5}, {-54, -64}, {-46, -64}}, color = {0, 127, 255}));
  connect(heaPum.port_b2, storage1.port_b2) annotation(
    Line(points = {{40, -34}, {20, -34}, {20, -42}, {-50, -42}, {-50, -110}, {-52, -110}, {-52, -110.5}, {-61, -110.5}}, color = {0, 127, 255}));
  connect(thermalCollector.port_b, storage1.port_HX_1_b) annotation(
    Line(points = {{24, -106}, {-62, -106}}, color = {0, 127, 255}));
  connect(pipeSC.port_a, storage1.port_HX_1_a) annotation(
    Line(points = {{-36, -110}, {-46, -110}, {-46, -102}, {-62, -102}}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -170}, {200, 170}}), graphics = {Rectangle(origin = {67, 127}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-127, 41}, {127, -41}}), Text(origin = {33, 156}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin = {68, 19}, fillColor = {255, 147, 147}, fillPattern = FillPattern.Solid, extent = {{128, -65}, {-128, 65}}), Text(origin = {141, 74}, extent = {{-39, 34}, {39, -34}}, textString = "Wärmepumpe
      "), Rectangle(origin = {-129, -7}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{65, -39}, {-65, 39}}), Text(origin = {-152, -31}, extent = {{-36, 15}, {36, -15}}, textString = "Wärmespeicher
Heizung"), Rectangle(origin = {-129, 102}, fillColor = {255, 213, 170}, fillPattern = FillPattern.Solid, extent = {{65, -66}, {-65, 66}}), Text(origin = {-154, 147}, extent = {{-36, 15}, {36, -15}}, textString = "Heizkörper
Vorlauftemp 40°C"), Rectangle(origin = {1, -106}, fillColor = {213, 255, 170}, fillPattern = FillPattern.Solid, extent = {{195, -58}, {-195, 58}}), Text(origin = {-144, -118}, extent = {{-46, 36}, {46, -36}}, textString = "Solarkollektoren 60 m²
Wärmespeicher")}),
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
    Icon(coordinateSystem(extent = {{-200, -170}, {200, 170}}, preserveAspectRatio = false), graphics = {Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-120, -120}, {120, 120}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-38, 64}, {68, -2}, {-38, -64}, {-38, 64}})}));
end HP_SolarStorage;
