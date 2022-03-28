within RoofKIT.EnergyConcept_HDU.WholeConcept.D6_FinalModels;

model HDU_Electrical
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.CombiTimeTable HDU(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/HDU/Input_HDU.txt", table = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tableName = "HDU", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {167, -39}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL( V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(extent = {{60, -76}, {80, -56}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 220, f = 50) annotation(
    Placement(visible = true, transformation(origin = {60, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 220 / 220, eta = 0.98) annotation(
    Placement(visible = true, transformation(extent = {{34, -36}, {14, -16}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax (displayUnit = "J") = 1.8e+7, SOC_start = 0.9, V_nominal = 220) annotation(
    Placement(visible = true, transformation(extent = {{-28, -40}, {-48, -20}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 16, V_nominal = 400, azi (displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat (displayUnit = "rad") = 0.6579891280018599, til (displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(computeWetBulbTemperature = false, filNam = Modelica.Utilities.Files.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{-164, 72}, {-144, 92}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl batteryControl annotation(
    Placement(visible = true, transformation(origin = {-92, 6}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {102, -42}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
equation
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{14, -26}, {-14, -26}, {-14, -30}, {-28, -30}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{60, -66}, {60, 18}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{34, -26}, {60, -26}, {60, 18}}));
  connect(weaDat.weaBus, pVSimpleOriented.weaBus) annotation(
    Line(points = {{-144, 82}, {10, 82}, {10, 59}}, color = {255, 204, 51}, thickness = 0.5));
  connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{0, 50}, {-10, 50}, {-10, 10}, {12, 10}, {12, -26}, {14, -26}}));
  connect(pVSimpleOriented.P, batteryControl.PV_power) annotation(
    Line(points = {{21, 57}, {29, 57}, {29, 53}, {-119, 53}, {-119, -9}, {-111, -9}}, color = {0, 0, 127}));
  connect(batteryControl.power_cons, HDU.y[9]) annotation(
    Line(points = {{-110, -0.2}, {-144, -0.2}, {-144, -76.2}, {132, -76.2}, {132, -38.2}, {160, -38.2}}, color = {0, 0, 127}));
  connect(bat.SOC, batteryControl.SOC) annotation(
    Line(points = {{-49, -24}, {-125, -24}, {-125, 10}, {-111, 10}}, color = {0, 0, 127}));
  connect(batteryControl.P, bat.P) annotation(
    Line(points = {{-75, 6}, {-39, 6}, {-39, -20}}, color = {0, 0, 127}));
  connect(gain_el.y, RL.Pow) annotation(
    Line(points = {{93.2, -42}, {87.2, -42}, {87.2, -66}, {79.2, -66}}, color = {0, 0, 127}));
  connect(gain_el.u, HDU.y[9]) annotation(
    Line(points = {{111.6, -42}, {159.6, -42}, {159.6, -38}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600),
    Documentation(info = "<html><p>This model calculates the whole electrical energy balance of the House Demonstration Unit for a full year. List of assumptions:</p>
<li>
Electrical energy consumption of appliances was obtained from the BDEW load profiles. 
</li>
<li>
Self-developed battery charging controller. 
</li>
</html>", revisions = "<html>
<ul>
<li>
January 19, 2022 by Nicolas Carbonare:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end HDU_Electrical;
