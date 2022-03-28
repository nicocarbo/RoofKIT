within RoofKIT.Components.Ventilation.Examples;
model Decentral_SingleFan

  extends Modelica.Icons.Example;
  package Medium = Buildings.Media.Air(extraPropertiesNames={"CO2"},
                                          C_nominal={0.4*1.519E-3});

  parameter Modelica.SIunits.Volume RoomVol = 5*5*2.5 "Room volume";
  parameter Modelica.SIunits.MassFlowRate m_flow_nom = 0.005
    "Air mass flow nominal";
  parameter Modelica.SIunits.PressureDifference dp_nom=100 "Pressure losses";
  parameter Modelica.SIunits.PressureDifference dpfan_nom = 50 "Fan pressure";
  parameter Modelica.SIunits.HeatFlowRate QInt_gains = 180 "Internal Gains";
  parameter Modelica.SIunits.Temperature Troom = 273.15+20 "Room Temperature";
  parameter Modelica.SIunits.Temperature Tamb = 273.15 "Ambient Temperature";
  parameter Real CO2_out = 0.4*1.519E-3 "400 ppm CO2";
  parameter Real hex_eff = 0.80 "Heat recovery nominal efficiency";
  parameter Modelica.SIunits.Pressure p_amb = 101325 "Ambient pressure 1 bar";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor Wall_Con(G=0.2*9*
        2.5) "Thermal conductor - External wall"
    annotation (Placement(transformation(extent={{92,28},{80,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFlo
    "Heat flow sensor"
    annotation (Placement(transformation(extent={{76,26},{60,42}})));
  Buildings.HeatTransfer.Sources.FixedTemperature TAmb(T=Tamb)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=180,
        origin={80,12})));
  Buildings.Fluid.MixingVolumes.MixingVolume Room_Vol(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nom,
    T_start=Troom,
    V=RoomVol,
    use_C_flow=false,
    p_start(displayUnit="Pa") = p_amb,
    X_start={0.0075/1.0075,1/1.0075},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    C_start={CO2_out}) "Room volume"
    annotation (Placement(transformation(extent={{-56,26},{-72,42}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow IntGains
    "Heat Flow - Internal gains"
    annotation (Placement(transformation(extent={{22,58},{8,72}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=30*1.2*1006)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{-8,8},{8,-8}},
        rotation=90,
        origin={70,-6})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=24*3600,
    startTime=8*3600,
    width=10/24*100,
    amplitude=QInt_gains,
    offset=QInt_gains/3)
    annotation (Placement(transformation(extent={{60,60},{50,70}})));

  inner Modelica.Fluid.System system(T_ambient=Tamb, p_ambient=p_amb)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.RealExpression Fan_Speed_Nom(y=m_flow_nom) "30 m3/h"
    annotation (Placement(transformation(extent={{34,-38},{20,-24}})));
  Decentral_Singlefan decentral_Singlefan(UA=50, C=2000)
    annotation (Placement(transformation(extent={{-6,-52},{-26,-32}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-42,-8},{-22,12}})));
  Modelica.Blocks.Sources.RealExpression Tamb_cel(y=Tamb) "30 m3/h"
    annotation (Placement(transformation(extent={{-70,-48},{-56,-34}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow ventHeatFlow
    "Ventilation Heat Flow"
    annotation (Placement(transformation(extent={{-52,-62},{-66,-48}})));
equation

  connect(TAmb.port,Wall_Con. port_a)    annotation (Line(points={{86,12},{86,12},
          {94,12},{94,34},{92,34}},                       color={191,0,0}));
  connect(Wall_Con.port_b,heaFlo. port_a)   annotation (Line(points={{80,34},{80,
          34},{76,34}},                                                                           color={191,0,0}));
  connect(IntGains.port, Room_Vol.heatPort) annotation (Line(
      points={{8,65},{-6,65},{-6,34},{-56,34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pulse.y, IntGains.Q_flow) annotation (Line(
      points={{49.5,65},{22,65}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(heaCap.port, Room_Vol.heatPort) annotation (Line(
      points={{62,-6},{-6,-6},{-6,34},{-56,34}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(heaFlo.port_b, Room_Vol.heatPort) annotation (Line(
      points={{60,34},{-56,34}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(decentral_Singlefan.mdot_vent, Fan_Speed_Nom.y) annotation (Line(
        points={{-5.2,-34},{12,-34},{12,-31},{19.3,-31}}, color={0,0,127}));
  connect(temperatureSensor.port, Room_Vol.heatPort)
    annotation (Line(points={{-42,2},{-56,2},{-56,34}}, color={191,0,0}));
  connect(temperatureSensor.T, decentral_Singlefan.Troom) annotation (Line(
        points={{-22,2},{-16,2},{-16,-18},{-34,-18},{-34,-36},{-26.6,-36}},
        color={0,0,127}));
  connect(Tamb_cel.y, decentral_Singlefan.Tamb) annotation (Line(points={{-55.3,
          -41},{-40.65,-41},{-40.65,-40.4},{-26.6,-40.4}}, color={0,0,127}));
  connect(decentral_Singlefan.Q_HRC, ventHeatFlow.Q_flow) annotation (Line(
        points={{-26.6,-50},{-32,-50},{-32,-48},{-42,-48},{-42,-55},{-52,-55}},
        color={0,0,127}));
  connect(ventHeatFlow.port, Room_Vol.heatPort) annotation (Line(points={{-66,
          -55},{-84,-55},{-84,-2},{-56,-2},{-56,34}}, color={191,0,0}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-92,50},{-24,16}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-14,76},{98,56}},
          lineColor={255,0,0},
          lineThickness=0.5),
        Text(
          extent={{66,-10},{94,-24}},
          lineColor={150,50,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Heat Transfer"),
        Text(
          extent={{-48,28},{-34,22}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Room"),
        Text(
          extent={{96,72},{58,58}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Heat 
Source"),
        Rectangle(
          extent={{56,54},{98,-22}},
          lineColor={150,50,0},
          lineThickness=0.5),
        Text(
          extent={{10,-78},{60,-50}},
          lineColor={21,222,216},
          textString="Decentralized
Ventilation system"),
        Rectangle(
          extent={{-90,-22},{64,-76}},
          lineColor={21,222,216},
          lineThickness=0.5)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end Decentral_SingleFan;
