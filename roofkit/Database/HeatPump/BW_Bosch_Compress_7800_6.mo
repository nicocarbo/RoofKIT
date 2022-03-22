within RoofKIT.Database.HeatPump;
record BW_Bosch_Compress_7800_6 = Buildings.Fluid.HeatPumps.Data.EquationFitReversible.Generic(
dpHeaSou_nominal = 530, 
dpHeaLoa_nominal = 460, 
hea(TRefLoa = 30 + 273.15, 
	TRefSou = 0 + 273.15, 
	Q_flow = 5850.00, 
	P = 1270, 
	mSou_flow = 1000 / 3600, 
	mLoa_flow = 1040 / 3600, 
	coeQ = {-4.31, -2.8, 8.17, 0.00, 0.00}, 
	coeP = {-8.66, 6.75, 2.94, 0.00, 0.00}), 
coo(TRefSou = 28 + 273.15, 
	TRefLoa = 12 + 273.15, 
	Q_flow = -0000.00, 
	P = 0000, 
	coeQ = {-5.79235417, 9.83800467, -3.19795605, 0.0, 0.0}, 
	coeP = {-6.37109639, 1.27560526, 5.81780490, 0.0, 0.0})) 

"First selected heat pump" annotation(
  defaultComponentName = "per",
  defaultComponentPrefixes = "parameter",
  Documentation(info = "<html>
  <p>
Performance data for reverse heat pump model. This data corresponds to the brine-water heat pump with integrated water tank - Bosch Compress 7800i LW M(F).
</p>
<pre>
    Bosch Compress 7800i LW M(F) 6 KW,  !- Name
    5850.0,                   			!- Reference Heating Capacity {W}
    -----,                   			!- Reference Cooling Capacity {W}
    4.60,                    			!- Reference COP {W/W}
    1000,                  		    	!- Reference Evaporator Water Flow Rate {l/h}
    1040,                 			    !- Reference Condenser Water Flow Rate {l/h}
</pre>
</html>", revisions = "<html>
<ul>
<li>
February 16, 2022 by Nicolas Carbonare:<br/>
First implementation. Cooling data not added yet. 
</li>
</ul>
</html>"));
