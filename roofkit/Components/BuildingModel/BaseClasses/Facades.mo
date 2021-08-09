within RoofKIT.Components.BuildingModel.BaseClasses;
model Facades "Calculations for irradiance on surfaces and energy transmittance through the facades:
 [1] north
 [2] east
 [3] south
 [4] west"
  import Buildings;
  parameter Modelica.SIunits.Area[4] A_win "Brutto area of windows"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Window data"));
  parameter Real[4] win_frame "Frame fraction of windows"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Window data"));
  parameter Real[4] g_factor "Energy transmittance of glazings"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Window data"));
  parameter Real shad_fac
    "Shading factor when shading is activated; 0...closed, 1...open"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Shading"));
  parameter Modelica.SIunits.Irradiance Irr_shading
    "Threshold for activating shading"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Shading"));
  parameter Modelica.SIunits.Irradiance Hysterese_Irradiance
    "Hysterese für Einstrahlung für Verschattungssteuerung"
    annotation(Evaluate=true, Dialog(tab = "General", group = "Shading"));
  parameter Modelica.SIunits.Angle[4] surfaceTilt "Tilt angle of surfaces"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Window directions"));
  parameter Modelica.SIunits.Angle[4] surfaceAzimut "Azimut angle of surfaces"
        annotation(Evaluate=true, Dialog(tab = "General", group = "Window directions"));
  parameter Real groundReflectance = 0.2 "Ground reflectance";
  parameter Modelica.SIunits.Angle latitude "Latitude of surfaces";
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-130,-10},{-110,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{116,-10},{136,10}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil_north(til=surfaceTilt[1], azi=surfaceAzimut[1],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,100},{-70,120}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_north(rho=
        groundReflectance,
    til=surfaceTilt[1],
    azi=surfaceAzimut[1],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,100},{-70,80}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil_east(til=surfaceTilt[2], azi=surfaceAzimut[2],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_east(rho=
        groundReflectance,
    til=surfaceTilt[2],
    azi=surfaceAzimut[2],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,40},{-70,20}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil_south(til=surfaceTilt[3], azi=surfaceAzimut[3],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_south(rho=
        groundReflectance,
    til=surfaceTilt[3],
    azi=surfaceAzimut[3],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,-20},{-70,-40}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil_west(til=surfaceTilt[4], azi=surfaceAzimut[4],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_west(rho=
        groundReflectance,
    til=surfaceTilt[4],
    azi=surfaceAzimut[4],
    lat=latitude)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-100}})));
  Modelica.Blocks.Math.Add Irradiance_north
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Modelica.Blocks.Math.Gain A_win_north(k=A_win[1])
    annotation (Placement(transformation(extent={{-32,90},{-12,110}})));
  Modelica.Blocks.Math.Gain Frame_north(k=1 - win_frame[1])
    annotation (Placement(transformation(extent={{-4,90},{16,110}})));
  Modelica.Blocks.Math.Gain g_north(k=g_factor[1])
    annotation (Placement(transformation(extent={{24,90},{44,110}})));
  Modelica.Blocks.Math.Sum sum1(nin=4)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Math.Add Irradiance_east
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Math.Gain A_win_east(k=A_win[2])
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  Modelica.Blocks.Math.Gain Frame_east(k=1 - win_frame[2])
    annotation (Placement(transformation(extent={{-4,30},{16,50}})));
  Modelica.Blocks.Math.Gain g_east(k=g_factor[2])
    annotation (Placement(transformation(extent={{24,30},{44,50}})));
  Modelica.Blocks.Math.Add Irradiance_south
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Math.Gain A_win_south(k=A_win[3])
    annotation (Placement(transformation(extent={{-32,-30},{-12,-10}})));
  Modelica.Blocks.Math.Gain Frame_south(k=1 - win_frame[3])
    annotation (Placement(transformation(extent={{-4,-30},{16,-10}})));
  Modelica.Blocks.Math.Gain g_south(k=g_factor[3])
    annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
  Modelica.Blocks.Math.Add Irradiance_west
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Modelica.Blocks.Math.Gain A_win_west(k=A_win[4])
    annotation (Placement(transformation(extent={{-32,-90},{-12,-70}})));
  Modelica.Blocks.Math.Gain Frame_west(k=1 - win_frame[4])
    annotation (Placement(transformation(extent={{-4,-90},{16,-70}})));
  Modelica.Blocks.Math.Gain g_west(k=g_factor[4])
    annotation (Placement(transformation(extent={{24,-90},{44,-70}})));
  Modelica.Blocks.Math.Product Shading_north
    annotation (Placement(transformation(extent={{58,90},{78,110}})));
  Modelica.Blocks.Math.Product Shading_east
    annotation (Placement(transformation(extent={{58,30},{78,50}})));
  Modelica.Blocks.Math.Product Shading_south
    annotation (Placement(transformation(extent={{58,-30},{78,-10}})));
  Modelica.Blocks.Math.Product Shading_west
    annotation (Placement(transformation(extent={{58,-90},{78,-70}})));
  Modelica.Blocks.Sources.RealExpression Shading_factor_north(y=
        Irradiance_north.y)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=Irr_shading -
        Hysterese_Irradiance, uHigh=Irr_shading + Hysterese_Irradiance)
    annotation (Placement(transformation(extent={{-32,60},{-12,80}})));
  Modelica.Blocks.Sources.RealExpression Shading_factor_east(y=Irradiance_east.y)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(uLow=Irr_shading -
        Hysterese_Irradiance, uHigh=Irr_shading + Hysterese_Irradiance)
    annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
  Modelica.Blocks.Sources.RealExpression Shading_factor_south(y=
        Irradiance_south.y)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis2(uLow=Irr_shading -
        Hysterese_Irradiance, uHigh=Irr_shading + Hysterese_Irradiance)
    annotation (Placement(transformation(extent={{-32,-60},{-12,-40}})));
  Modelica.Blocks.Sources.RealExpression Shading_factor_west(y=Irradiance_west.y)
    annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis3(uLow=Irr_shading -
        Hysterese_Irradiance, uHigh=Irr_shading + Hysterese_Irradiance)
    annotation (Placement(transformation(extent={{-32,-120},{-12,-100}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{24,60},{44,80}})));
  Modelica.Blocks.Sources.Constant const(k=shad_fac)
    annotation (Placement(transformation(extent={{0,74},{10,84}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{0,56},{10,66}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{24,0},{44,20}})));
  Modelica.Blocks.Sources.Constant const2(k=shad_fac)
    annotation (Placement(transformation(extent={{0,14},{10,24}})));
  Modelica.Blocks.Sources.Constant const3(k=1)
    annotation (Placement(transformation(extent={{0,-4},{10,6}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{24,-60},{44,-40}})));
  Modelica.Blocks.Sources.Constant const4(k=shad_fac)
    annotation (Placement(transformation(extent={{0,-46},{10,-36}})));
  Modelica.Blocks.Sources.Constant const5(k=1)
    annotation (Placement(transformation(extent={{0,-64},{10,-54}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{24,-120},{44,-100}})));
  Modelica.Blocks.Sources.Constant const6(k=shad_fac)
    annotation (Placement(transformation(extent={{0,-106},{10,-96}})));
  Modelica.Blocks.Sources.Constant const7(k=1)
    annotation (Placement(transformation(extent={{0,-124},{10,-114}})));
equation
  connect(Irradiance_north.y, A_win_north.u) annotation (Line(
      points={{-39,100},{-34,100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(A_win_north.y, Frame_north.u) annotation (Line(
      points={{-11,100},{-6,100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Frame_north.y, g_north.u) annotation (Line(
      points={{17,100},{22,100}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil_north.H, Irradiance_north.u1) annotation (Line(
      points={{-69,110},{-66,110},{-66,106},{-62,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTil_north.H, Irradiance_north.u2) annotation (Line(
      points={{-69,90},{-66,90},{-66,94},{-62,94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Irradiance_east.y, A_win_east.u) annotation (Line(
      points={{-39,40},{-34,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(A_win_east.y, Frame_east.u) annotation (Line(
      points={{-11,40},{-6,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Frame_east.y, g_east.u) annotation (Line(
      points={{17,40},{22,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Irradiance_south.y, A_win_south.u) annotation (Line(
      points={{-39,-20},{-34,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(A_win_south.y, Frame_south.u) annotation (Line(
      points={{-11,-20},{-6,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Frame_south.y, g_south.u) annotation (Line(
      points={{17,-20},{22,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Irradiance_west.y, A_win_west.u) annotation (Line(
      points={{-39,-80},{-34,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(A_win_west.y, Frame_west.u) annotation (Line(
      points={{-11,-80},{-6,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Frame_west.y, g_west.u) annotation (Line(
      points={{17,-80},{22,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil_east.H, Irradiance_east.u1) annotation (Line(
      points={{-69,50},{-66,50},{-66,46},{-62,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTil_east.H, Irradiance_east.u2) annotation (Line(
      points={{-69,30},{-66,30},{-66,34},{-62,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil_south.H, Irradiance_south.u1) annotation (Line(
      points={{-69,-10},{-66,-10},{-66,-14},{-62,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTil_south.H, Irradiance_south.u2) annotation (Line(
      points={{-69,-30},{-66,-30},{-66,-26},{-62,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil_west.H, Irradiance_west.u1) annotation (Line(
      points={{-69,-70},{-66,-70},{-66,-74},{-62,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTil_west.H, Irradiance_west.u2) annotation (Line(
      points={{-69,-90},{-66,-90},{-66,-86},{-62,-86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil_north.weaBus, weaBus) annotation (Line(
      points={{-90,110},{-100,110},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDifTil_north.weaBus, weaBus) annotation (Line(
      points={{-90,90},{-100,90},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil_east.weaBus, weaBus) annotation (Line(
      points={{-90,50},{-100,50},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDifTil_east.weaBus, weaBus) annotation (Line(
      points={{-90,30},{-100,30},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil_south.weaBus, weaBus) annotation (Line(
      points={{-90,-10},{-100,-10},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDifTil_south.weaBus, weaBus) annotation (Line(
      points={{-90,-30},{-100,-30},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil_west.weaBus, weaBus) annotation (Line(
      points={{-90,-70},{-100,-70},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDifTil_west.weaBus, weaBus) annotation (Line(
      points={{-90,-90},{-100,-90},{-100,5.55112e-16},{-120,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(g_north.y, Shading_north.u1) annotation (Line(
      points={{45,100},{50,100},{50,106},{56,106}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(g_east.y, Shading_east.u1) annotation (Line(
      points={{45,40},{50,40},{50,46},{56,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(g_south.y, Shading_south.u1) annotation (Line(
      points={{45,-20},{50,-20},{50,-14},{56,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(g_west.y, Shading_west.u1) annotation (Line(
      points={{45,-80},{50,-80},{50,-74},{56,-74}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_north.y, sum1.u[1]) annotation (Line(
      points={{79,100},{84,100},{84,-1.5},{88,-1.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_east.y, sum1.u[2]) annotation (Line(
      points={{79,40},{84,40},{84,-0.5},{88,-0.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_south.y, sum1.u[3]) annotation (Line(
      points={{79,-20},{84,-20},{84,0.5},{88,0.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_west.y, sum1.u[4]) annotation (Line(
      points={{79,-80},{84,-80},{84,1.5},{88,1.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_factor_north.y, hysteresis.u) annotation (Line(
      points={{-39,70},{-34,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_factor_east.y, hysteresis1.u) annotation (Line(
      points={{-39,10},{-34,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_factor_south.y, hysteresis2.u) annotation (Line(
      points={{-39,-50},{-34,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Shading_factor_west.y, hysteresis3.u) annotation (Line(
      points={{-39,-110},{-34,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sum1.y, y) annotation (Line(
      points={{111,6.10623e-16},{115.5,6.10623e-16},{115.5,5.55112e-16},{126,
          5.55112e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.u2, hysteresis.y) annotation (Line(
      points={{22,70},{-11,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const.y, switch1.u1) annotation (Line(
      points={{10.5,79},{16.25,79},{16.25,78},{22,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const1.y, switch1.u3) annotation (Line(
      points={{10.5,61},{15.25,61},{15.25,62},{22,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch1.y, Shading_north.u2) annotation (Line(
      points={{45,70},{50,70},{50,94},{56,94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const2.y, switch2.u1) annotation (Line(
      points={{10.5,19},{16.25,19},{16.25,18},{22,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const3.y, switch2.u3) annotation (Line(
      points={{10.5,1},{15.25,1},{15.25,2},{22,2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch2.y, Shading_east.u2) annotation (Line(
      points={{45,10},{50,10},{50,34},{56,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch2.u2, hysteresis1.y) annotation (Line(
      points={{22,10},{-11,10}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const4.y, switch3.u1) annotation (Line(
      points={{10.5,-41},{16.25,-41},{16.25,-42},{22,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const5.y, switch3.u3) annotation (Line(
      points={{10.5,-59},{15.25,-59},{15.25,-58},{22,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch3.y, Shading_south.u2) annotation (Line(
      points={{45,-50},{50,-50},{50,-26},{56,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch3.u2, hysteresis2.y) annotation (Line(
      points={{22,-50},{-11,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const6.y, switch4.u1) annotation (Line(
      points={{10.5,-101},{12.25,-101},{12.25,-102},{22,-102}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const7.y, switch4.u3) annotation (Line(
      points={{10.5,-119},{15.25,-119},{15.25,-118},{22,-118}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(switch4.y, Shading_west.u2) annotation (Line(
      points={{45,-110},{50,-110},{50,-86},{56,-86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(hysteresis3.y, switch4.u2) annotation (Line(
      points={{-11,-110},{22,-110}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-120,
            -120},{120,120}})),  Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-120,-120},{120,120}}),
                                      graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Text(
          extent={{-140,160},{160,120}},
          textString="%name",
          lineColor={0,0,255})}));
end Facades;
