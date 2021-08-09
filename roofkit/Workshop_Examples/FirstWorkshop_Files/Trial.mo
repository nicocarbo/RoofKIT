within RoofKIT.Workshop_Examples.FirstWorkshop_Files;
model Trial
  "Illustrates the use of a thermal zone with one heat conduction element"
  extends Modelica.Icons.Example;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(calTSky = Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation, computeWetBulbTemperature = false, filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")) "Weather data reader" annotation (
    Placement(visible = true, transformation(extent = {{-150, 152}, {-130, 172}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil[2](each outSkyCon = true, each outGroCon = true, each til = 1.5707963267949, each lat = 0.87266462599716, azi = {3.1415926535898, 4.7123889803847}) "Calculates diffuse solar radiation on titled surface for both directions" annotation (
    Placement(visible = true, transformation(extent = {{-120, 120}, {-100, 140}}, rotation = 0)));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil[2](each til = 1.5707963267949, each lat = 0.87266462599716, azi = {3.1415926535898, 4.7123889803847}) "Calculates direct solar radiation on titled surface for both directions" annotation (
    Placement(visible = true, transformation(extent = {{-120, 152}, {-100, 172}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane corGDouPan(n = 2, UWin = 2.1) "Correction factor for solar transmission" annotation (
    Placement(visible = true, transformation(extent = {{-46, 154}, {-26, 174}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.RC.OneElement thermalZoneOneElement(redeclare
      package Medium =
        Modelica.Media.Air.SimpleAir,                                                                                              AExt = {9, 17}, ATransparent = {14, 14}, AWin = {14, 14}, CExt = {5259932.23}, RExt = {0.00201421908725}, RExtRem = 0.0665217391, RWin = 0.00842857143, T_start = 295.15, VAir = 105, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, extWallRC(thermCapExt(each der_T(fixed = true))), gWin = 0.7, hConExt = 3.9, hConWin = 3.9, hRad = 6, nExt = 1, nOrientations = 2, ratioWinConRad = 0.09, nPorts = 0) "Thermal zone" annotation (
    Placement(visible = true, transformation(extent = {{-8, 98}, {40, 134}}, rotation = 0)));
  Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow eqAirTemp(n = 2, wfGro = 0, wfWall = {0.3043478260869566, 0.6956521739130435}, wfWin = {0.5, 0.5}, withLongwave = true, aExt = 0.7, hConWallOut = 20, hRad = 6, hConWinOut = 20, TGro = 285.15) "Computes equivalent air temperature" annotation (
    Placement(visible = true, transformation(extent = {{-76, 86}, {-56, 106}}, rotation = 0)));
  Modelica.Blocks.Math.Add solRad[2] "Sums up solar radiation of both directions" annotation (
    Placement(visible = true, transformation(extent = {{-90, 106}, {-80, 116}}, rotation = 0)));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem "Prescribed temperature for exterior walls outdoor surface temperature" annotation (
    Placement(visible = true, transformation(extent = {{-44, 94}, {-32, 106}}, rotation = 0)));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem1 "Prescribed temperature for windows outdoor surface temperature" annotation (
    Placement(visible = true, transformation(extent = {{-44, 114}, {-32, 126}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin "Outdoor convective heat transfer of windows" annotation (
    Placement(visible = true, transformation(extent = {{-14, 116}, {-24, 126}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall "Outdoor convective heat transfer of walls" annotation (
    Placement(visible = true, transformation(extent = {{-16, 106}, {-26, 96}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad "Radiative heat flow of persons" annotation (
    Placement(visible = true, transformation(origin = {72, 158}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon "Convective heat flow of persons" annotation (
    Placement(visible = true, transformation(origin = {72, 140}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable intGai( columns = {2, 3, 4}, extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic,table = [0, 0, 0, 0; 3600, 0, 0, 0; 7200, 0, 0, 0; 10800, 0, 0, 0; 14400, 0, 0, 0; 18000, 0, 0, 0; 21600, 0, 0, 0; 25200, 0, 0, 0; 25200, 40, 40, 100; 28800, 40, 40, 100; 32400, 40, 40, 100; 36000, 40, 40, 100; 39600, 40, 40, 100; 43200, 40, 40, 100; 46800, 40, 40, 100; 50400, 40, 40, 100; 54000, 40, 40, 100; 57600, 40, 40, 100; 61200, 0, 0, 0; 61200, 0, 0, 0; 64800, 0, 0, 0; 72000, 0, 0, 0; 75600, 0, 0, 0; 79200, 0, 0, 0; 82800, 0, 0, 0; 86400, 0, 0, 0]) "Table with profiles for persons (radiative and convective) and machines
      (convective)" annotation (
    Placement(visible = true, transformation(origin = {108, 158}, extent = {{8, -8}, {-8, 8}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const[2](each k = 0) "Sets sunblind signal to zero (open)" annotation (
    Placement(visible = true, transformation(extent = {{-72, 114}, {-66, 120}}, rotation = 0)));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (
    Placement(visible = true,transformation(extent = {{-152, 90}, {-118, 122}}, rotation = 0), iconTransformation(extent = {{-70, -12}, {-50, 8}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv "Convective heat flow of machines" annotation (
    Placement(visible = true, transformation(origin = {72, 120}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant hConWall(k = 25 * 11.5) "Outdoor coefficient of heat transfer for walls" annotation (
    Placement(visible = true, transformation(origin = {-22, 84}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant hConWin(k = 20 * 14) "Outdoor coefficient of heat transfer for windows" annotation (
    Placement(visible = true, transformation(origin = {-20, 138}, extent = {{4, -4}, {-4, 4}}, rotation = 90)));
equation
  connect(eqAirTemp.TEqAirWin, preTem1.T) annotation (
    Line(points = {{-55, 99.8}, {-52, 99.8}, {-52, 120}, {-45.2, 120}}, color = {0, 0, 127}));
  connect(eqAirTemp.TEqAir, preTem.T) annotation (
    Line(points = {{-55, 96}, {-48, 96}, {-48, 100}, {-45.2, 100}}, color = {0, 0, 127}));
  connect(weaDat.weaBus, weaBus) annotation (
    Line(points = {{-130, 162}, {-126, 162}, {-126, 118}, {-136, 118}, {-136, 112}, {-135, 112}, {-135, 106}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul) annotation (
    Line(points = {{-135, 106}, {-135, 98}, {-90, 98}, {-90, 90}, {-78, 90}}, color = {255, 204, 51}, thickness = 0.5));
  connect(intGai.y[1], perRad.Q_flow) annotation (
    Line(points={{99.2,158},{82,158}},        color = {0, 0, 127}));
  connect(intGai.y[2], perCon.Q_flow) annotation (
    Line(points={{99.2,158},{88.7,158},{88.7,140},{82,140}},            color = {0, 0, 127}));
  connect(intGai.y[3], macConv.Q_flow) annotation (
    Line(points={{99.2,158},{92.2,158},{92.2,120},{82,120}},            color = {0, 0, 127}));
  connect(const.y, eqAirTemp.sunblind) annotation (
    Line(points = {{-65.7, 117}, {-64, 117}, {-64, 108}, {-66, 108}}, color = {0, 0, 127}));
  connect(HDifTil.HSkyDifTil, corGDouPan.HSkyDifTil) annotation (
    Line(points = {{-99, 136}, {-80, 136}, {-58, 136}, {-58, 166}, {-48, 166}}, color = {0, 0, 127}));
  connect(HDirTil.H, corGDouPan.HDirTil) annotation (
    Line(points = {{-99, 162}, {-62, 162}, {-62, 170}, {-48, 170}}, color = {0, 0, 127}));
  connect(HDirTil.H, solRad.u1) annotation (
    Line(points = {{-99, 162}, {-94, 162}, {-94, 114}, {-91, 114}}, color = {0, 0, 127}));
  connect(HDirTil.inc, corGDouPan.inc) annotation (
    Line(points = {{-99, 158}, {-48, 158}}, color = {0, 0, 127}));
  connect(HDifTil.H, solRad.u2) annotation (
    Line(points = {{-99, 130}, {-96, 130}, {-96, 108}, {-91, 108}}, color = {0, 0, 127}));
  connect(HDifTil.HGroDifTil, corGDouPan.HGroDifTil) annotation (
    Line(points = {{-99, 124}, {-56, 124}, {-56, 162}, {-48, 162}}, color = {0, 0, 127}));
  connect(solRad.y, eqAirTemp.HSol) annotation (
    Line(points = {{-79.5, 111}, {-78, 111}, {-78, 102}}, color = {0, 0, 127}));
  connect(weaDat.weaBus, HDifTil[1].weaBus) annotation (
    Line(points = {{-130, 162}, {-126, 162}, {-126, 130}, {-120, 130}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaDat.weaBus, HDifTil[2].weaBus) annotation (
    Line(points = {{-130, 162}, {-126, 162}, {-126, 130}, {-120, 130}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaDat.weaBus, HDirTil[1].weaBus) annotation (
    Line(points = {{-130, 162}, {-125, 162}, {-120, 162}}, color = {255, 204, 51}, thickness = 0.5));
  connect(weaDat.weaBus, HDirTil[2].weaBus) annotation (
    Line(points = {{-130, 162}, {-125, 162}, {-120, 162}}, color = {255, 204, 51}, thickness = 0.5));
  connect(perRad.port, thermalZoneOneElement.intGainsRad) annotation (
    Line(points = {{62, 158}, {50, 158}, {50, 124}, {40, 124}}, color = {191, 0, 0}));
  connect(theConWin.solid, thermalZoneOneElement.window) annotation (
    Line(points = {{-14, 121}, {-12, 121}, {-12, 120}, {-8, 120}}, color = {191, 0, 0}));
  connect(preTem1.port, theConWin.fluid) annotation (
    Line(points = {{-32, 120}, {-24, 120}, {-24, 121}}, color = {191, 0, 0}));
  connect(thermalZoneOneElement.extWall, theConWall.solid) annotation (
    Line(points = {{-8, 112}, {-12, 112}, {-12, 101}, {-16, 101}}, color = {191, 0, 0}));
  connect(theConWall.fluid, preTem.port) annotation (
    Line(points = {{-26, 101}, {-28, 101}, {-28, 100}, {-32, 100}}, color = {191, 0, 0}));
  connect(hConWall.y, theConWall.Gc) annotation (
    Line(points = {{-22, 88.4}, {-22, 96}, {-21, 96}}, color = {0, 0, 127}));
  connect(hConWin.y, theConWin.Gc) annotation (
    Line(points = {{-20, 133.6}, {-20, 126}, {-19, 126}}, color = {0, 0, 127}));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky) annotation (
    Line(points = {{-135, 106}, {-110, 106}, {-110, 102}, {-84, 102}, {-84, 96}, {-78, 96}}, color = {255, 204, 51}, thickness = 0.5));
  connect(macConv.port, thermalZoneOneElement.intGainsConv) annotation (
    Line(points = {{62, 120}, {40, 120}}, color = {191, 0, 0}));
  connect(perCon.port, thermalZoneOneElement.intGainsConv) annotation (
    Line(points = {{62, 140}, {55, 140}, {55, 120}, {40, 120}}, color = {191, 0, 0}));
  connect(corGDouPan.solarRadWinTrans, thermalZoneOneElement.solRad) annotation (
    Line(points = {{-25, 164}, {-18, 164}, {-12, 164}, {-12, 131}, {-9, 131}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html>
  <p>This example shows the application of
  <a href=\"Buildings.ThermalZones.ReducedOrder.RC.OneElement\">
  Buildings.ThermalZones.ReducedOrder.RC.OneElement</a>
  in combination with
  <a href=\"Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow\">
 Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow</a>
  and
  <a href=\"Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane\">
  Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane</a>.
  Solar radiation on tilted surface is calculated using models of
  Buildings. The thermal zone is a simple room defined in Guideline
  VDI 6007 Part 1 (VDI, 2012). All models, parameters and inputs
  except sunblinds, separate handling of heat transfer through
  windows, no wall element for internal walls and solar radiation
  are similar to the ones defined for the guideline&apos;s test
  room. For solar radiation, the example relies on the standard
  weather file in Buildings.</p>
  <p>The idea of the example is to show a typical application of all
  sub-models and to use the example in unit tests. The results are
  reasonable, but not related to any real use case or measurement
  data.</p>
  <h4>References</h4>
  <p>VDI. German Association of Engineers Guideline VDI 6007-1
  March 2012. Calculation of transient thermal response of rooms
  and buildings - modelling of rooms.</p>
  </html>", revisions = "<html>
  <ul>
  <li>
  July 11, 2019, by Katharina Brinkmann:<br/>
  Renamed <code>alphaWall</code> to <code>hConWall</code>,
  <code>alphaWin</code> to <code>hConWin</code>
  </li>
  <li>
  April 27, 2016, by Michael Wetter:<br/>
  Removed call to <code>Modelica.Utilities.Files.loadResource</code>
  as this did not work for the regression tests.
  </li>
  <li>February 25, 2016, by Moritz Lauster:<br/>
  Implemented.
  </li>
  </ul>
  </html>"),
    experiment(Tolerance = 1e-6, StopTime = 3.1536e+007, Interval = 3600),
    __Dymola_Commands(file = "modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/ReducedOrder/Examples/SimpleRoomOneElement.mos" "Simulate and plot"),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}}), graphics={  Rectangle(origin = {10, 121}, fillColor = {170, 170, 127},
            fillPattern =                                                                                                                               FillPattern.Solid, extent = {{-182, 71}, {182, -71}}), Text(origin = {131, 70}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter")}),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end Trial;
