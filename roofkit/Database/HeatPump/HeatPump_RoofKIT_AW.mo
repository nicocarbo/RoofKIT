within RoofKIT.Database.HeatPump;
record HeatPump_RoofKIT_AW =
 Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic (
    dpHeaSou_nominal = 530,
    dpHeaLoa_nominal = 460,
    hea(
      TRefLoa = 30 + 273.15,
      TRefSou = -7 + 273.15,
      Q_flow = 6180.00,
      P = 2000,
      mSou_flow = 0.3,
      mLoa_flow = 0.3,
      coeQ = {0.9381,-0.4028,-7.6028,0.00,0.00},
      coeP = {0.1074,4.6257,-11.1843,0.00,0.00}),
    coo(
      TRefSou = 28 + 273.15,
      TRefLoa =  12 + 273.15,
      Q_flow = -5560.00,
      P = 1424.44,
      coeQ = {-5.79235417,9.83800467,-3.19795605,0.0,0.0},
      coeP = {-6.37109639,1.27560526,5.81780490,0.0,0.0}))
  "First selected heat pump"
annotation (
  defaultComponentName="per",
  defaultComponentPrefixes="parameter",
  Documentation(info =   "<html>
  <p>
Performance data for reverse heat pump model.
This data corresponds to the following
<a href=\"https://www.trane.com/content/dam/Trane/Commercial/global/products-systems/equipment/unitary/water-source-heat-pumps/water-to-water-wshp/WSHP-PRC022E-EN_08152017.pdf\">https://www.trane.com/wshp.pdf</a>
catalog data.
</p>
<pre>
    Trane EXW 70kW/4.11COP,  !- Name
    77000,                   !- Reference Heating Capacity {W}
    55680,                   !- Reference Cooling Capacity {W}
    4.10,                    !- Reference COP {W/W}
    13.5,                    !- Refrence EER{BTUh/W}
    0.0018,                  !- Reference Evaporator Water Flow Rate {m3/s}
    0.0018,                  !- Reference Condenser Water Flow Rate {m3/s}
</pre>
</html>",
revisions="<html>
<ul>
<li>
September 16, 2019 by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 19, 2019 by Hagar Elarga:<br/>
First implementation.
</li>
</ul>
</html>"));
