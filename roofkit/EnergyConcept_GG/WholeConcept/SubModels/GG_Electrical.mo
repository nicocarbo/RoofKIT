within RoofKIT.EnergyConcept_GG.WholeConcept.SubModels;

model GG_Electrical
  Modelica.Blocks.Sources.CombiTimeTable HDU(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/HDU/HDU_input.txt", table = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], tableName = "HDU", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {87, -21}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(extent = {{-20, -58}, {0, -38}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 220, f = 50) annotation(
    Placement(visible = true, transformation(origin = {-20, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 220 / 220, eta = 0.98) annotation(
    Placement(visible = true, transformation(extent = {{-46, -18}, {-66, 2}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 1.8e+7, SOC_start = 0.9, V_nominal = 220) annotation(
    Placement(visible = true, transformation(extent = {{-108, -22}, {-128, -2}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented pVSimpleOriented(A = 16, V_nominal = 400, azi(displayUnit = "rad") = -0.7853981633974501, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {-70, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(computeWetBulbTemperature = false, filNam = Modelica.Utilities.Files.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(extent = {{-244, 90}, {-224, 110}}, rotation = 0)));
  Components.Controls.BatteryControl batteryControl annotation(
    Placement(visible = true, transformation(origin = {-172, 24}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {22, -24}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
equation
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{-66, -8}, {-94, -8}, {-94, -12}, {-108, -12}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{-20, -48}, {-20, 36}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{-46, -8}, {-20, -8}, {-20, 36}}));
  connect(weaDat.weaBus, pVSimpleOriented.weaBus) annotation(
    Line(points = {{-224, 100}, {-70, 100}, {-70, 77}}, color = {255, 204, 51}, thickness = 0.5));
  connect(pVSimpleOriented.terminal, conv.terminal_p) annotation(
    Line(points = {{-80, 68}, {-90, 68}, {-90, 28}, {-68, 28}, {-68, -8}, {-66, -8}}));
  connect(pVSimpleOriented.P, batteryControl.PV_power) annotation(
    Line(points = {{-58, 76}, {-50, 76}, {-50, 72}, {-198, 72}, {-198, 10}, {-190, 10}}, color = {0, 0, 127}));
  connect(batteryControl.power_cons, HDU.y[9]) annotation(
    Line(points = {{-190, 18}, {-224, 18}, {-224, -58}, {52, -58}, {52, -20}, {80, -20}}, color = {0, 0, 127}));
  connect(bat.SOC, batteryControl.SOC) annotation(
    Line(points = {{-128, -6}, {-204, -6}, {-204, 28}, {-190, 28}}, color = {0, 0, 127}));
  connect(batteryControl.P, bat.P) annotation(
    Line(points = {{-154, 24}, {-118, 24}, {-118, -2}}, color = {0, 0, 127}));
  connect(gain_el.y, RL.Pow) annotation(
    Line(points = {{14, -24}, {8, -24}, {8, -48}, {0, -48}}, color = {0, 0, 127}));
  connect(gain_el.u, HDU.y[9]) annotation(
    Line(points = {{32, -24}, {80, -24}, {80, -20}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-400, -300}, {400, 300}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 3600),
    Icon(coordinateSystem(extent = {{-400, -300}, {400, 300}})));
end GG_Electrical;
