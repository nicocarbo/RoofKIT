within RoofKIT.EnergyConcept_HDU.SingleModels.BuildingModel;
model Sample_BuildingValidation
  import Modelica.SIunits.*;
  import Modelica.Constants.*;
  import Modelica.Math.*;
  parameter Area A_floor(min=0.0) = 580.0;
  parameter Area era(min=0.0) = 640.0 "energy related area in m2";
  parameter Volume V_room(min=0.0) = 2125.0;
  parameter HeatCapacity C_eff(min=0.0) = 165000.0;
  parameter Real acr(min=0.0) = 0.5;
  parameter Efficiency effectivity_heatrecovery(min=0.0, max=1.0) = 0.0;
  parameter CoefficientOfHeatTransfer U_opaque(min=0.0) = 0.2;
  parameter Area A_opaque(min=0.0) = 880.0;
  parameter CoefficientOfHeatTransfer U_window(min=0.0) = 1.3;
  parameter Area A_window_north(min=0.0) = 24.38;
  parameter Area A_window_east(min=0.0) = 25.15;
  parameter Area A_window_south(min=0.0) = 31.50;
  parameter Area A_window_west(min=0.0) = 25.1;
  parameter Real framepart_north(min=0.0, max=1.0) = 0.2;
  parameter Real framepart_east(min=0.0, max=1.0) = 0.2;
  parameter Real framepart_south(min=0.0, max=1.0) = 0.2;
  parameter Real framepart_west(min=0.0, max=1.0) = 0.2;
  parameter SpectralTransmissionFactor g_north(min=0.0, max=1.0) = 0.75;
  parameter SpectralTransmissionFactor g_east(min=0.0, max=1.0) = 0.75;
  parameter SpectralTransmissionFactor g_south(min=0.0, max=1.0) = 0.75;
  parameter SpectralTransmissionFactor g_west(min=0.0, max=1.0) = 0.75;
  parameter Angle slope_north = pi/2;
  parameter Angle slope_east = pi/2;
  parameter Angle slope_south = pi/2;
  parameter Angle slope_west = pi/2;
  parameter Angle azimuth_north = pi;
  parameter Angle azimuth_east = -pi/2;
  parameter Angle azimuth_south = 0;
  parameter Angle azimuth_west = pi/2;
  parameter Real shading_factor(min=0.0, max=1.0) = 0.3;
  parameter Irradiance shading_setpoint(min=0.0) = 200.0;
  parameter Irradiance shading_hysteresis(min=0.0, max=shading_setpoint) = 50.0;
  parameter SpectralReflectionFactor ground_reflactance(min=0.0, max=1.0) = 0.2;
  parameter Angle latitude = pi/4;
  parameter Angle Qflow_internal_base(min=0.0) = 1250.0  "3 W/m2 konstant";
  parameter Angle Qflow_internal_peak(min=0.0) = 1250.0;
  parameter Real f_ms = 1.0;
  parameter Real f_is = 1.0;
  Real cost;
  Real Qflow_heat_target  "W";
  Real Qflow_heat_sim  "W";
  Real Q_heat_target  "kWh";
  Real Q_heat_sim  "kWh";
  Real q_heat_target  "kWh/m2a";
  Real q_heat_sim  "kWh/m2a";

  Modelica.Blocks.Sources.Constant const(k=Qflow_internal_base)
    annotation (Placement(transformation(extent={{-40,-62},{-20,-42}})));
  Modelica.Blocks.Math.Gain gain(k=Qflow_internal_peak)
    annotation (Placement(transformation(extent={{-4,-98},{16,-78}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{28,-84},{48,-64}})));
  Modelica.Blocks.Sources.RealExpression vent(y=acr*V_room)
    annotation (Placement(transformation(extent={{8,-46},{28,-26}})));
protected
  Modelica.Blocks.Sources.CombiTimeTable loads(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=true,
    timeScale=1,
    fileName=ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/BuildingData/sample_building.txt"),
    tableName="tab1",
    columns={4})       annotation (Placement(transformation(extent={{-100,80},{-80,
            100}},rotation=0)));
  Modelica.Blocks.Continuous.Integrator energy_target_J(k=1)
    annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  RoofKIT.Components.BuildingModel.Zone_ISO13790 Building_model(
    V_room=V_room,
    f_ms=f_ms,
    f_is=f_is,
    latitude=latitude,
    A_f=A_floor,
    C_mass=C_eff*A_floor,
    f_WRG=effectivity_heatrecovery,
    U_opaque=U_opaque,
    A_opaque=A_opaque,
    U_win=U_window,
    shad_fac=shading_factor,
    Irr_shading=shading_setpoint,
    Hysterese_Irradiance=shading_hysteresis,
    groundReflectance=ground_reflactance,
    A_win={A_window_north,A_window_east,A_window_south,A_window_west},
    win_frame={framepart_north,framepart_east,framepart_south,framepart_west},
    g_factor={g_north,g_east,g_south,g_west},
    surfaceTilt={slope_north,slope_east,slope_south,slope_west},
    surfaceAzimut={azimuth_north,azimuth_east,azimuth_south,azimuth_west})
    annotation (Placement(transformation(extent={{62,0},{82,20}})));
  Modelica.Blocks.Sources.Pulse        pulse(       period=86400, startTime=0)
    annotation (Placement(transformation(extent={{-40,-98},{-20,-78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{20,8},{40,28}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-8,-30},{-28,-10}})));
  Modelica.Blocks.Continuous.LimPID controller(
    k=1,
    yMax=999999,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI)
    annotation (Placement(transformation(extent={{-60,8},{-40,28}})));
  Modelica.Blocks.Sources.Constant setpoint(k=273.15 + 20.0)
    annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
  Modelica.Blocks.Continuous.Integrator energy_sim_J(k=1)
    annotation (Placement(transformation(extent={{-20,48},{0,68}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/Potsdam-hour.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Continuous.FirstOrder power_sim(T=10)
    annotation (Placement(transformation(extent={{-20,8},{0,28}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh energy_target_kWh
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.UnitConversions.To_kWh energy_sim_kWh
    annotation (Placement(transformation(extent={{20,48},{40,68}})));
  Modelica.Blocks.Math.Gain power_target(k=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
equation
  // Cost function for optimization purposes
  der(cost) = (power_target.y - power_sim.y)^2;

  // Energy balance definitions
  Qflow_heat_target = energy_target_J.u;
  Qflow_heat_sim = energy_sim_J.u;
  Q_heat_target = energy_target_kWh.y;
  Q_heat_sim = energy_sim_kWh.y;
  q_heat_target = Q_heat_target/era;
  q_heat_sim = Q_heat_sim/era;

  connect(prescribedHeatFlow.port, Building_model.port_air)
    annotation (Line(points={{40,18},{62,18}}, color={191,0,0}));
  connect(setpoint.y, controller.u_s)
    annotation (Line(points={{-79,18},{-62,18}},   color={0,0,127}));
  connect(temperatureSensor.T, controller.u_m)
    annotation (Line(points={{-28,-20},{-50,-20},{-50,6}},  color={0,0,127}));
  connect(weaDat.weaBus, Building_model.weaBus) annotation (Line(
      points={{80,90},{72,90},{72,20}},
      color={255,204,51},
      thickness=0.5));
  connect(controller.y, power_sim.u)
    annotation (Line(points={{-39,18},{-22,18}},   color={0,0,127}));
  connect(power_sim.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{1,18},{20,18}},   color={0,0,127}));
  connect(power_sim.y, energy_sim_J.u) annotation (Line(points={{1,18},{10,18},{
          10,38},{-40,38},{-40,58},{-22,58}},  color={0,0,127}));
  connect(energy_target_J.y, energy_target_kWh.u)
    annotation (Line(points={{1,90},{18,90}}, color={0,0,127}));
  connect(energy_sim_J.y, energy_sim_kWh.u)
    annotation (Line(points={{1,58},{18,58}}, color={0,0,127}));
  connect(Building_model.port_air, temperatureSensor.port) annotation (Line(
        points={{62,18},{62,12},{24,12},{24,-20},{-8,-20}}, color={191,0,0}));
  connect(loads.y[1], power_target.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(power_target.y, energy_target_J.u) annotation (Line(points={{-39,90},{
          -22,90}},                   color={0,0,127}));
  connect(pulse.y, gain.u)
    annotation (Line(points={{-19,-88},{-6,-88}}, color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(points={{17,-88},{20,-88},{20,-80},{26,
          -80}}, color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{-19,-52},{20,-52},{20,-68},
          {26,-68}}, color={0,0,127}));
  connect(add.y, Building_model.Qdot_int) annotation (Line(points={{49,-74},{52,
          -74},{52,3.6},{61.2,3.6}}, color={0,0,127}));
  connect(vent.y, Building_model.Vdot_vent) annotation (Line(points={{29,-36},{40,
          -36},{40,6.8},{61.2,6.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=31536000, Interval = 3600, Tolerance = 1e-06));
end Sample_BuildingValidation;
