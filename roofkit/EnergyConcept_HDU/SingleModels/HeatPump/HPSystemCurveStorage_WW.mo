within RoofKIT.EnergyConcept_HDU.SingleModels.HeatPump;
model HPSystemCurveStorage_WW
  "Example for a heat pump system with heating curve and a heat storage"
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;

  package Medium_sin = Buildings.Media.Water;
  package Medium_sou = Buildings.Media.Water;
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(redeclare
      package                                                                    Medium = Medium_sin, Q_flow_nominal = 8000, TAir_nominal = 293.15, TRad_nominal(displayUnit = "K") = 293.15, T_a_nominal(displayUnit = "K") = 308.15, T_b_nominal(displayUnit = "K") = 298.15, T_start = 313.15, dp_nominal = 10, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = 8000 / 4180 / 5) "Radiator" annotation (
    Placement(transformation(extent = {{-150, 120}, {-170, 100}})));
  Buildings.Fluid.Sources.Boundary_pT preSou(redeclare package Medium = Medium_sin, T = 313.15, nPorts=1)   "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(transformation(extent = {{-100, 128}, {-80, 148}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus" annotation (
    Placement(visible = true,transformation(extent = {{148, 32}, {168, 52}}, rotation = 0), iconTransformation(extent = {{148, 50}, {168, 70}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senT_a1(redeclare final package
      Medium =  Medium_sin, final m_flow_nominal = 1, final transferHeat = true, final allowFlowReversal = true) "Temperature at sink inlet" annotation (
    Placement(transformation(extent = {{10, 10}, {-10, -10}}, origin = {-132, 110})));
  Components.BuildingModel.Zone_ISO13790 Gebaeude_modell( A_f = 640, A_opaque = 963, A_win = {30.54, 31.54, 39.46, 31.46}, C_mass = 165000 * 640, Hysterese_Irradiance = 50, U_opaque = 0.2, U_win = 1.3, V_room = 2176,f_WRG = 0.5, latitude( displayUnit = "rad") = 0.015882496193148, surfaceAzimut = {pi, -pi / 2, 0, pi / 2}, win_frame = {0.2, 0.2, 0.2, 0.2}) annotation (
    Placement(transformation(extent = {{106, 114}, {126, 134}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) "Weather data reader" annotation (
    Placement(transformation(extent = {{182, 134}, {162, 154}})));
  Modelica.Blocks.Sources.Constant Vdot_vent(k = 1088) annotation (
    Placement(transformation(extent = {{-50, 126}, {-30, 146}})));
  Modelica.Blocks.Sources.Pulse Qdot_int(amplitude = 650, width = 50, period = 86400, offset = 650) annotation (
    Placement(transformation(extent = {{22, 108}, {42, 128}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature storageRoomTemp(T = 288.15) annotation (
    Placement(transformation(extent = {{-172, -14}, {-152, 6}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan1(
    redeclare package Medium = Medium_sin,                                                 m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(transformation(extent = {{-92, 120}, {-112, 100}})));
  Buildings.Controls.Continuous.LimPID conPI(Ti = 10, controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.2, yMax = 5, yMin = 0) annotation (
    Placement(visible = true, transformation(origin = {-134, 54}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant TSetP(k = 273.15 + 40) annotation (
    Placement(visible = true, transformation(extent = {{-88, 44}, {-108, 64}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT preSou1(redeclare package Medium = Medium_sin, T = 313.15, nPorts = 1) "Source for pressure and to account for thermal expansion of water" annotation (
    Placement(visible = true, transformation(extent = {{110, 32}, {90, 52}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow fan2(
    redeclare package Medium = Medium_sin,                                                 m_flow_nominal = 1.5, addPowerToMedium = false, dp_nominal = 100) annotation (
    Placement(visible = true, transformation(extent = {{64, 24}, {44, 44}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mflow_pump1(k = 0.4) annotation (
    Placement(visible = true, transformation(origin = {-42, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  BuildingSystems.Technologies.ThermalStorages.FluidStorage storage(
    redeclare package Medium = Medium_sin,
    redeclare package Medium_HX_1 = Medium_sin,
    redeclare package Medium_HX_2 = Medium_sin,
    height=1.5,
    V=3.1,
    nEle=5,
    HX_1=false,
    Ele_HX_2=4)
    annotation (Placement(transformation(extent={{-120,-16},{-86,14}})));
  Buildings.Fluid.HeatPumps.EquationFitReversible heaPum(
    redeclare package Medium1 = Medium_sin,
    redeclare package Medium2 = Medium_sou,
    T1_start=281.4,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    per=perHP) "Water to Water heat pump"
    annotation (Placement(visible = true, transformation(extent = {{40, -72}, {92, -22}}, rotation = 0)));
  parameter
    RoofKIT.Database.HeatPump.HeatPump_RoofKIT_WW perHP
    "Reverse heat pump performance data"
    annotation (Placement(visible = true, transformation(extent = {{162, -16}, {182, 4}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerConstant integerMode(k=1)   annotation (
    Placement(visible = true, transformation(extent = {{-54, -60}, {-40, -46}}, rotation = 0)));
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium_sou,
    T=280.15,
    nPorts=1)                                                                                            "Fluid sink on source side" annotation (
    Placement(visible = true, transformation(extent = {{-34, -96}, {-14, -76}}, rotation = 0)));
  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium_sou, T = 283.15,
    nPorts=1, use_T_in = false,
    use_m_flow_in=true)                                                                                                                               "Fluid source on source side" annotation (
    Placement(visible = true, transformation(extent = {{140, -70}, {120, -50}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant mflowHP(k= 0.4)   annotation (
    Placement(visible = true, transformation(extent={{178, -62},{158, -42}},      rotation = 0)));
  Buildings.Controls.SetPoints.SupplyReturnTemperatureReset watRes(
    TOut_nominal(displayUnit = "K") = 265.15,
    TRet_nominal(displayUnit = "K") = 308.15, TRoo( displayUnit = "K") = 294.15,
    TRoo_nominal(displayUnit = "K") = 294.15,
    TSup_nominal(displayUnit = "K") = 313.15, dTOutHeaBal = 6, m = 1.2,
    use_TRoo_in= false)
    annotation (Placement(visible = true, transformation(extent = {{-32, -20}, {-12, 0}}, rotation = 0)));

  Buildings.Controls.OBC.CDL.Continuous.MovingMean movMea(delta = 3600 * 12)  annotation (
    Placement(visible = true, transformation(origin = {12, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureTwoPort(redeclare
      final package
      Medium =  Medium_sin, allowFlowReversal = true, m_flow_nominal = 1, transferHeat = true) annotation (
    Placement(visible = true, transformation(origin = {108, -4}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.To_kWh energy_sim_kWh annotation (
    Placement(visible = true, transformation(extent = {{166, -106}, {186, -86}}, rotation = 0)));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{106,86},{126,106}})));
  Modelica.Blocks.Continuous.Integrator energy_HP(k = 1) annotation (
    Placement(visible = true, transformation(extent = {{132, -106}, {152, -86}}, rotation = 0)));
equation
  connect(weaDat1.weaBus, Gebaeude_modell.weaBus) annotation (
    Line(points = {{162, 144}, {116, 144}, {116, 134}}, color = {255, 204, 51}, thickness = 0.5));
  connect(Gebaeude_modell.Vdot_vent, Vdot_vent.y) annotation (
    Line(points = {{105.2, 120.8}, {81.6, 120.8}, {81.6, 136}, {-29, 136}}, color = {0, 0, 127}));
  connect(Gebaeude_modell.Qdot_int, Qdot_int.y) annotation (
    Line(points = {{105.2, 117.6}, {86, 117.6}, {86, 118}, {43, 118}}, color = {0, 0, 127}));
  connect(weaBus, weaDat1.weaBus) annotation (
    Line(points = {{158, 42}, {158, 90}, {162, 90}, {162, 144}}, color = {255, 204, 51}, thickness = 0.5));
  connect(rad.heatPortRad, Gebaeude_modell.port_surf) annotation (
    Line(points = {{-162, 102.8}, {-162, 82}, {88, 82}, {88, 128}, {106, 128}}, color = {191, 0, 0}));
  connect(rad.heatPortCon, Gebaeude_modell.port_air) annotation (
    Line(points = {{-158, 102.8}, {-158, 86}, {84, 86}, {84, 132}, {106, 132}}, color = {191, 0, 0}));
  connect(senT_a1.port_b, rad.port_a) annotation (
    Line(points = {{-142, 110}, {-150, 110}}, color = {0, 127, 255}));
  connect(fan1.port_b, senT_a1.port_a) annotation (
    Line(points = {{-112, 110}, {-122, 110}}, color = {0, 127, 255}));
  connect(conPI.u_s, TSetP.y) annotation (
    Line(points = {{-122, 54}, {-109, 54}}, color = {0, 0, 127}));
  connect(senT_a1.T, conPI.u_m) annotation (
    Line(points = {{-132, 99}, {-132, 72}, {-134, 72}, {-134, 66}}, color = {0, 0, 127}));
  connect(conPI.y, fan1.m_flow_in) annotation (
    Line(points = {{-145, 54}, {-152, 54}, {-152, 76}, {-102, 76}, {-102, 98}}, color = {0, 0, 127}));
  connect(preSou.ports[1], fan1.port_a) annotation (
    Line(points = {{-80, 138}, {-72, 138}, {-72, 110}, {-92, 110}}, color = {0, 127, 255}));
  connect(mflow_pump1.y, fan2.m_flow_in) annotation (
    Line(points = {{-31, 56}, {54, 56}, {54, 46}}, color = {0, 0, 127}));
  connect(preSou1.ports[1], fan2.port_a) annotation (
    Line(points = {{90, 42}, {72, 42}, {72, 34}, {64, 34}}, color = {0, 127, 255}));
  connect(fan2.port_b, storage.port_a2) annotation (
    Line(points = {{44, 34}, {-52, 34}, {-52, 12.5}, {-91.1, 12.5}}, color = {0, 127, 255}));
  connect(fan1.port_a, storage.port_HX_2_b) annotation (
    Line(points = {{-92, 110}, {-72, 110}, {-72, 3.5}, {-91.1, 3.5}}, color = {0, 127, 255}));
  connect(rad.port_b, storage.port_HX_2_a) annotation (
    Line(points = {{-170, 110}, {-182, 110}, {-182, 34}, {-84, 34}, {-84, 6.5}, {-91.1, 6.5}}, color = {0, 127, 255}));
  connect(storage.heatPort, storageRoomTemp.port) annotation (
    Line(points = {{-103, 14.6}, {-140, 14.6}, {-140, -4}, {-152, -4}}, color = {191, 0, 0}));
  connect(integerMode.y, heaPum.uMod) annotation (
    Line(points = {{-39.3, -53}, {4.65, -53}, {4.65, -47}, {37, -47}}, color = {255, 127, 0}));
  connect(storage.port_b2, heaPum.port_a1) annotation (
    Line(points = {{-91.1, -14.5}, {-74, -14.5}, {-74, -32}, {40, -32}}, color = {0, 127, 255}));
  connect(sou.ports[1], heaPum.port_a2) annotation (
    Line(points = {{120, -60}, {93, -60}, {93, -62}, {92, -62}}, color = {0, 127, 255}));
  connect(mflowHP.y, sou.m_flow_in) annotation (
    Line(points = {{157, -52}, {142, -52}}, color = {0, 0, 127}));
  connect(sin.ports[1], heaPum.port_b2) annotation (
    Line(points = {{-14, -86}, {12, -86}, {12, -62}, {40, -62}}, color = {0, 127, 255}));
  connect(watRes.TOut, weaBus.TDryBul) annotation (
    Line(points = {{-34, -4}, {-38, -4}, {-38, 14}, {158, 14}, {158, 42}}, color = {0, 0, 127}));
  connect(temperatureSensor.port, Gebaeude_modell.port_air) annotation (
    Line(points = {{106, 96}, {98, 96}, {98, 132}, {106, 132}}, color = {191, 0, 0}));
  connect(heaPum.TSet, movMea.y) annotation (
    Line(points = {{36.36, -24.5}, {24.36, -24.5}, {24.36, -8.5}}, color = {0, 0, 127}));
  connect(watRes.TSup, movMea.u) annotation (
    Line(points = {{-11, -4}, {-1, -4}, {-1, -8}}, color = {0, 0, 127}));
  connect(heaPum.port_b1, temperatureTwoPort.port_a) annotation (
    Line(points = {{92, -32}, {138, -32}, {138, -4}, {118, -4}}, color = {0, 127, 255}));
  connect(temperatureTwoPort.port_b, fan2.port_a) annotation (
    Line(points = {{98, -4}, {64, -4}, {64, 34}}, color = {0, 127, 255}));
  connect(heaPum.P, energy_HP.u) annotation (
    Line(points = {{94, -48}, {112, -48}, {112, -96}, {130, -96}}, color = {0, 0, 127}));
  connect(energy_HP.y, energy_sim_kWh.u) annotation (
    Line(points = {{154, -96}, {164, -96}}, color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -170}, {200, 170}}), graphics={  Rectangle(origin = {67, 120}, fillColor = {170, 170, 127},
            fillPattern =                                                                                                                                                            FillPattern.Solid, extent = {{-127, 42}, {127, -42}}), Text(origin = {33, 150}, extent = {{-53, 22}, {53, -22}}, textString = "Gebäude und Wetter"), Rectangle(origin={68,
              -41},                                                                                                                                                                                                        fillColor = {255, 147, 147},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent={{
              128,-115},{-128,115}}),                                                                                                                                                                                                        Text(origin={-11,-136},                                                                                                                                                                                                        extent = {{-39, 34}, {39, -34}}, textString = "Wärmepumpe
      "),
        Rectangle(origin = {-129, -9}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{65, -35}, {-65, 35}}),                                                                                                 Text(origin = {-154, -33}, extent = {{-36, 15}, {36, -15}}, textString = "Wärmespeicher"), Rectangle(origin = {-129, 96}, fillColor = {255, 213, 170},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, extent = {{65, -66}, {-65, 66}}), Text(origin = {-154, 141}, extent = {{-36, 15}, {36, -15}}, textString = "Heizkörper
Vorlauftemp 40°C")}),
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
    Icon(coordinateSystem(extent = {{-200, -170}, {200, 170}}, preserveAspectRatio = false), graphics={  Ellipse(lineColor = {75, 138, 73}, fillColor = {255, 255, 255},
            fillPattern =                                                                                                                                                              FillPattern.Solid, extent = {{-120, -120}, {120, 120}}, endAngle = 360), Polygon(lineColor = {0, 0, 255}, fillColor = {75, 138, 73}, pattern = LinePattern.None,
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, points = {{-38, 64}, {68, -2}, {-38, -64}, {-38, 64}})}));
end HPSystemCurveStorage_WW;
