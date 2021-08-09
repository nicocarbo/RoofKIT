within RoofKIT.Components.Ventilation.Examples;
model Decentral_Doublefan
  //import Work_NC;

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
  parameter Modelica.SIunits.Temperature Tamb = 273.15 "Room Temperature";
  parameter Real CO2_out = 0.4*1.519E-3 "400 ppm CO2";
  parameter Real hex_eff = 0.80 "Heat recovery nominal efficiency";
  parameter Modelica.SIunits.Pressure p_amb = 101325 "Ambient pressure 1 bar";

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor Wall_Con(G=0.2*18*2.5)
    "Thermal conductor - External wall"
    annotation (Placement(transformation(extent={{92,50},{80,62}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFlo
    "Heat flow sensor"
    annotation (Placement(transformation(extent={{76,48},{60,64}})));
  Buildings.HeatTransfer.Sources.FixedTemperature TAmb(T=Tamb)
    "Ambient temperature"
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=180,
        origin={80,34})));
  Buildings.Fluid.MixingVolumes.MixingVolume Room_Vol(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nom,
    T_start=Troom,
    V=RoomVol,
    use_C_flow=false,
    nPorts=4,
    p_start(displayUnit="Pa") = p_amb,
    X_start={0.0075/1.0075,1/1.0075},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    C_start={CO2_out}) "Room volume"
    annotation (Placement(transformation(extent={{22,8},{6,24}})));
  Buildings.HeatTransfer.Sources.PrescribedHeatFlow IntGains
    "Heat Flow - Internal gains"
    annotation (Placement(transformation(extent={{30,78},{44,92}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=30*1.2*1006)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{-8,8},{8,-8}},
        rotation=90,
        origin={70,16})));
  Modelica.Blocks.Sources.Pulse pulse(
    period=24*3600,
    startTime=8*3600,
    width=10/24*100,
    amplitude=QInt_gains,
    offset=QInt_gains/3)
    annotation (Placement(transformation(extent={{0,84},{10,94}})));
  Buildings.Airflow.Multizone.Orifice ori(
    redeclare package Medium = Medium,
    dp(start=5*dp_nom),
    m_flow(start=m_flow_nom/5),
    A=0.05*0.01,
    m=0.5) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=0,
        origin={-56,20})));
  Modelica.Fluid.Sources.FixedBoundary SinkAir(
    redeclare package Medium = Medium,
    C={CO2_out},
    nPorts=1,
    p=p_amb,
    T=Tamb,
    X={0.0075/1.0075,1/1.0075}) "Boundary condition"
                                   annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-84,20})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort CO2Sen_Infilt(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nom,
    C_start=CO2_out) annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=0,
        origin={-72,-10})));
  Modelica.Blocks.Sources.Pulse pulse1(
    period=24*3600,
    startTime=8*3600,
    width=10/24*100,
    amplitude=2,
    offset=0)
    annotation (Placement(transformation(extent={{50,62},{40,72}})));
  Modelica.Blocks.Math.Gain gain(k=50/1000/3600)
    "CO2 mass flow rate, released per 100 person"
    annotation (Placement(transformation(extent={{42,40},{32,50}})));
  Buildings.Fluid.Sources.TraceSubstancesFlowSource CO2Sou(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{22,50},{10,62}})));
  Buildings.Fluid.Sensors.TraceSubstancesTwoPort CO2Sen_Source(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nom,
    C_start=CO2_out) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={0,56})));
  Buildings.Fluid.Sources.MassFlowSource_T HumSou(
    redeclare package Medium = Medium,
    use_X_in=false,
    X={1,0},
    m_flow=50/1000/3600,
    use_m_flow_in=true,
    nPorts=1,
    T=293.15) annotation (Placement(transformation(extent={{-34,50},{-22,62}})));
  Modelica.Fluid.Sources.FixedBoundary Sink(
    redeclare package Medium = Medium,
    C={CO2_out},
    p=p_amb,
    nPorts=1,
    T(displayUnit="degC") = Tamb,
    X={0.0075/1.0075,1/1.0075}) "Boundary condition"
                                   annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={46,-78})));
  Modelica.Fluid.Sources.FixedBoundary Sour(
    redeclare package Medium = Medium,
    C={CO2_out},
    p=p_amb,
    nPorts=1,
    T=Tamb,
    X={0.0075/1.0075,1/1.0075}) "Boundary condition"
                                   annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={34,-66})));
  Buildings.Fluid.Sensors.RelativePressure System_DP(
    redeclare package Medium = Medium)
    "Pressure loss in the entire ventilation system"
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={-73,-37})));
  Buildings.Fluid.FixedResistances.PressureDrop Sup_DP(
    m_flow_nominal=m_flow_nom,
    m_flow(start=m_flow_nom),
    redeclare package Medium = Medium,
    dp_nominal=0.45*dp_nom,
    dp(start=0.45*dp_nom),
    show_T=false) "Pressure drop on distribution system"
    annotation (Placement(transformation(extent={{-56,-10},{-42,-22}})));
  Buildings.Fluid.FixedResistances.PressureDrop Exh_DP(
    m_flow_nominal=m_flow_nom,
    m_flow(start=m_flow_nom),
    redeclare package Medium = Medium,
    dp(start=0.45*dp_nom),
    dp_nominal=0.45*dp_nom) "Pressure drop on the return syste" annotation (
      Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={-86,-26})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTabledamper(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    table=[0,0.4; 0.6*1.519E-3,0.6; 0.9*1.519E-3,0.8; 1.2*1.519E-3,1; 1,1])
    "Control table for the damper steps - k value"
    annotation (Placement(transformation(extent={{80,-36},{70,-26}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{54,-22},{44,-12}})));
  Modelica.Blocks.Sources.RealExpression Fan_Speed_Nom(y=2*m_flow_nom)
    "30 m3/h"
    annotation (Placement(transformation(extent={{82,-18},{68,-4}})));
  Buildings.Fluid.Sensors.RelativeHumidityTwoPort senRelHum1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nom)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-30,10})));
  Modelica.Blocks.Sources.Pulse pulse2(
    period=24*3600,
    startTime=8*3600,
    width=10/24*100,
    offset=0,
    amplitude=1)
    annotation (Placement(transformation(extent={{-90,52},{-78,64}})));
  Modelica.Blocks.Math.Gain gain1(k=50/1000/3600)
    "CO2 mass flow rate, released per 100 person (there is another 100 factor in peopleSource)"
    annotation (Placement(transformation(extent={{-62,52},{-50,64}})));
  Work_NC._10_Components.Fluid.Ventilation.Generic.Decentral_Doublefan
                      AHU(
    redeclare package Medium = Medium,
    m_flowair_nom=m_flow_nom,
    dpfan_nom=dpfan_nom,
    hex_eff=hex_eff,
    dpgeometry_nom(displayUnit="Pa") = 5,
    dpfilt_nom(displayUnit="Pa") = 10,
    dphx_nom(displayUnit="Pa") = 20)
    annotation (Placement(transformation(extent={{4,-46},{-16,-26}})));

equation
  combiTabledamper.u = CO2Sen_Infilt.C;

  connect(TAmb.port,Wall_Con. port_a)    annotation (Line(points={{86,34},{86,34},
          {94,34},{94,56},{92,56}},                       color={191,0,0}));
  connect(Wall_Con.port_b,heaFlo. port_a)   annotation (Line(points={{80,56},{80,56},{76,56}},    color={191,0,0}));
  connect(IntGains.port, Room_Vol.heatPort) annotation (Line(
      points={{44,85},{54,85},{54,16},{22,16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pulse.y, IntGains.Q_flow) annotation (Line(
      points={{10.5,89},{16,89},{20,89},{20,90},{20,90},{20,90},{20,85},{30,85}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(heaCap.port, Room_Vol.heatPort) annotation (Line(
      points={{62,16},{22,16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pulse1.y, gain.u) annotation (Line(
      points={{39.5,67},{30,67},{30,54},{46,54},{46,45},{43,45}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gain.y, CO2Sou.m_flow_in) annotation (Line(
      points={{31.5,45},{26,45},{26,56},{23.26,56}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(SinkAir.ports[1], ori.port_b) annotation (Line(
      points={{-78,20},{-62,20}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(Room_Vol.ports[1], CO2Sen_Source.port_b) annotation (Line(
      points={{16.4,8},{-10,8},{-10,56},{-6,56}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(heaFlo.port_b, Room_Vol.heatPort) annotation (Line(
      points={{60,56},{54,56},{54,16},{22,16}},
      color={191,0,0},
      smooth=Smooth.None,
      thickness=0.5));
  connect(System_DP.port_b, Exh_DP.port_b) annotation (Line(
      points={{-80,-37},{-86,-37},{-86,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(System_DP.port_a, Sup_DP.port_a) annotation (Line(
      points={{-66,-37},{-62,-37},{-62,-16},{-56,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Sup_DP.port_b, Room_Vol.ports[2]) annotation (Line(
      points={{-42,-16},{-8,-16},{-8,4},{14.8,4},{14.8,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(combiTabledamper.y[1], product.u2) annotation (Line(
      points={{69.5,-31},{58,-31},{58,-20},{55,-20}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(pulse2.y, gain1.u) annotation (Line(
      points={{-77.4,58},{-63.2,58}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gain1.y, HumSou.m_flow_in) annotation (Line(
      points={{-49.4,58},{-40,58},{-40,60.8},{-35.2,60.8}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(Exh_DP.port_a, CO2Sen_Infilt.port_b) annotation (Line(
      points={{-86,-20},{-86,-10},{-78,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(CO2Sen_Infilt.port_a, senRelHum1.port_b) annotation (Line(
      points={{-66,-10},{-64,-10},{-64,10},{-36,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senRelHum1.port_a, Room_Vol.ports[3]) annotation (Line(
      points={{-24,10},{-20,10},{-20,8},{13.2,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(ori.port_a, senRelHum1.port_b) annotation (Line(
      points={{-50,20},{-42,20},{-42,10},{-36,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Fan_Speed_Nom.y, product.u1) annotation (Line(
      points={{67.3,-11},{58.65,-11},{58.65,-14},{55,-14}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(AHU.port_a2, Exh_DP.port_b) annotation (Line(
      points={{-16.2,-40},{-22,-40},{-22,-54},{-86,-54},{-86,-32}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(AHU.port_b2, Sup_DP.port_a) annotation (Line(
      points={{-16.2,-32},{-62,-32},{-62,-16},{-56,-16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(AHU.port_a1, Sour.ports[1]) annotation (Line(
      points={{4.2,-32.2},{16,-32.2},{16,-66},{28,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Sink.ports[1], AHU.port_b1) annotation (Line(
      points={{40,-78},{10,-78},{10,-40},{4.2,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(product.y, AHU.Speed_u) annotation (Line(
      points={{43.5,-17},{40,-17},{40,-35.9},{3.9,-35.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CO2Sen_Source.port_a, CO2Sou.ports[1]) annotation (Line(
      points={{6,56},{10,56}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(HumSou.ports[1], Room_Vol.ports[4]) annotation (Line(
      points={{-22,56},{-10,56},{-10,8},{11.6,8}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
          preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-12,32},{54,0}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Rectangle(
          extent={{-14,98},{98,78}},
          lineColor={255,0,0},
          lineThickness=0.5),
        Text(
          extent={{66,12},{94,-2}},
          lineColor={150,50,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Heat Transfer"),
        Text(
          extent={{30,10},{44,4}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Room"),
        Rectangle(extent={{-14,76},{52,36}},   lineColor={255,170,85},
          lineThickness=0.5),
        Text(
          extent={{-4,44},{28,38}},
          lineColor={255,170,85},
          textString="CO2 Source"),
        Rectangle(extent={{-96,34},{-16,0}},   lineColor={215,215,42},
          lineThickness=0.5),
        Text(
          extent={{-74,12},{-38,0}},
          lineColor={215,215,42},
          textString="Infiltration"),
        Rectangle(
          extent={{-96,76},{-16,36}},
          lineColor={150,220,150},
          lineThickness=0.5),
        Text(
          extent={{-56,46},{-18,36}},
          lineColor={150,220,150},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Humidity source"),
        Text(
          extent={{100,94},{58,80}},
          lineColor={255,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Heat 
Source"),
        Rectangle(
          extent={{56,76},{98,0}},
          lineColor={150,50,0},
          lineThickness=0.5),
        Text(
          extent={{2,-18},{22,-8}},
          lineColor={21,222,216},
          fontSize=24,
          textString="AHU"),
        Rectangle(extent={{-96,-2},{-38,-56}},  lineColor={0,128,0},
          lineThickness=0.5),
        Text(
          extent={{-84,-66},{-54,-72}},
          lineColor={0,128,0},
          fontSize=22,
          textString="Distribution
system"),
        Rectangle(
          extent={{-34,-2},{34,-56}},
          lineColor={21,222,216},
          lineThickness=0.5),
        Rectangle(extent={{36,-2},{98,-56}},    lineColor={255,85,255},
          lineThickness=0.5),
        Text(
          extent={{52,-38},{84,-56}},
          lineColor={255,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fontSize=20,
          textString="Control system
fan speed"),
        Text(
          extent={{36,-84},{6,-92}},
          lineColor={0,128,0},
          fontSize=18,
          textString="Ambient
conditions"),
        Rectangle(extent={{4,-58},{60,-96}},    lineColor={0,128,0},
          lineThickness=0.5)}),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end Decentral_Doublefan;
