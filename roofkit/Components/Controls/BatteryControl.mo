within RoofKIT.Components.Controls;
model BatteryControl "Controller for battery"

  Modelica.Blocks.Interfaces.RealInput SOC "State of charge" annotation (
      Placement(visible = true,transformation(extent = {{-190, 20}, {-150, 60}}, rotation = 0),
        iconTransformation(extent = {{-202, 22}, {-162, 62}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput P
    "Power charged or discharged from battery" annotation (Placement(
        visible = true,transformation(extent = {{160, -10}, {180, 10}}, rotation = 0), iconTransformation(
          extent = {{160, -10}, {180, 10}}, rotation = 0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(extent = {{-140, 120}, {-120, 140}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(extent = {{122, -10}, {142, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant POff(k = 0) annotation(
    Placement(visible = true, transformation(extent = {{22, -30}, {42, -10}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal toDischarge annotation(
    Placement(visible = true, transformation(extent = {{50, 100}, {70, 120}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal toOn annotation(
    Placement(visible = true, transformation(origin = {-60, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.InitialStep off annotation(
    Placement(visible = true, transformation(origin = {-90, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch disSwi annotation(
    Placement(visible = true, transformation(extent = {{82, 0}, {102, 20}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal discharge annotation(
    Placement(visible = true, transformation(extent = {{80, 100}, {100, 120}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal toHold annotation(
    Placement(visible = true, transformation(extent = {{-10, 100}, {10, 120}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch chaSwi annotation(
    Placement(visible = true, transformation(extent = {{82, -50}, {102, -30}}, rotation = 0)));
  Modelica.StateGraph.Step hold annotation(
    Placement(visible = true, transformation(extent = {{20, 100}, {40, 120}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold = 0.99) annotation(
    Placement(visible = true, transformation(extent = {{-120, 60}, {-100, 80}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-120, -20}, {-100, 0}}, rotation = 0)));
  Modelica.StateGraph.TransitionWithSignal toOff annotation(
    Placement(visible = true, transformation(extent = {{110, 100}, {130, 120}}, rotation = 0)));
  Modelica.StateGraph.StepWithSignal charge annotation(
    Placement(visible = true, transformation(extent = {{-40, 100}, {-20, 120}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput PV_power "Generated PV power" annotation(
    Placement(visible = true, transformation(extent = {{-190, -144}, {-150, -104}}, rotation = 0), iconTransformation(extent = {{-200, -160}, {-160, -120}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput power_cons "Building power consumption" annotation(
    Placement(visible = true, transformation(extent = {{-192, -80}, {-152, -40}}, rotation = 0), iconTransformation(extent = {{-200, -82}, {-160, -42}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-110, -110}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold1(threshold = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-80, -100}, {-60, -80}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold1(threshold = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-80, -140}, {-60, -120}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or1 annotation(
    Placement(visible = true, transformation(origin = {-10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold2(threshold = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-120, 20}, {-100, 40}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold3(threshold = 0.01) annotation(
    Placement(visible = true, transformation(extent = {{-120, -82}, {-100, -62}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold2(threshold = 0.1) annotation(
    Placement(visible = true, transformation(extent = {{-120, -52}, {-100, -32}}, rotation = 0)));
  Modelica.Blocks.Logical.And and1 annotation(
    Placement(visible = true, transformation(origin = {-70, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {30, -60}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or2 annotation(
    Placement(visible = true, transformation(origin = {-10, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Or or3 annotation(
    Placement(visible = true, transformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -1)  annotation(
    Placement(visible = true, transformation(origin = {38, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(toHold.outPort, hold.inPort[1]) annotation(
    Line(points = {{1.5, 110}, {19, 110}, {19, 110}}));
  connect(hold.outPort[1], toDischarge.inPort) annotation(
    Line(points = {{40.5, 110}, {48, 110}, {56, 110}}));
  connect(disSwi.u2, discharge.active) annotation(
    Line(points = {{80, 10}, {80, 10.75}, {70, 10.75}, {70, 49.5}, {90, 49.5}, {90, 99}}, color = {255, 0, 255}));
  connect(toDischarge.outPort, discharge.inPort[1]) annotation(
    Line(points = {{61.5, 110}, {79, 110}, {79, 110}}));
  connect(chaSwi.y, add.u2) annotation(
    Line(points = {{103, -40}, {112, -40}, {112, -6}, {120, -6}}, color = {0, 0, 127}));
  connect(off.outPort[1], toOn.inPort) annotation(
    Line(points = {{-79.5, 110}, {-71.75, 110}, {-64, 110}}));
  connect(toOff.outPort, off.inPort[1]) annotation(
    Line(points = {{121.5, 110}, {132, 110}, {132, 130}, {-110, 130}, {-110, 110}, {-101, 110}}));
  connect(charge.outPort[1], toHold.inPort) annotation(
    Line(points = {{-19.5, 110}, {-4, 110}}));
  connect(discharge.outPort[1], toOff.inPort) annotation(
    Line(points = {{100.5, 110}, {116, 110}}));
  connect(disSwi.y, add.u1) annotation(
    Line(points = {{103, 10}, {112, 10}, {112, 6}, {120, 6}}, color = {0, 0, 127}));
  connect(charge.active, chaSwi.u2) annotation(
    Line(points = {{-30, 99}, {-30, -40}, {80, -40}}, color = {255, 0, 255}));
  connect(toOn.outPort, charge.inPort[1]) annotation(
    Line(points = {{-58.5, 110}, {-41, 110}}));
  connect(POff.y, disSwi.u3) annotation(
    Line(points = {{43, -20}, {62, -20}, {62, 2}, {80, 2}}, color = {0, 0, 127}));
  connect(POff.y, chaSwi.u3) annotation(
    Line(points = {{43, -20}, {62, -20}, {62, -48}, {80, -48}}, color = {0, 0, 127}));
  connect(SOC, greaterEqualThreshold.u) annotation(
    Line(points = {{-170, 40}, {-140, 40}, {-140, 70}, {-122, 70}}, color = {0, 0, 127}));
  connect(SOC, lessEqualThreshold.u) annotation(
    Line(points = {{-122, -10}, {-139.5, -10}, {-139.5, 40}, {-170, 40}}, color = {0, 0, 127}));
  connect(add.y, P) annotation(
    Line(points = {{143, 0}, {170, 0}}, color = {0, 0, 127}));
  connect(add1.u1, PV_power) annotation(
    Line(points = {{-122, -116}, {-146, -116}, {-146, -124}, {-170, -124}}, color = {0, 0, 127}));
  connect(add1.u2, power_cons) annotation(
    Line(points = {{-122, -104}, {-147, -104}, {-147, -102}, {-146, -102}, {-146, -60}, {-172, -60}}, color = {0, 0, 127}));
  connect(add1.y, greaterEqualThreshold1.u) annotation(
    Line(points = {{-99, -110}, {-90.5, -110}, {-90.5, -90}, {-82, -90}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold1.y, toOn.condition) annotation(
    Line(points = {{-59, -90}, {-48, -90}, {-48, 78}, {-60, 78}, {-60, 98}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(add1.y, lessEqualThreshold1.u) annotation(
    Line(points = {{-99, -110}, {-90, -110}, {-90, -130}, {-82, -130}}, color = {0, 0, 127}));
  connect(or1.u1, greaterEqualThreshold.y) annotation(
    Line(points = {{-22, 70}, {-99, 70}}, color = {255, 0, 255}));
  connect(or1.y, toHold.condition) annotation(
    Line(origin = {0, 1},points = {{2, 70}, {0, 70}, {0, 98}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(lessEqualThreshold1.y, or1.u2) annotation(
    Line(points = {{-58, -130}, {-40, -130}, {-40, 62}, {-22, 62}}, color = {255, 0, 255}));
  connect(PV_power, lessEqualThreshold3.u) annotation(
    Line(points = {{-170, -124}, {-136, -124}, {-136, -72}, {-122, -72}}, color = {0, 0, 127}));
  connect(greaterEqualThreshold2.u, power_cons) annotation(
    Line(points = {{-122, -42}, {-136, -42}, {-136, -60}, {-172, -60}}, color = {0, 0, 127}));
  connect(toDischarge.condition, and1.y) annotation(
    Line(points = {{60, 98}, {60, 60}, {10, 60}, {10, -50}, {-58, -50}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(lessEqualThreshold3.y, and1.u2) annotation(
    Line(points = {{-98, -72}, {-94, -72}, {-94, -58}, {-82, -58}}, color = {255, 0, 255}));
  connect(greaterEqualThreshold2.y, and1.u1) annotation(
    Line(points = {{-99, -42}, {-94, -42}, {-94, -50}, {-82, -50}}, color = {255, 0, 255}));
  connect(add2.y, chaSwi.u1) annotation(
    Line(points = {{41, -60}, {54, -60}, {54, -32}, {80, -32}}, color = {0, 0, 127}));
  connect(add2.u1, PV_power) annotation(
    Line(points = {{18, -66}, {12, -66}, {12, -148}, {-158, -148}, {-158, -124}, {-170, -124}}, color = {0, 0, 127}));
  connect(power_cons, add2.u2) annotation(
    Line(points = {{-172, -60}, {-154, -60}, {-154, -28}, {-14, -28}, {-14, -54}, {18, -54}}, color = {0, 0, 127}));
  connect(power_cons, lessEqualThreshold2.u) annotation(
    Line(points = {{-172, -60}, {-147, -60}, {-147, 30}, {-122, 30}}, color = {0, 0, 127}));
  connect(or2.y, toOff.condition) annotation(
    Line(points = {{1, 38}, {46, 38}, {46, 40}, {120, 40}, {120, 98}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(greaterEqualThreshold1.y, or2.u2) annotation(
    Line(points = {{-58, -90}, {-44, -90}, {-44, 30}, {-22, 30}}, color = {255, 0, 255}));
  connect(or3.y, or2.u1) annotation(
    Line(points = {{-59, 30}, {-58, 30}, {-58, 38}, {-22, 38}}, color = {255, 0, 255}));
  connect(lessEqualThreshold2.y, or3.u1) annotation(
    Line(points = {{-99, 30}, {-82, 30}}, color = {255, 0, 255}));
  connect(lessEqualThreshold.y, or3.u2) annotation(
    Line(points = {{-98, -10}, {-92, -10}, {-92, 22}, {-82, 22}}, color = {255, 0, 255}));
  connect(gain.y, disSwi.u1) annotation(
    Line(points = {{50, 18}, {80, 18}}, color = {0, 0, 127}));
  connect(gain.u, power_cons) annotation(
    Line(points = {{26, 18}, {0, 18}, {0, -24}, {-156, -24}, {-156, -42}, {-172, -42}, {-172, -60}}, color = {0, 0, 127}));
  annotation (Documentation(info="<html>
Block for a battery controller. The battery is charged if the PV system is generating more power than it is being consumed by the system. It remains charging until it is full or the PV system does not generate more than what is being consumed.
It discharges provided that it is being consumed and the PV system is not generating power. It remains discharging until it is empty or the PV system begins to generate more power. The controller was adapted for an optimized charging behavior during the whole year. 
</p>
</html>", revisions = "<html>
<ul>
<li>
January 11, 2022, by Nicolas Carbonare:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}}),
                    graphics={Rectangle(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-160, -160}, {160, 162}}),
        Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-78, 64}, {-12, 20}}),
        Polygon(fillPattern = FillPattern.Solid, points = {{-80, 42}, {-104, 54}, {-104, 32}, {-80, 42}}),
        Line(points = {{-104, 44}, {-136, 44}}),            Text(lineColor = {0, 0, 255}, extent = {{-150, 204}, {150, 164}}, textString = "%name"),
        Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{36, 62}, {102, 18}}),
        Line(points = {{14, 42}, {-12, 42}}),
        Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{34, -6}, {100, -50}}),
        Line(points = {{10, -26}, {-50, -26}}),
        Line(points = {{-50, 20}, {-50, -26}}),
        Polygon(fillPattern = FillPattern.Solid, points = {{36, 42}, {12, 54}, {12, 32}, {36, 42}}),
        Polygon(fillPattern = FillPattern.Solid, points = {{34, -28}, {10, -16}, {10, -38}, {34, -28}})}),
    Diagram(coordinateSystem(extent={{-160,-160},{160,160}})));
end BatteryControl;
