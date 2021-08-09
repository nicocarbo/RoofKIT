within RoofKIT.EnergyConcept_HDU.SingleModels.BuildingModel;

model Zone_ISO13790_ausgefuellt
  extends Modelica.Icons.Example;
  import Modelica.Constants.*;
  RoofKIT.Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(f_WRG = 0.5, U_win = 1.3, U_opaque = 0.2, A_win = {30.54, 31.54, 39.46, 31.46}, A_opaque = 963, A_f = 640, V_room = 2176, win_frame = {0.2, 0.2, 0.2, 0.2}, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, Hysterese_Irradiance = 50, C_mass = 165000 * 640, latitude = 0.015882496193148) annotation(
    Placement(transformation(extent = {{60, -28}, {80, -8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
    Placement(transformation(extent = {{20, -20}, {40, 0}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor roomTemperature annotation(
    Placement(transformation(extent = {{60, -96}, {40, -76}})));
  Modelica.Blocks.Continuous.LimPID PID(k = 1, yMax = 999999, yMin = 0, controllerType = Modelica.Blocks.Types.SimpleController.PI) annotation(
    Placement(transformation(extent = {{-60, -20}, {-40, 0}})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 22.0) annotation(
    Placement(transformation(extent = {{-100, -20}, {-80, 0}})));
  Modelica.Blocks.Continuous.Integrator energy_sim(k = 1 / 3600000 / 1000) annotation(
    Placement(transformation(extent = {{20, 20}, {40, 40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation(
    Placement(transformation(extent = {{100, 80}, {80, 100}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 10) annotation(
    Placement(transformation(extent = {{-20, -20}, {0, 0}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation(
    Placement(transformation(extent = {{14, -40}, {34, -20}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation(
    Placement(transformation(extent = {{2, -70}, {22, -50}})));
equation
  connect(prescribedHeatFlow.port, Gebaeude_modell.port_air) annotation(
    Line(points = {{40, -10}, {60, -10}}, color = {191, 0, 0}));
  connect(roomTemperature.port, Gebaeude_modell.port_surf) annotation(
    Line(points = {{60, -86}, {60, -14}}, color = {191, 0, 0}));
  connect(const.y, PID.u_s) annotation(
    Line(points = {{-79, -10}, {-62, -10}}, color = {0, 0, 127}));
  connect(roomTemperature.T, PID.u_m) annotation(
    Line(points = {{40, -86}, {-50, -86}, {-50, -22}}, color = {0, 0, 127}));
  connect(weaDat.weaBus, Gebaeude_modell.weaBus) annotation(
    Line(points = {{80, 90}, {70, 90}, {70, -8}}, color = {255, 204, 51}, thickness = 0.5));
  connect(PID.y, firstOrder.u) annotation(
    Line(points = {{-39, -10}, {-22, -10}}, color = {0, 0, 127}));
  connect(firstOrder.y, prescribedHeatFlow.Q_flow) annotation(
    Line(points = {{1, -10}, {20, -10}}, color = {0, 0, 127}));
  connect(firstOrder.y, energy_sim.u) annotation(
    Line(points = {{1, -10}, {10, -10}, {10, 30}, {18, 30}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation(
    Line(points = {{59.2, -21.2}, {47.6, -21.2}, {47.6, -30}, {35, -30}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation(
    Line(points = {{59.2, -24.4}, {52, -24.4}, {52, -60}, {23, -60}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StopTime = 31536000, __Dymola_NumberOfIntervals = 8760),
    __Dymola_experimentSetupOutput(textual = true, events = false));
end Zone_ISO13790_ausgefuellt;
