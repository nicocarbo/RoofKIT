within RoofKIT.EnergyConcept_GG.SingleModels.GreyWater;

model HX_Flow2Heat
  Modelica.Blocks.Sources.RealExpression T_log(y = ((WW_T_in.y-WW_T_Tank.y)-(WW_T_out.y-WW_T_Tank.y))/(log((WW_T_in.y-WW_T_Tank.y)/(WW_T_out.y-WW_T_Tank.y))))  annotation(
    Placement(visible = true, transformation(origin = {23, 45}, extent = {{-97, -11}, {97, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_T_in(y = 18 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-106, 45}, extent = {{-20, -9}, {20, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_mflow(y = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-106, 29}, extent = {{-20, -9}, {20, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_T_Tank(y = 20 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-106, 11}, extent = {{-20, -9}, {20, 9}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_T_out(y = WW_T_in.y - WW_Heatflow.y/WW_mflow.y/4200) annotation(
    Placement(visible = true, transformation(origin = {23, 27}, extent = {{-97, -11}, {97, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression WW_Heatflow(y = HX_WW_U.y * HX_WW_A.y * T_log.y) annotation(
    Placement(visible = true, transformation(origin = {23, 11}, extent = {{-97, -11}, {97, 11}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HX_WW_U(k = 200)  annotation(
    Placement(visible = true, transformation(origin = {-117, -5}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant HX_WW_A(k = 2) annotation(
    Placement(visible = true, transformation(origin = {-117, -25}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
equation

annotation(Documentation(info = "<html><p>
Model for the greywater heat recovery</html>", revisions = "<html>
<ul>
<li>
January 08, 2022 by Moritz Bühler:<br/>
First implementation. Parametrization of model incomplete. Documentation incomplete. 
</li>
</ul>
</html>"));
end HX_Flow2Heat;
