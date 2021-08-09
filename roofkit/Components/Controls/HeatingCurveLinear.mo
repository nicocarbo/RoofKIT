within RoofKIT.Components.Controls;
model HeatingCurveLinear
  //Modelica.SIunits.Temperature T_supply;
  extends Modelica.Blocks.Interfaces.SISO;
parameter Modelica.SIunits.Temperature T_ambient_min = 273.15 - 20;
parameter Modelica.SIunits.Temperature T_ambient_max =  273.15 + 20;
parameter Real T_out_min= 273.15+75;
parameter Real T_out_max= 273.15+110;
//parameter Real m=-0.875;
//parameter Real b=604.66;
Real b1;
Real m1;
Modelica.SIunits.Temperature y_celcius;
equation
  T_out_max = m1 * T_ambient_min + b1;
  T_out_min = m1 * T_ambient_max + b1;
if
  (u < T_ambient_min) then
  y= T_out_max;
y_celcius = y;
elseif  (u >= T_ambient_min and u <=  T_ambient_max) then
y= (m1* u) + b1;
y_celcius = y;
else
    y= T_out_min;
y_celcius = y;
end if;
end HeatingCurveLinear;
