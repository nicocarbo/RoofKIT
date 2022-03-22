within ;
package RoofKIT "Simulations of RoofKIT project"


annotation (uses(Modelica(version = "3.2.3"), Buildings(version = "8.0.0"), ModelicaServices(version = "3.2.3"), BuildingSystems(version = "2.0.0-beta")),
Documentation(info="<html>
<p>
The <code>RoofKIT</code> library was developed to do the simulations for the Team RoofKIT in the Solar Decathlon Europe 2021/2022 competition. See 
<a href=\"http://roofkit.de/en/\"> 
Homepage </a>. 
</p>
<p>
The library extends other available open source libraries to develop its models (Buildings 8.0.0, BuildingSystems 2.0.0). The base library is the Modelica Standard Library 3.2.3. 
Team RoofKIT wants to thank the developers of these libraries for facilitating models of different systems. The models were developed with educational purposes, for the decathletes to introduce themselves to advanced building simulation. 
</p>
<p>
The library has self-developed components, a database, and the models for the Design Challenge (GG) and House Demonstration Unit (HDU).
</p>
<p>
List of contributors: Nicolas Carbonare, Moritz Bühler. 
</p>
</html>"),
    Icon(graphics = {Bitmap(origin = {-2, -3}, extent = {{-94, -95}, {94, 95}}, fileName = "modelica://RoofKIT/Resources/Images/roofkit_logo.bmp")}),
  Diagram);
end RoofKIT;
