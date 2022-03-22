within RoofKIT.Components.Ventilation;
model Decentral_Singlefan
  "Generic tubular decentralized ventilation system with ideal HRC giving material properties"

  // Variable - parameters //
  // Ventilator
  parameter Modelica.SIunits.MassFlowRate m_flow_nom=35*1.2/3600
    "Mass Flow [kg/s]";
  parameter Integer period=120 "Period in seconds";

  //Heat recovery
  parameter Modelica.SIunits.Temperature T_start = 283.15;
  parameter Modelica.SIunits.ThermalConductance UA "Convection transfer coefficient [W/K]";
  parameter Modelica.SIunits.HeatCapacity C "Heat Capacity [J/K]";


  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-2,
    width=50,
    offset=1,
    period=period)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

  Modelica.Blocks.Interfaces.RealOutput Q_HRC(final quantity="Power", final
      unit="W") annotation (Placement(transformation(
        rotation=0,
        extent={{-10,-10},{10,10}},
        origin={106,-80})));
public
  Modelica.Thermal.HeatTransfer.Components.Convection H_vent
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Math.Gain gainVent(k=UA)
    annotation (Placement(transformation(extent={{-64,20},{-44,40}})));
  Modelica.Blocks.Interfaces.RealInput mdot_vent
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Sources.RealExpression thermCap(each y=C)
    "Nominal mass flow ventilation system"
    annotation (Placement(transformation(extent={{-66,-88},{-34,-64}})));
  BaseClasses.Capacity_input capacity_input
    annotation (Placement(transformation(extent={{-10,-60},{10,-80}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-22,-34})));
  Modelica.Blocks.Math.Sum sumHF
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Interfaces.RealInput Troom "Room air temperature"
    annotation (Placement(transformation(extent={{126,40},{86,80}})));
  Modelica.Blocks.Interfaces.RealInput Tamb "Ambient temperature"
    annotation (Placement(transformation(extent={{126,-4},{86,36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{38,-10},{18,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{70,30},{50,50}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
equation

  connect(H_vent.Gc, gainVent.y)
    annotation (Line(points={{2,10},{2,30},{-43,30}},  color={0,0,127}));
  connect(heatFlowSensor.port_b, H_vent.solid) annotation (Line(points={{-22,-24},
          {-22,0},{-8,0}},                  color={191,0,0}));
  connect(capacity_input.port, heatFlowSensor.port_a) annotation (Line(points={{0,-60},
          {0,-52},{-22,-52},{-22,-44}},       color={191,0,0}));
  connect(capacity_input.C, thermCap.y) annotation (Line(points={{-10,-76},{
          -32.4,-76}},            color={0,0,127}));
  connect(sumHF.u[1], heatFlowSensor.Q_flow) annotation (Line(points={{58,-50},
          {46,-50},{46,-34},{-12,-34}},
                                      color={0,0,127}));
  connect(sumHF.y, Q_HRC) annotation (Line(points={{81,-50},{86,-50},{86,-80},{
          106,-80}},
                 color={0,0,127}));
  connect(prescribedTemperature.port, H_vent.fluid)
    annotation (Line(points={{18,0},{12,0}}, color={191,0,0}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{31,70},{80,
          70},{80,40},{72,40}}, color={255,0,255}));
  connect(switch1.y, prescribedTemperature.T)
    annotation (Line(points={{49,40},{46,40},{46,0},{40,0}}, color={0,0,127}));
  connect(mdot_vent, gainVent.u) annotation (Line(points={{-108,80},{-80,80},{
          -80,30},{-66,30}}, color={0,0,127}));
  connect(greaterThreshold.u, pulse.y)
    annotation (Line(points={{8,70},{-19,70}}, color={0,0,127}));
  connect(switch1.u1, Troom) annotation (Line(points={{72,48},{82,48},{82,60},{
          106,60}}, color={0,0,127}));
  connect(switch1.u3, Tamb) annotation (Line(points={{72,32},{82,32},{82,16},{
          106,16}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-50,40},{50,-40}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,40},{10,0}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{18,0},{10,-40}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,2},{14,-2}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,38},{-14,-38}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,52},{-50,-52}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,52},{68,-52}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,38},{42,-38}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={225,225,225},
          fillPattern=FillPattern.Solid),
        Line(
          points={{30,38},{42,-38}},
          color={0,127,255},
          thickness=0.5,
          smooth=Smooth.None)}),
           Documentation(info="<html>
<p>
This model represents a decentralized ventilation system equipped with a single fan (exhaust and supply alternating). This allows a single recuperative heat recovery unit, which stores the heat in exhaust phase, and releases it in supply phase. Pressure drops because of the filters and geometry of devices 
are also considered. If necessary, ducts pressure drop must be modelled separately.
</p>
<p>
The Real input <code>Speed_u</code> refers to the 
control of the ventilation mass flow.
</p>
<h4>References</h4>
<ul>
<li>
Fabien Coydon (2015). Holistic Evaluation of Ventilation Systems. Fraunhofer 
Editorial.Freiburg, Germany.
</li>
<li>
Elements sources: Buildings Library 5.0.1 (Released 2017). See Homepage
<a href=\"http://simulationresearch.lbl.gov/modelica/\"> 
LBNL Modelica Buildings Library Homepage </a> 
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
August 23, 2017, by Nicolas Carbonare:<br/>
First implementation. Not validated.
</li>
</ul>
</html>"));
end Decentral_Singlefan;
