within RoofKIT.Components.Solar.Thermal.Examples;
model FlatPlate "Test model for FlatPlate"
  extends Modelica.Icons.Example;
  replaceable package Medium = Buildings.Media.Water
    "Medium in the system";

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
    Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data input file"
    annotation (Placement(transformation(extent={{-32,20},{-12,40}})));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    p(displayUnit="bar") = 100000,
    nPorts=1) "Outlet for water flow"
    annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TOut(
    redeclare package Medium = Medium,
    T_start(displayUnit="K"),
    m_flow_nominal=2)                     "Temperature sensor"
    annotation (Placement(transformation(extent={{30,-20},{50,0}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TIn(redeclare package Medium =
    Medium, m_flow_nominal=2)                     "Temperature sensor"
    annotation (Placement(transformation(extent={{-32,-20},{-12,0}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    T=273.15 + 10,
    nPorts=1,
    use_p_in=true) "Inlet for water flow"
    annotation (Placement(
      transformation(
      extent={{10,-10},{-10,10}},
      rotation=180,
      origin={-50,-10})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=3/86400,
    amplitude=-150,
    offset=1E5) "Pressure source"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  ThermalCollector solarTh_LWL(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    dp_nominal(displayUnit="Pa") = 150) annotation (Placement(visible=true,
        transformation(
        origin={10,-10},
        extent={{-10,-10},{10,10}},
        rotation=0)));
equation
  connect(sou.ports[1], TIn.port_a) annotation (
    Line(points = {{-40, -10}, {-32, -10}}, color = {0, 127, 255}, smooth = Smooth.None));
  connect(TOut.port_b, sin.ports[1]) annotation (
    Line(points = {{50, -10}, {80, -10}}, color = {0, 127, 255}));
  connect(sine.y, sou.p_in) annotation (
    Line(points = {{-79, -10}, {-70, -10}, {-70, -18}, {-62, -18}}, color = {0, 0, 127}));
  connect(TIn.port_b, solarTh_LWL.port_a) annotation (
    Line(points = {{-12, -10}, {0, -10}}, color = {0, 127, 255}));
  connect(TOut.port_a, solarTh_LWL.port_b) annotation (
    Line(points = {{30, -10}, {20, -10}}, color = {0, 127, 255}));
  connect(weaDat.weaBus, solarTh_LWL.WeaBusWeaPar) annotation (Line(
      points={{-12,30},{3.6,30},{3.6,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
This example demonstrates the implementation of
<a href=\"modelica://Buildings.Fluid.SolarCollectors.ASHRAE93\">
Buildings.Fluid.SolarCollectors.ASHRAE93</a>
for a variable fluid flow rate and weather data from
San Francisco, CA, USA.
</p>
</html>",
revisions="<html>
<ul>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
September 18, 2014, by Michael Wetter:<br/>
Changed medium from water to glycol.
</li>
<li>
Mar 27, 2013, by Peter Grant:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/SolarCollectors/Examples/FlatPlate.mos"
        "Simulate and plot"),
 experiment(Tolerance=1e-6, StopTime=86400.0));
end FlatPlate;
