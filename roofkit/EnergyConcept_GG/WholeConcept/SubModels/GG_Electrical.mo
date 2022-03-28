within RoofKIT.EnergyConcept_GG.WholeConcept.SubModels;

model GG_Electrical
  extends Modelica.Icons.Example;
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(extent = {{68, -64}, {88, -44}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 220, f = 50) annotation(
    Placement(visible = true, transformation(origin = {68, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 220 / 220, eta = 0.98) annotation(
    Placement(visible = true, transformation(extent = {{42, -24}, {22, -4}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 360000000, SOC_start = 0.5, V_nominal = 220) annotation(
    Placement(visible = true, transformation(extent = {{-22, -28}, {-42, -8}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 1.62 * 200, V_nominal = 400, azi(displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {-12, 52}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(computeWetBulbTemperature = false, filNam = Modelica.Utilities.Files.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{-108, 90}, {-88, 110}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl batteryControl annotation(
    Placement(visible = true, transformation(origin = {-84, 18}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {110, -30}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable ThirdFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/ThirdFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "ThirdFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {171, -61}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable FirstFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/FirstFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "FirstFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {171, -17}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable SecondFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/SecondFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "SecondFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {171, -39}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add_pow annotation(
    Placement(visible = true, transformation(origin = {142, -40}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
equation
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{22, -14}, {-6, -14}, {-6, -18}, {-22, -18}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{68, -54}, {68, 30}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{42, -14}, {68, -14}, {68, 30}}));
  connect(weaDat.weaBus, pVSimpleOriented.weaBus) annotation(
    Line(points = {{-88, 100}, {-12, 100}, {-12, 61}}, color = {255, 204, 51}, thickness = 0.5));
  connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{-2, 52}, {40, 52}, {40, 22}, {20, 22}, {20, -14}, {22, -14}}));
  connect(pVSimpleOriented.P, batteryControl.PV_power) annotation(
    Line(points = {{-23, 59}, {-111, 59}, {-111, 3}, {-103, 3}}, color = {0, 0, 127}));
  connect(bat.SOC, batteryControl.SOC) annotation(
    Line(points = {{-43, -12}, {-117, -12}, {-117, 22}, {-103, 22}}, color = {0, 0, 127}));
  connect(batteryControl.P, bat.P) annotation(
    Line(points = {{-67, 18}, {-32, 18}, {-32, -8}}, color = {0, 0, 127}));
  connect(gain_el.y, RL.Pow) annotation(
    Line(points = {{101.2, -30}, {95.2, -30}, {95.2, -54}, {87.2, -54}}, color = {0, 0, 127}));
  connect(FirstFloor.y[4], add_pow.u1) annotation(
    Line(points = {{163.3, -17}, {155.3, -17}, {155.3, -37}, {149.3, -37}}, color = {0, 0, 127}));
  connect(add_pow.u2, SecondFloor.y[4]) annotation(
    Line(points = {{149.2, -40}, {155.2, -40}, {155.2, -38}, {163.2, -38}}, color = {0, 0, 127}));
  connect(add_pow.u3, ThirdFloor.y[4]) annotation(
    Line(points = {{149.2, -44.8}, {153.2, -44.8}, {153.2, -60.8}, {163.2, -60.8}}, color = {0, 0, 127}));
  connect(gain_el.u, add_pow.y) annotation(
    Line(points = {{120, -30}, {124, -30}, {124, -40}, {136, -40}}, color = {0, 0, 127}));
  connect(batteryControl.power_cons, add_pow.y) annotation(
    Line(points = {{-102, 12}, {-134, 12}, {-134, -74}, {132, -74}, {132, -40}, {136, -40}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600),
    Documentation(info = "<html><p>This model calculates the whole electrical energy balance of the design challenge for a full year. List of assumptions:</p>
<li>
Electrical energy consumption of appliances was obtained from the BDEW load profiles. 
</li>
<li>
Self-developed battery charging controller. 
</li>
</html>", revisions = "<html>
<ul>
<li>
March 19, 2022 by Nicolas Carbonare:<br/>
Completed data. Working model.
</li>
<li>
March 09, 2022 by Nicolas Carbonare:<br/>
First implementation. Added documentation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end GG_Electrical;
