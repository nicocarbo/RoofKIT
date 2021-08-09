within RoofKIT.Components.Solar.Thermal.BaseClasses;
model ISO9806_simple
  "Dynamic energy balance of the thermal collector from ISO 9806 - simplified"
  //Extensions
  extends Modelica.Blocks.Icons.Block;
  //Parameters
  //=========HEAT LOSS PARAMETERS==================================
  parameter Modelica.SIunits.Area A_G "Area of the collector";
  parameter Modelica.SIunits.Efficiency Eta_zero "Maximum efficiency";
  parameter Real c1(unit = "W/(m2.K)") "c1 from ratings data";
  parameter Real c2(unit = "W/(m2.K2)") "c2 from ratings data";
  //HeatLoss_Wind2 losses parameters and variables
  //Heating losses parameters and variables
  parameter Real capColl( unit = "J/K")
    "Effective heat capacity of collector";
  //Long wave irradiation balance parameters and variables
  //=========HEAT GAIN PARAMETERS====================================
  parameter Real B0 "1st incident angle modifer coefficient";
  parameter Real iamDiff "Incidence angle modifier for diffuse radiation";
  //==============END OF PARAMETERS===================================
  //Variables and constants
  //==========HEAT LOSS VARIABLES and CONSTANTS==================================
  Modelica.SIunits.Power QLos1 "First order heat losses";
  Modelica.SIunits.Power QLos2 "Second order heat losses";
  Modelica.SIunits.Power QLos_capacity "Heating losses";
  Real DT "Temperature difference between fluid and ambient";
  //Long wave irradiance
  //============HEAT GAIN VARIABLES==============================
  Real iamBea "Incidence angle modifier for director solar radiation";
  Modelica.SIunits.Power Qsolargain "Solar Heat Gain";
  //==============END OF VARIABLES===================================
  //==============INPUTS AND OUTPUT OF THE BLOCK======================
   Modelica.Blocks.Interfaces.RealInput Tin
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));

   Modelica.Blocks.Interfaces.RealInput Gd(
    unit="W/m2", quantity="RadiantEnergyFluenceRate")
    "Diffuse solar irradiation on a tilted surfce from the sky"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}}), iconTransformation(extent={{-140,
            -40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput theta(
    quantity="Angle",
    unit="rad",
    displayUnit="degree")
    "Incidence angle of the sun beam on a tilted surface"
    annotation (Placement(transformation(extent={{-138,-92},{-98,-52}}),iconTransformation(extent={{-138,
            -92},{-98,-52}})));
  Modelica.Blocks.Interfaces.RealInput Gb(
    unit="W/m2", quantity="RadiantEnergyFluenceRate")
    "Direct solar irradiation on a tilted surfce"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}}),iconTransformation(extent={{-140,10},
            {-100,50}})));

  Modelica.Blocks.Interfaces.RealInput T_a
    "Temperature of surrounding environment"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
public
  Modelica.Blocks.Interfaces.RealInput Tout
    "Temperature of the heat transfer fluid"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput Quseful(
    quantity="HeatFlowRate",
    unit="W",
    displayUnit="W") "Useful heat flow"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput derTm(unit="K/s", displayUnit="K/s")
    "derivation of mean fluid temperature"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput Tm(unit="K", displayUnit="K")
    "mean fluid temperature"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Math.Add Tm_calc(k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Continuous.Derivative derivative(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
equation
  // Code to generate the incident beam modifier
  iamBea = Buildings.Utilities.Math.Functions.smoothHeaviside(x=Modelica.Constants.pi
    *0.50 - theta, delta=Modelica.Constants.pi/60)*
    RoofKIT.Components.Solar.Thermal.BaseClasses.IAM(theta, B0);
  // Code to calculate the heat gain
    Qsolargain = A_G*(Eta_zero*(iamBea*Gb + iamDiff*Gd));
  // Code to calculate the heat losses, Maximum fluid temperature assuemd to be 200
      DT = ((Tout+Tin)*0.5 -T_a)
    "Calculating the mean temperature difference";
    QLos1=A_G*(c1*DT) "First order losses";
    QLos2=A_G*(c2*DT^2) "First order losses";
  //Calculating long wave irradiance (source: ISO 9806 eq:5)
    QLos_capacity=(capColl* der(Tm)) "thermal capacitance losses";
    Quseful = Qsolargain-(QLos1 + QLos2 + QLos_capacity);
  connect(Tin, Tm_calc.u2) annotation (Line(points={{-40,120},{-40,120},{-40,64},
          {18,64}}, color={0,0,127}));
  connect(Tout, Tm_calc.u1) annotation (Line(points={{0,120},{0,120},{0,76},{18,
          76}}, color={0,0,127}));
  connect(Tm_calc.y, Tm)
    annotation (Line(points={{41,70},{72,70},{110,70}}, color={0,0,127}));
  connect(Tm_calc.y, derivative.u) annotation (Line(points={{41,70},{50,70},{50,
          30},{58,30}}, color={0,0,127}));
  connect(derivative.y, derTm)
    annotation (Line(points={{81,30},{110,30}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
                   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end ISO9806_simple;
