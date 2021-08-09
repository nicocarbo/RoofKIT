within RoofKIT.Workshop_Examples.SecondWorkshop_Files_OM;
model HeatPumpSystem "Example for a heat pump system with the ISO 13790 building model"
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;

  package Medium_sin = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Water;
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad( redeclare
      package Medium =                                                                     Medium_sin, Q_flow_nominal = 20000, TAir_nominal = 293.15, TRad_nominal( displayUnit = "K") = 293.15, T_a_nominal( displayUnit = "K") = 313.15, T_b_nominal( displayUnit = "K") = 308.15, T_start = 313.15, dp_nominal = 10,energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 20000 / 4180 / 5) "Radiator" annotation (
    Placement(transformation(extent = {{10, -20}, {-10, 0}})));
  Buildings.Fluid.Sources.Boundary_pT preSou(redeclare package Medium = Medium_sin, nPorts = 1, T = 313.15) "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(transformation(extent = {{-78, -20}, {-58, 0}})));
  Buildings.Fluid.Sources.MassFlowSource_T sou(redeclare package Medium = Medium_sou, T = 283.15, nPorts = 1, use_T_in = false, use_m_flow_in = true) "Fluid source on source side" annotation (
    Placement(transformation(extent = {{68, -138}, {48, -118}})));
  Buildings.Fluid.Sources.Boundary_pT sin(redeclare package Medium = Medium_sou, T = 280.15, nPorts = 1) "Fluid sink on source side" annotation (
    Placement(transformation(extent = {{-78, -138}, {-58, -118}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT_a1(redeclare final package
      Medium =                                                                        Medium_sin, final m_flow_nominal = 1.8, final transferHeat = true, final allowFlowReversal = true) "Temperature at sink inlet" annotation (
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, rotation = 270, origin = {58, -32})));
  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell(f_WRG = 0.5, U_win = 1.3, U_opaque = 0.2, A_win = {30.54, 31.54, 39.46, 31.46}, A_opaque = 963, A_f = 640, V_room = 2176, win_frame = {0.2, 0.2, 0.2, 0.2}, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, Hysterese_Irradiance = 50, C_mass = 165000 * 640, latitude = 0.015882496193148) annotation (
    Placement(transformation(extent = {{52, 88}, {72, 108}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation (
    Placement(transformation(extent = {{140, 120}, {120, 140}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation (
    Placement(transformation(extent = {{-92, 96}, {-72, 116}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation (
    Placement(transformation(extent = {{-90, 62}, {-70, 82}})));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(redeclare package
      Medium1 =                                                                      Medium_sin, redeclare
      package Medium2 =                                                                                                      Medium_sou, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, massDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, T1_start = 281.4, per = per) "Water to Water heat pump" annotation (
    Placement(transformation(extent = {{-26, -120}, {26, -70}})));
  Modelica.Blocks.Sources.IntegerConstant integerMode(k = 1) annotation (
    Placement(transformation(extent = {{-88, -102}, {-62, -76}})));
  parameter Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Trane_Axiom_EXW240 per "Reverse heat pump performance data" annotation (
    Placement(transformation(extent = {{106, -26}, {126, -6}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumHeaPum(redeclare replaceable
      package Medium =                                                                          Medium_sin, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, m_flow_nominal = 1.8, m_flow_start = 1.8, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, y_start = 1) annotation (
    Placement(visible = true, transformation(origin = {58, -62}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
  Modelica.Blocks.Sources.Constant mflowHP(k = 0.7) annotation (
    Placement(visible = true, transformation(extent = {{126, -72}, {106, -52}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetHP(k = 273.15 + 40) annotation (
    Placement(visible = true, transformation(origin = {-74, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(senT_a1.port_b, rad.port_a) annotation (
    Line(points = {{58, -22}, {58, -10}, {10, -10}}, color = {0, 127, 255}));
  connect(rad.port_b, preSou.ports[1]) annotation (
    Line(points = {{-10, -10}, {-58, -10}}, color = {0, 127, 255}));
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (
    Line(points = {{120, 130}, {62, 130}, {62, 108}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation (
    Line(points = {{51.2, 94.8}, {39.6, 94.8}, {39.6, 106}, {-71, 106}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation (
    Line(points = {{51.2, 91.6}, {44, 91.6}, {44, 72}, {-69, 72}}, color = {0, 0, 127}));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation (
    Line(points = {{-2, -2.8}, {-2, 44}, {52, 44}, {52, 102}}, color = {191, 0, 0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation (
    Line(points = {{2, -2.8}, {2, 52}, {48, 52}, {48, 106}, {52, 106}}, color = {191, 0, 0}));
  //  experiment(StopTime=31536000, Interval=3600, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
  connect(sou.ports[1], heaPum.port_a2) annotation (
    Line(points = {{48, -128}, {40, -128}, {40, -110}, {26, -110}}, color = {0, 127, 255}));
  connect(heaPum.port_b2, sin.ports[1]) annotation (
    Line(points = {{-26, -110}, {-46, -110}, {-46, -128}, {-58, -128}}, color = {0, 127, 255}));
  connect(integerMode.y, heaPum.uMod) annotation (
    Line(points = {{-60.7, -89}, {-44, -89}, {-44, -95}, {-28.6, -95}}, color = {255, 127, 0}));
  connect(senT_a1.port_a, pumHeaPum.port_b) annotation (
    Line(points = {{58, -42}, {58, -52}}, color = {0, 127, 255}));
  connect(pumHeaPum.port_a, heaPum.port_b1) annotation (
    Line(points = {{58, -72}, {58, -80}, {26, -80}}, color = {0, 127, 255}));
  connect(heaPum.port_a1, rad.port_b) annotation (
    Line(points = {{-26, -80}, {-46, -80}, {-46, -10}, {-10, -10}}, color = {0, 127, 255}));
  connect(heaPum.TSet, TSetHP.y) annotation (
    Line(points={{-29.64,-72.5},{-38,-72.5},{-38,-46},{-63,-46}},   color = {0, 0, 127}));
  connect(mflowHP.y, pumHeaPum.m_flow_in) annotation (
    Line(points={{105,-62},{70,-62}},      color = {0, 0, 127}));
  connect(mflowHP.y, sou.m_flow_in) annotation (
    Line(points={{105,-62},{70,-62},{70,-120}},        color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-160, -160}, {160, 160}}), graphics={  Rectangle(origin = {22, 90}, fillColor = {170, 170, 127},
            fillPattern =                                                                                                                                                           FillPattern.Solid, extent = {{-126, 66}, {126, -66}}), Text(origin = {-13, 136}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin = {26, -64}, fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{130, -80}, {-130, 80}}), Text(origin = {113, -104}, extent = {{-39, 34}, {39, -34}}, textString = "Wärmepumpe
Heizkörper
Vorlauftemp 50°C
      ")}),
    experiment(StopTime = 7776000, Interval = 3600, Tolerance = 1e-06, __Dymola_Algorithm = "Dassl"),
    Documentation(info = "<html><p>
  Model for testing the model <a href=
  \"modelica://AixLib.Systems.HeatPumpSystems.HeatPumpSystem\">AixLib.Systems.HeatPumpSystems.HeatPumpSystem</a>.
</p>
<p>
  A simple radiator is used to heat a room. This example is based on
  the example in <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Examples.ScrollWaterToWater_OneRoomRadiator\">
  AixLib.Fluid.HeatPumps.Examples.ScrollWaterToWater_OneRoomRadiator</a>.
</p>
</html>",
        revisions = "<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(extent = {{-160, -160}, {160, 160}}), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                 FillPattern.Solid, extent = {{-120, -120}, {120, 120}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-38, 64}, {68, -2}, {-38, -64}, {-38, 64}})}));
end HeatPumpSystem;
