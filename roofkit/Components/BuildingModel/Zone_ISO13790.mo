within RoofKIT.Components.BuildingModel;
model Zone_ISO13790
  "Model for thermal zone using RC-network for room according to ISO 13790. Calculation of solar heat gains through four facades. Internal heat gains with input"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  import Buildings;
  import Modelica.Constants;

  parameter Real f_WRG = 0.6
    "Heat recovery efficiency (affects ventilation energy losses)"
      annotation(Evaluate=true, Dialog(tab = "General", group = "Ventilation"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_win = 0.6
    "Coefficient of heat transfer for windows"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Windows"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U_opaque = 0.2
    "Coefficient of heat transfer for opaque walls"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Opaque walls"));
  parameter Modelica.SIunits.Area A_win[4] = {5,5,5,5}
    "Surface area of windows [N,E,S,W]"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Windows"));
  parameter Modelica.SIunits.Area A_opaque = 25 "Surface area of opaque walls"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Opaque walls"));
  parameter Modelica.SIunits.Area A_f = 25 "Heated/cooled net floor area";
  parameter Modelica.SIunits.Area A_m = 2.5 * A_f
    "Effective mass related surface area";          // ISO 13790 Seite 81
  parameter Modelica.SIunits.Area A_t = 4.5 * A_f
    "Total inside surface area of room walls";      // ISO 13790 Seite 35/36
  parameter Modelica.SIunits.Volume V_room = A_f * 2.7 "Volume of room";   // Annahme: Raumhöhe gleich 2,7 m!
  parameter Real f_ms = 1 "Calibration factor for H_tr_ms (mass/surface)"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Calibration factors"));
  parameter Real f_is = 1 "Calibration factor for H_tr_is (surface/air)"
      annotation(Evaluate=true, Dialog(tab = "Transmission", group = "Calibration factors"));
  parameter Modelica.SIunits.HeatCapacity C_mass = 165000 * A_f
    "Internal Heat Capacity of room (room's thermal mass)";      // ISO 13790 Seite 81
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005
      annotation(Evaluate=true, Dialog(tab = "General", group = "Properties of air"));
  parameter Modelica.SIunits.Density rho_air = 1.293
      annotation(Evaluate=true, Dialog(tab = "General", group = "Properties of air"));
  parameter Real[4] win_frame = {0.7,0.7,0.7,0.7} "Frame fraction of windows [N,E,S,W]"
      annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Windows"));
  parameter Real[4] g_factor = {0.75,0.75,0.75,0.75}
    "Energy transmittance of glazings [N,E,S,W]"
      annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Windows"));
  parameter Real shad_fac = 0.3
    "Shading factor when shading is activated; 0...closed, 1...open"
        annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Shading"));
  parameter Modelica.SIunits.Irradiance Irr_shading = 200
    "Threshold for activating shading"
        annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Shading"));
  parameter Modelica.SIunits.Irradiance Hysterese_Irradiance
    "Hysterese für Einstrahlung für Verschattungssteuerung"
    annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Shading"));
  parameter Modelica.SIunits.Angle[4] surfaceTilt = {Constants.pi/2,Constants.pi/2,Constants.pi/2,Constants.pi/2}
    "Tilt angle of surfaces [N,E,S,W]"
      annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Windows"));
  parameter Modelica.SIunits.Angle[4] surfaceAzimut = {Constants.pi,-Constants.pi/2,0,Constants.pi/2}
    "Azimut angle of surfaces [N,E,S,W]"
      annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "Windows"));
  parameter Real groundReflectance = 0.2 "Ground reflectance"
          annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "General"));
  parameter Modelica.SIunits.Angle latitude = Constants.pi/4
    "Latitude of surfaces"
          annotation(Evaluate=true, Dialog(tab = "Solar heat gains", group = "General"));

  BaseClasses.Room_ISO13790 room_ISO13790_1(
    f_WRG=f_WRG,
    U_win=U_win,
    U_opaque=U_opaque,
    A_opaque=A_opaque,
    A_f=A_f,
    A_m=A_m,
    A_t=A_t,
    V_room=V_room,
    f_ms=f_ms,
    f_is=f_is,
    C_mass=C_mass,
    A_win=sum(A_win))
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_air "Heat port to the room air (convective)"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_surf "Heat port to the room surface (radiative)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  RoofKIT.Components.BuildingModel.BaseClasses.Facades facades(
    A_win=A_win,
    win_frame=win_frame,
    g_factor=g_factor,
    surfaceTilt=surfaceTilt,
    surfaceAzimut=surfaceAzimut,
    groundReflectance=groundReflectance,
    latitude=latitude,
    shad_fac=shad_fac,
    Irr_shading=Irr_shading,
    Hysterese_Irradiance=Hysterese_Irradiance)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature T_amb
    annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather bus interface"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealInput Vdot_vent "Ventilation volume flow in m3/h"
    annotation (Placement(transformation(extent={{-128,-52},{-88,-12}})));
  Modelica.Blocks.Interfaces.RealInput Qdot_int "Heat internal loads in W"
    annotation (Placement(transformation(extent={{-128,-84},{-88,-44}})));
equation
  connect(port_air, room_ISO13790_1.port_air) annotation (Line(
      points={{-100,80},{2,80},{2,6}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(port_surf, room_ISO13790_1.port_surf) annotation (Line(
      points={{-100,40},{-4,40},{-4,-2},{2,-2},{2,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(weaBus.TDryBul, T_amb.T)                 annotation (Line(
      points={{0,100},{-79,100},{-79,0},{-70,0}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(T_amb.port, room_ISO13790_1.port_amb)                 annotation (
      Line(
      points={{-48,0},{-47.5,0},{-47.5,6.10623e-16},{-8,6.10623e-16}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(facades.y, room_ISO13790_1.Qdot_sol) annotation (Line(
      points={{29.5,-5.08852e-16},{20.5,-5.08852e-16},{20.5,6.66134e-16},{12.6,
          6.66134e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(facades.weaBus, weaBus) annotation (Line(
      points={{50,0},{82,0},{82,28},{82,28},{82,100},{0,100}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(room_ISO13790_1.Vdot_vent, Vdot_vent) annotation (Line(points={{-8.6,8},
          {-28,8},{-28,-32},{-108,-32}}, color={0,0,127}));
  connect(room_ISO13790_1.Qdot_int, Qdot_int) annotation (Line(points={{12.6,-6},
          {20,-6},{20,-64},{-108,-64}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
        Polygon(
          points={{-100,40},{0,100},{-100,100},{-100,40}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,40},{0,100},{100,100},{100,40}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-8,30},{8,14}},    lineColor={0,0,0}),
        Line(
          points={{0,14},{0,-56}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-10},{18,-4}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-10},{-18,-4}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-56},{-14,-82}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-56},{14,-82}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<p><ul>
<li>June 6, 2013, Dominik Wystrcil:<br/>First implementation</li>
</ul></p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Raummodell nach ISO 13790</font></h4></p>
<p>Einfaches Knotenmodell auf Basis des vorgeschlagenen R-C-Netzwerks aus der DIN EN ISO 13790. Es gibt je einen Luft- und Masseknoten mit einer dazugeh&ouml;rigen Kapazit&auml;t. &Uuml;ber Widerst&auml;nde werden die W&auml;rmeverluste (Transmission durch Fenster+W&auml;nde sowie L&uuml;ftungsverluste) an die Umgebung berechnet. </p>
<p>Die W&auml;rmegewinne durch solare Einstrahlung werden mit einem <a href=\"ISELib.Buildings.BaseClasses.Facades\">Fassadenmodell</a> berechnet. Die internen W&auml;rmegewinne (Personen, elektrische Ger&auml;te, Haustiere) werden durch eine Lasttabelle abgebildet.</p>
<p>F&uuml;r eine ausf&uuml;hrlichere Dokumentation siehe DIN EN ISO 13790.</p>
<p>Unterschied zur ISO 13790: in der ISO ist keine Kapazit&auml;t des Luftknotens vorgesehen. Das macht aber nur einen geringen Unterschied des thermischen Verhaltens aus.</p>
</html>"));
end Zone_ISO13790;
