within RoofKIT.Components.Solar.Thermal;
model ThermalCollector "Model for a solar thermal collector"
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

  replaceable package Medium = Buildings.Media.Water "Medium model";

  parameter Modelica.SIunits.Area A_coll=2 "Area of solar thermal collector"
    annotation(Dialog(group = "Construction"));
  parameter Modelica.SIunits.Volume volSol=0.05 "Water volume of piping"
    annotation(Dialog(group = "Construction"));

//=========HEAT GAIN PARAMETERS====================================
  parameter Real B0 = 0.05 "1st incident angle modifer coefficient"
                                                                   annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);
  parameter Real iamDiff = 0.95 "Incidence angle modifier for diffuse radiation"
                                                                                annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);
  parameter Real capColl( unit = "J/K")=20000 "Collector thermal capacity" annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);

  parameter Real Eta_zero=0.8 "Collector maximum efficiency" annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);
  parameter Real c1=5 "Collector coefficient 1"
                                               annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);
  parameter Real c2=0.01 "Collector coefficient 2"
                                                  annotation(Dialog(group = "Efficiency"), choicesAllMatching = true);

  parameter Modelica.SIunits.Angle lat( displayUnit="rad")=0.91455252699775
                                                          "Latitude (default Potsdam)"
                                                                                      annotation(Dialog(group = "Location"), choicesAllMatching = true);
  parameter Modelica.SIunits.Angle azi( displayUnit="rad")=-1.5708
                                                          "Surface azimuth, 0 for south facing.-90 for east (default) facing plus 90 for east facing"
                                                          annotation(Dialog(group = "Location"), choicesAllMatching = true);
  parameter Modelica.SIunits.Angle til(displayUnit="rad")= 0.785398 "Surface tilt (default 45 deg)"
                                                                                                   annotation(Dialog(group = "Location"), choicesAllMatching = true);
  parameter Real rho(min=0, max=1, final unit="1")=0.2 "Ground reflectance"
                                                                           annotation(Dialog(group = "Location"), choicesAllMatching = true);

  parameter Modelica.SIunits.PressureDifference dp_nominal "Nominal pressure drop"
    annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.Temperature T_start=25+273.15
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  Buildings.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = Medium,
    final tau=1,
    final m_flow_nominal=m_flow_nominal,
    final T_start=T_start)
    "Temperature sensor of cold side of heat generator (return)"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Medium,
    final tau=1,
    final m_flow_nominal=m_flow_nominal,
    final T_start=T_start)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare final package Medium =
        Medium)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-50})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    V=volSol,
    final nPorts=2)        "Fluid volume"
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Buildings.Fluid.FixedResistances.PressureDrop pressureDrop(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final show_T=false,
    dp_nominal=dp_nominal)
    "Pressure drop"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));

  RoofKIT.Components.Solar.Thermal.BaseClasses.ISO9806_simple iSO9806_HeatBalance(
    A_G=A_coll,
    Eta_zero=Eta_zero,
    c1=c1,
    c2=c2,
    capColl=capColl,
    iamDiff=iamDiff,
    B0=B0) annotation (Placement(transformation(extent={{26,-6},{54,22}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    til=til,
    lat=lat,
    azi=azi) "Direct solar irradiation on a tilted surface"
    annotation (Placement(transformation(extent={{-42,22},{-22,42}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil(
    til=til,
    rho=rho,
    lat=lat,
    azi=azi,
    outSkyCon=true,
    outGroCon=true) "Diffuse solar irradiation on a tilted surface"
    annotation (Placement(transformation(extent={{-42,54},{-22,74}})));
public
  Buildings.BoundaryConditions.WeatherData.Bus WeaBusWeaPar
    "Weather data bus for weather data other than solar irradiation"
    annotation (Placement(transformation(extent={{-74,90},{-54,110}}),
        iconTransformation(extent={{-74,90},{-54,110}})));
equation
  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-90,0},{-90,
          -80},{-80,-80}}, color={0,127,255},
      thickness=1));
  connect(senTCold.port_b, vol.ports[1])
    annotation (Line(points={{-60,-80},{-42,-80}}, color={0,127,255},
      thickness=1));
  connect(vol.ports[2], pressureDrop.port_a) annotation (Line(
      points={{-38,-80},{-38,-80},{-20,-80}},
      color={0,127,255},
      thickness=1));
  connect(senMasFlo.port_b, port_b) annotation (Line(points={{80,-80},{90,-80},{
          90,0},{100,0}}, color={0,127,255},
      thickness=1));
  connect(pressureDrop.port_b, senTHot.port_a) annotation (Line(
      points={{0,-80},{0,-80},{30,-80}},
      color={0,127,255},
      thickness=1));
  connect(senTHot.port_b, senMasFlo.port_a)
    annotation (Line(points={{50,-80},{55,-80},{60,-80}}, color={0,127,255},
      thickness=1));
  connect(heater.port, vol.heatPort) annotation (Line(points={{-60,-60},{-60,-60},
          {-60,-66},{-60,-70},{-50,-70}}, color={191,0,0}));
  connect(WeaBusWeaPar, HDifTil.weaBus) annotation (Line(
      points={{-64,100},{-64,76},{-48,76},{-48,64},{-42,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(WeaBusWeaPar, HDirTil.weaBus) annotation (Line(
      points={{-64,100},{-64,36},{-42,36},{-42,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(HDifTil.H,iSO9806_HeatBalance. Gd) annotation (Line(points={{-21,64},{
          4,64},{4,5.2},{23.2,5.2}},  color={0,0,127}));
  connect(HDirTil.inc,iSO9806_HeatBalance. theta) annotation (Line(points={{-21,28},
          {2,28},{2,-2.08},{23.48,-2.08}},     color={0,0,127}));
  connect(HDirTil.H,iSO9806_HeatBalance. Gb) annotation (Line(points={{-21,32},{
          2,32},{2,12.2},{23.2,12.2}},    color={0,0,127}));
  connect(WeaBusWeaPar.TDryBul, iSO9806_HeatBalance.T_a) annotation (Line(
      points={{-64,100},{12,100},{12,19.2},{23.2,19.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(iSO9806_HeatBalance.Quseful, heater.Q_flow) annotation (Line(points={{
          55.4,8},{60,8},{60,-16},{-60,-16},{-60,-40}}, color={0,0,127}));
  connect(senTHot.T, iSO9806_HeatBalance.Tout) annotation (Line(points={{40,-69},
          {40,-38},{74,-38},{74,42},{40,42},{40,24.8}}, color={0,0,127}));
  connect(iSO9806_HeatBalance.Tin, senTCold.T) annotation (Line(points={{34.4,24.8},
          {34.4,40},{-14,40},{-14,-30},{-70,-30},{-70,-69}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(fillColor = {170, 170, 255}, fillPattern = FillPattern.VerticalCylinder, extent = {{-60, 80}, {60, -80}}),                                                                              Rectangle(lineColor = {170, 0, 0}, fillColor = {170, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-84, 80}, {84, -80}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-76, 70}, {-70, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-76, 70}, {-46, 64}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-46, 70}, {-52, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-50, -72}, {-28, -66}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-10, -72}, {16, -66}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-4, 70}, {-10, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-30, 70}, {-4, 64}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-30, 70}, {-24, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{34, -72}, {56, -66}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{38, 70}, {32, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{12, 70}, {38, 64}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{12, 70}, {18, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{70, -72}, {90, -66}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{76, 70}, {70, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{50, 70}, {76, 64}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{50, 70}, {56, -72}}), Rectangle(fillPattern = FillPattern.Solid, extent = {{-90, -72}, {-70, -66}})}),
    Documentation(info="<html><p>
Solar thermal collector model based on the ISO 9806 balance equation. This model was adapted from the solar collector model in the AixLib and was simplified. Credits to the AixLib development team. 
</p>
<ul>
  <li>
    November 08, 2021, by Nicolas Carbonare:<br/>
	First implementation.
  </li>
</ul>
</html>"));
end ThermalCollector;
