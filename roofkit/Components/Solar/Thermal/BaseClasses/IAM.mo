within RoofKIT.Components.Solar.Thermal.BaseClasses;
function IAM "Incident angle modifier for beam irradiation"
  extends Modelica.Icons.Function;
  // based on equation (50) in ISO9806:2013??? literature Solar energy  Solar thermal
  //collectors  Test methods
  //input
  input Modelica.SIunits.Angle theta "Incident angle";
  input Real B0
    "Constant for the calculation of the incident angle modifier";
  //output
  output Real IAMbeam "Incident angle modifier for beam irradiation";
   //Variables
protected
   constant Real delta = 0.0001 "Width of the smoothing function";
   constant Modelica.SIunits.Angle thetaMin = Modelica.Constants.pi / 2 -0.1
    "Minimum incidence angle to avoid divison by zero";
algorithm
  IAMbeam :=Buildings.Utilities.Math.Functions.smoothHeaviside(
  Modelica.Constants.pi*0.50-theta, delta)*(1 - B0*(1/Buildings.Utilities.Math.Functions.smoothMax(
  Modelica.Math.cos(theta), Modelica.Math.cos(thetaMin), delta) - 1));
end IAM;
