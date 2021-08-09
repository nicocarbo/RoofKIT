within RoofKIT.Components.Ventilation;
model Decentral_Doublefan
  "Decentralized ventilation system with ideal HRC, with supply and exhaust air"

  replaceable package Medium =
    Buildings.Media.Air "Medium (Air) in the component";

  parameter Modelica.SIunits.MassFlowRate m_flowair_nom;
  parameter Modelica.SIunits.PressureDifference dpfan_nom;
  parameter Modelica.SIunits.PressureDifference dpgeometry_nom;
  parameter Modelica.SIunits.PressureDifference dpfilt_nom;
  parameter Modelica.SIunits.PressureDifference dphx_nom;
  parameter Real hex_eff;
  parameter Real CO2_out = 0.4*1.519E-3 "400 ppm CO2";

  Modelica.Blocks.Interfaces.RealInput Speed_u "Fan control system input"
    annotation (Placement(transformation(
        extent={{-17,-17},{17,17}},
        rotation=0,
        origin={-111,-1}),  iconTransformation(extent={{-112,-12},{-86,14}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Sup_Air(
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    m_flow(start=m_flowair_nom),
    show_T=true,
    dp(start=dpfan_nom),
    m_flow_nominal=m_flowair_nom,
    dp_nominal=dpfan_nom,
    redeclare package Medium = Medium,
    T_start=273.15) "Ventilation supply fan"
    annotation (Placement(transformation(extent={{-8,68},{8,52}})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness hex(
    m1_flow_nominal=m_flowair_nom,
    m2_flow_nominal=m_flowair_nom,
    eps=hex_eff,
    m1_flow(start=m_flowair_nom),
    m2_flow(start=m_flowair_nom),
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    dp1_nominal=dphx_nom,
    dp2_nominal=dphx_nom)
    annotation (Placement(transformation(extent={{-6,-14},{8,0}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow Exh_Air(
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    show_T=true,
    dp(start=dpfan_nom),
    m_flow(start=m_flowair_nom),
    m_flow_nominal=m_flowair_nom,
    dp_nominal=dpfan_nom,
    redeclare package Medium = Medium) "Ventilation exhaust fan"
    annotation (Placement(transformation(extent={{8,-68},{-8,-52}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemp_Sup(
    m_flow_nominal=m_flowair_nom, redeclare package Medium = Medium)
    "Temperature sensor for heat recovery outlet on supply side"
    annotation (Placement(transformation(extent={{50,18},{66,34}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemp_Exho(
    m_flow_nominal=m_flowair_nom, redeclare package Medium = Medium)
    "Temperature sensor for heat recovery outlet on exhaust side"
    annotation (Placement(transformation(extent={{-50,-68},{-64,-52}})));
  Buildings.Fluid.FixedResistances.PressureDrop DP_SupFilt1(
    show_T=false,
    m_flow_nominal=m_flowair_nom,
    m_flow(start=m_flowair_nom),
    redeclare package Medium = Medium,
    dp(start=dpgeometry_nom + dpfilt_nom),
    dp_nominal=dpgeometry_nom + dpfilt_nom)
                                       "Pressure drop on filters"
    annotation (Placement(transformation(extent={{-64,52},{-48,68}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-112,28},{-92,48}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{-112,-50},{-92,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
        iconTransformation(extent={{92,-50},{112,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}}),
        iconTransformation(extent={{92,30},{112,50}})));
  Buildings.Fluid.FixedResistances.PressureDrop DP_ExhFilt(
    show_T=false,
    m_flow_nominal=m_flowair_nom,
    m_flow(start=m_flowair_nom),
    redeclare package Medium = Medium,
    dp_nominal=dpgeometry_nom + dpfilt_nom,
    dp(start=dpgeometry_nom + dpfilt_nom))
                                       "Pressure drop on filters"
    annotation (Placement(transformation(extent={{64,-68},{48,-52}})));
equation
  connect(DP_SupFilt1.port_b,Sup_Air. port_a) annotation (Line(
      points={{-48,60},{-8,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(Speed_u, Exh_Air.m_flow_in) annotation (Line(
      points={{-111,-1},{-24,-1},{-24,-34},{0,-34},{0,-56},{0,-56},{0,-50.4}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Exh_Air.port_a, hex.port_b2) annotation (Line(
      points={{8,-60},{20,-60},{20,-30},{-20,-30},{-20,-11.2},{-6,-11.2}},
      color={0,150,255},
      smooth=Smooth.None));

  connect(senTemp_Exho.port_a, Exh_Air.port_b) annotation (Line(
      points={{-50,-60},{-8,-60}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(port_a2, port_a2) annotation (Line(
      points={{100,-60},{100,-60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTemp_Sup.port_b, port_b1) annotation (Line(
      points={{66,26},{92,26},{92,60},{100,60}},
      color={245,245,45},
      smooth=Smooth.None));
  connect(hex.port_a1, Sup_Air.port_b) annotation (Line(
      points={{-6,-2.8},{-20,-2.8},{-20,18},{20,18},{20,60},{8,60}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(Sup_Air.m_flow_in, Speed_u) annotation (Line(
      points={{0,50.4},{0,48},{0,48},{0,22},{-24,22},{-24,-1},{-111,-1}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(DP_ExhFilt.port_b, hex.port_a2) annotation (Line(
      points={{48,-60},{24,-60},{24,-11.2},{8,-11.2}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(DP_SupFilt1.port_a, port_a1) annotation (Line(
      points={{-64,60},{-100,60}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(DP_ExhFilt.port_a, port_a2) annotation (Line(
      points={{64,-60},{100,-60}},
      color={255,0,0},
      smooth=Smooth.None));
  connect(senTemp_Exho.port_b, port_b2) annotation (Line(points={{-64,-60},{-82,
          -60},{-100,-60}}, color={0,127,255}));
  connect(hex.port_b1, senTemp_Sup.port_a) annotation (Line(points={{8,-2.8},{24,
          -2.8},{24,-2},{24,26},{50,26}}, color={245,245,45}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Rectangle(extent={{-22,20},{22,-32}},     lineColor={0,0,255},
          lineThickness=0.5),
        Rectangle(extent={{-22,100},{22,20}},     lineColor={0,0,255},
          lineThickness=0.5),
        Rectangle(extent={{-88,100},{-22,0}},     lineColor={0,0,255},
          lineThickness=0.5),
        Rectangle(extent={{22,0},{88,-100}},      lineColor={0,0,255},
          lineThickness=0.5),
        Rectangle(extent={{-88,0},{-22,-100}},    lineColor={0,0,255},
          lineThickness=0.5),
        Text(
          extent={{-12,98},{14,80}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Supply fan"),
        Text(
          extent={{-68,42},{-42,20}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=26,
          textString="Supply filter +
Geometry pressure drop
"),     Text(
          extent={{34,98},{76,86}},
          lineColor={245,245,45},
          fillColor={245,245,45},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Supply temperature"),
        Text(
          extent={{-104,-144},{-50,-166}},
          lineColor={0,150,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=16,
          textString="Exhaust temperature"),
        Text(
          extent={{-16,-84},{16,-94}},
          lineColor={0,150,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=22,
          textString="Exhaust fan"),
        Text(
          extent={{38,-76},{74,-88}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=22,
          textString="Exhaust filter +
Geometry pressure drop"),
        Text(
          extent={{-16,20},{14,6}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Heat recovery"),
        Rectangle(extent={{22,100},{88,0}},       lineColor={0,0,255},
          lineThickness=0.5),
        Rectangle(extent={{-22,-32},{22,-100}},   lineColor={0,0,255},
          lineThickness=0.5),
        Text(
          extent={{-76,-80},{-34,-92}},
          lineColor={0,150,255},
          fillColor={245,245,45},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Exhaust temperature")}),
                                       Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-92,66},{92,-66}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={155,155,155}),
        Rectangle(
          extent={{-86,60},{86,-60}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={225,225,225}),
        Polygon(
          points={{-50,32},{-50,42},{-8,12},{-14,6},{-50,32}},
          lineColor={0,0,255},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-50,-34},{-50,-44},{-8,-12},{-14,-6},{-50,-34}},
          lineColor={127,127,255},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={127,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{6,14},{12,8},{52,36},{52,46},{6,14}},
          lineColor={245,245,45},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={245,245,45},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{8,-12},{14,-6},{50,-36},{50,-46},{8,-12}},
          lineColor={255,0,0},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-92,56},{-86,18}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={80,80,80}),
        Rectangle(
          extent={{-100,42},{-50,32}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-92,-16},{-86,-54}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={80,80,80}),
        Rectangle(
          extent={{86,56},{92,18}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={80,80,80}),
        Rectangle(
          extent={{86,-18},{92,-56}},
          lineColor={0,0,255},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fillColor={80,80,80}),
        Polygon(
          points={{50,-46},{50,-36},{98,-36},{98,-46},{50,-46}},
          lineColor={255,0,0},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{52,46},{52,36},{100,36},{100,46},{52,46}},
          lineColor={245,245,45},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={245,245,45},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-34},{-50,-44}},
          lineColor={127,127,255},
          lineThickness=0.5,
          fillColor={127,127,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,0},{0,20},{20,0},{0,-20},{0,-20},{-20,0}},
          lineColor={0,0,0},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
          Documentation(info="<html>
<p>
This model represents a decentralized ventilation system equipped with two fans
(exhaust and supply) separately. This allows a traditional recuperative 
counterflow heat recovery unit. Pressure drops because of the filters and 
geometry of devices are also considered. If necessary, ducts pressure drop 
must be modelled separately.
</p>
<p>
The Real input <code>Speed_u</code> refers to the control of the ventilation 
mass flow (ideally balanced mass flows).
</p>
<p>
The next figure (source: Coydon(2015)) represents a scheme of this model.
</p>
<p><img src=\"modelica://Work_NC/Components/Fluid/Ventilation/AHU_Awbi.jpg\"
alt=\"schema of AHU\"/> 
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
end Decentral_Doublefan;
