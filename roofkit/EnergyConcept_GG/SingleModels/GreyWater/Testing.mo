within RoofKIT.EnergyConcept_GG.SingleModels.GreyWater;

model Testing
  Modelica.Blocks.Sources.Constant const(k = 25 + 273.15)  annotation(
    Placement(visible = true, transformation(origin = {-122, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-124, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 25 + 273.15) annotation(
    Placement(visible = true, transformation(origin = {-64, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, hX_Flow2Heat.T_Tank) annotation(
    Line(points = {{-52, 40}, {-18, 40}, {-18, 0}}, color = {0, 0, 127}));
  connect(const.y, hX_Flow2Heat.T_in) annotation(
    Line(points = {{-110, 16}, {-72, 16}, {-72, -4}, {-28, -4}}, color = {0, 0, 127}));
  connect(const1.y, hX_Flow2Heat.mflow) annotation(
    Line(points = {{-112, -18}, {-72, -18}, {-72, -10}, {-28, -10}}, color = {0, 0, 127}));
protected

annotation(Documentation(info = "<html><p>
Test of the model for the greywater heat recovery</html>", revisions = "<html>
<ul>
<li>
January 08, 2022 by Moritz Bühler:<br/>
First implementation.
</li>
</ul>
</html>"));
end Testing;
