within RoofKIT.Components.BuildingModel.BaseClasses;
model Room_ISO13790
  "Room model using RC-network according to ISO 13790"

  parameter Real f_WRG = 0.6
    "Heat recovery efficiency (affects ventilation energy losses)"
      annotation(Evaluate=true, Dialog(tab = "General", group = "Ventilation"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_win = 0.6
    "Coefficient of heat transfer for windows"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Windows"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_opaque = 0.2
    "Coefficient of heat transfer for opaque walls"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Opaque walls"));
  parameter Modelica.SIunits.Area A_win = 5 "Surface area of windows"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Windows"));
  parameter Modelica.SIunits.Area A_opaque = 25 "Surface area of opaque walls"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Opaque walls"));
  parameter Modelica.SIunits.Area A_f = 25 "Heated/cooled net floor area";
  parameter Modelica.SIunits.Area A_m = 3.5 * A_f
    "Effective mass related surface area";            // ISO 13790 Seite 81
  parameter Modelica.SIunits.Area A_t = 4.5 * A_f
    "Total inside surface area of room walls";        // ISO 13790 Seite 35/36
  parameter Modelica.SIunits.Volume V_room = A_f * 2.5 "Volume of room";     // Annahme: Raumhöhe gleich 2,5 m!
  parameter Real f_ms = 1 "Calibration factor for H_tr_ms (mass/surface)"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Calibration factors"));
  parameter Real f_is = 1 "Calibration factor for H_tr_is (surface/air)"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Calibration factors"));
  parameter Modelica.SIunits.HeatCapacity C_mass = 260000 * A_f
    "Internal Heat Capacity of room (room's thermal mass)";        // ISO 13790 Seite 81
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005
      annotation(Evaluate=true, Dialog(tab = "General", group = "Properties of air"));
  parameter Modelica.SIunits.Density rho_air = 1.293
      annotation(Evaluate=true, Dialog(tab = "General", group = "Properties of air"));
  Modelica.SIunits.Temperature T_air(displayUnit="K");
  Modelica.SIunits.Temperature T_surf;
  Modelica.SIunits.Temperature T_mass;
  Modelica.SIunits.HeatFlowRate Qdot_transm;
  Modelica.SIunits.HeatFlowRate Qdot_transm_win;
  Modelica.SIunits.HeatFlowRate Qdot_transm_opaque;
  Modelica.SIunits.HeatFlowRate Qdot_vent;
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor H_tr_as(G=A_t*3.45*
        f_is)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor H_tr_ms(G=A_m*9.1*
        f_ms)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor H_tr_win(G=A_win*
        U_win)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor H_tr_em(G=1/(1/(
        A_opaque*U_opaque) - 1/H_tr_ms.G))
    annotation (Placement(transformation(extent={{-48,-70},{-28,-50}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_air(C=V_room*rho_air*
        cp_air, T(start=293.15))
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_m(C=C_mass, T(start=
          293.15))
    annotation (Placement(transformation(extent={{-10,-80},{10,-100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Qdot_ia
    annotation (Placement(transformation(extent={{50,50},{30,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Qdot_st
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Qdot_m
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=0.5*Qdot_int)
    annotation (Placement(visible = true, transformation(extent = {{98, 76}, {58, 96}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=(1 - A_m/A_t -
        H_tr_win.G/(9.1*A_t))*(0.5*Qdot_int + Qdot_sol))
    annotation (Placement(transformation(extent={{100,14},{60,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=A_m/A_t*(0.5*
        Qdot_int + Qdot_sol))
    annotation (Placement(transformation(extent={{100,-46},{60,-26}})));
  Modelica.Blocks.Interfaces.RealInput Qdot_sol
    annotation (Placement(transformation(extent={{126,-20},{86,20}})));
  Modelica.Blocks.Interfaces.RealInput Qdot_int
    annotation (Placement(transformation(extent={{126,-80},{86,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_air
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_surf
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection H_vent
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  Modelica.Blocks.Interfaces.RealInput Vdot_vent
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
  Modelica.Blocks.Math.Gain gainVent(k=(1 - f_WRG)*cp_air*rho_air*1/3600)
    annotation (Placement(transformation(extent={{-68,70},{-48,90}})));
protected
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_mass
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));equation
  T_air = C_air.T;
  T_surf = port_surf.T;
  T_mass = C_m.T;
  Qdot_transm = Qdot_transm_win + Qdot_transm_opaque;
  Qdot_transm_win = H_tr_win.port_a.Q_flow;
  Qdot_transm_opaque = H_tr_em.port_a.Q_flow;
  Qdot_vent = H_vent.solid.Q_flow;
  connect(Qdot_ia.port, port_air) annotation (Line(
      points={{30,60},{5.55112e-16,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_air, H_tr_as.port_b) annotation (Line(
      points={{5.55112e-16,60},{1.1119e-15,60},{1.1119e-15,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_air, C_air.port) annotation (Line(
      points={{5.55112e-16,60},{6.10623e-16,60},{6.10623e-16,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_as.port_a, port_surf) annotation (Line(
      points={{-1.12703e-16,20},{5.55112e-16,20},{5.55112e-16,5.55112e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Qdot_st.port, port_surf) annotation (Line(
      points={{30,6.10623e-16},{14,6.10623e-16},{14,5.55112e-16},{5.55112e-16,
          5.55112e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_ms.port_b, port_surf) annotation (Line(
      points={{1.1119e-15,-20},{5.55112e-16,-20},{5.55112e-16,5.55112e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_surf, H_tr_win.port_b) annotation (Line(
      points={{5.55112e-16,5.55112e-16},{-15,5.55112e-16},{-15,6.10623e-16},{
          -30,6.10623e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_win.port_a, port_amb) annotation (Line(
      points={{-50,6.10623e-16},{-66,6.10623e-16},{-66,5.55112e-16},{-100,
          5.55112e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_ms.port_a, port_mass) annotation (Line(
      points={{-1.12703e-16,-40},{5.55112e-16,-40},{5.55112e-16,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(Qdot_m.port, port_mass) annotation (Line(
      points={{30,-60},{5.55112e-16,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(C_m.port, port_mass) annotation (Line(
      points={{6.10623e-16,-80},{5.55112e-16,-80},{5.55112e-16,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_em.port_b, port_mass) annotation (Line(
      points={{-28,-60},{5.55112e-16,-60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_tr_em.port_a, port_amb) annotation (Line(
      points={{-48,-60},{-60,-60},{-60,5.55112e-16},{-100,5.55112e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(realExpression1.y, Qdot_ia.Q_flow) annotation (Line(
      points = {{56, 86}, {54, 86}, {54, 60}, {50, 60}},
      color={0,0,127}));
  connect(realExpression2.y, Qdot_st.Q_flow) annotation (Line(
      points={{58,24},{54,24},{54,6.66134e-16},{50,6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression3.y, Qdot_m.Q_flow) annotation (Line(
      points={{58,-36},{54,-36},{54,-60},{50,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(H_vent.fluid, port_air)     annotation (Line(
      points={{-30,60},{0,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(H_vent.solid, port_amb)     annotation (Line(
      points={{-50,60},{-60,60},{-60,0},{-100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(gainVent.y, H_vent.Gc)
    annotation (Line(points={{-47,80},{-40,80},{-40,70}}, color={0,0,127}));
  connect(gainVent.u, Vdot_vent)
    annotation (Line(points={{-70,80},{-106,80}}, color={0,0,127}));
  connect(port_surf, port_amb) annotation(
    Line(points = {{0, 0}, {-100, 0}}, color = {191, 0, 0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-140,160},{160,120}},
          textString="%name",
          lineColor={0,0,255})}));
end Room_ISO13790;
