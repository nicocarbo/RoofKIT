within RoofKIT.EnergyConcept_GG.WholeConcept.FinalModels;

model GG_Electrical_simplified
  // 3.1536e+07 stop time
  // StartTime = 13392000, StopTime = 13996800 // Sunny week
  // StartTime = 14509700, StopTime = 15114500 // Cloudy week
  extends Modelica.Icons.Example;
  parameter Modelica.SIunits.MassFlowRate mflow_nom = 60 / 3600 "Nominal mass flow rate";
  package Medium_sou = Buildings.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.35, property_T = 283.15);
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat1(filNam = ModelicaServices.ExternalReferences.loadResource("modelica://RoofKIT/Resources/WeatherFiles/DEU_NW_Dusseldorf.AP.104000_TMYx.2004-2018.mos")) annotation(
    Placement(visible = true, transformation(origin = {78, 124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //DIN ISO 13790
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Dach(A = 345, V_nominal = 40, azi(displayUnit = "deg") = 3.054326190990077, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "rad") = 0.2094395102393195) annotation(
    Placement(visible = true, transformation(origin = {92, -102}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Conversion.ACDCConverter conv(conversionFactor = 480 / 480, eta = 0.98) annotation(
    Placement(visible = true, transformation(origin = {18, -124}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(V = 480, f = 60) annotation(
    Placement(visible = true, transformation(origin = {-90, 132}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive RL(V_nominal = 120, mode = Buildings.Electrical.Types.Load.VariableZ_P_input) annotation(
    Placement(visible = true, transformation(origin = {-165, -100}, extent = {{-7, -8}, {7, 8}}, rotation = 0)));
  Buildings.Electrical.DC.Storage.Battery bat(EMax(displayUnit = "J") = 360000000, SOC_start = 0.4, V_nominal = 110) annotation(
    Placement(visible = true, transformation(origin = {-88, -140}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add_pow annotation(
    Placement(visible = true, transformation(origin = {-138, -100}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_el(k = -1) annotation(
    Placement(visible = true, transformation(origin = {-151, -117}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  RoofKIT.Components.Controls.BatteryControl_Contest batteryControl_Contest annotation(
    Placement(visible = true, transformation(origin = {-83, -100}, extent = {{-11, -12}, {11, 12}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant BMS(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-144, -48}, extent = {{-4, -4}, {4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum var_load(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {-90, -28}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable SecondFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/SecondFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "SecondFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {19, 125}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable FirstFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/FirstFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "FirstFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-9, 125}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable ThirdFloor(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/ThirdFloor.txt", table = [0, 0, 0, 0, 0, 0], tableName = "ThirdFloor", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {45, 125}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_SolarTree(A = 53, V_nominal = 40, azi(displayUnit = "deg") = 3.054326190990077, eta = 0.10, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 0.3490658503988659) annotation(
    Placement(visible = true, transformation(origin = {174, -170}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Fass_West(A = 147, V_nominal = 40, azi(displayUnit = "deg") = 3.839724354387525, eta = 0.055, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 1.570796326794897) annotation(
    Placement(visible = true, transformation(origin = {132, -134}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Fass_Ost(A = 147, V_nominal = 40, azi(displayUnit = "deg") = 2.268928027592628, eta = 0.055, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 1.570796326794897) annotation(
    Placement(visible = true, transformation(origin = {92, -132}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Fass_Sued(A = 167, V_nominal = 400, azi(displayUnit = "deg") = 2.268928027592628, eta = 0.055, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 1.570796326794897) annotation(
    Placement(visible = true, transformation(origin = {128, -104}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Brandwand(A = 58.8, V_nominal = 40, azi(displayUnit = "deg") = 2.268928027592628, eta = 0.18, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 1.570796326794897) annotation(
    Placement(visible = true, transformation(origin = {166, -106}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Buildings.Electrical.DC.Sources.PVSimpleOriented PV_Flachdach(A = 180, V_nominal = 40, azi(displayUnit = "deg") = 0, eta = 0.18, fAct = 0.8, lat(displayUnit = "rad") = 0.6579891280018599, til(displayUnit = "deg") = 0) annotation(
    Placement(visible = true, transformation(origin = {170, -136}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum PV_sum(nu = 7) annotation(
    Placement(visible = true, transformation(origin = {-12, -106}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum DHW_sum(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {78, 52}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum Heat_sum(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {20, 72}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain Vent_SPF(k = 0.4) annotation(
    Placement(visible = true, transformation(origin = {-90, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum Vent_sum(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {-118, 68}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain DHW_energy(k = 4200 * 30 / 3600) annotation(
    Placement(visible = true, transformation(origin = {56, 52}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Mobility(k = 0.1585365) annotation(
    Placement(visible = true, transformation(origin = {-100, -60}, extent = {{4, -4}, {-4, 4}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2_solCol annotation(
    Placement(visible = true, transformation(origin = {-3, 55}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_h annotation(
    Placement(visible = true, transformation(origin = {170, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_g annotation(
    Placement(visible = true, transformation(origin = {94, -42}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_s annotation(
    Placement(visible = true, transformation(origin = {164, -38}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter lim_grid(limitsAtInit = true, uMax = 100000, uMin = 0) annotation(
    Placement(visible = true, transformation(origin = {40, -60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression realExpression(y = grid.P.real) annotation(
    Placement(visible = true, transformation(origin = {156, -65}, extent = {{10, -7}, {-10, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_c_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {122, 8}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_eb_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {56, -2}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator E_f annotation(
    Placement(visible = true, transformation(origin = {30, -28}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain_grid(k = -1) annotation(
    Placement(visible = true, transformation(origin = {66, -60}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_eb(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {82, -2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add E_c annotation(
    Placement(visible = true, transformation(origin = {125, -25}, extent = {{9, -9}, {-9, 9}}, rotation = 0)));
  Modelica.Blocks.Math.MultiSum EE_house(nu = 3) annotation(
    Placement(visible = true, transformation(origin = {-86, 6}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {117, 37}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_g_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {60, -40}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Gain greywater_rec(k = 0.2) annotation(
    Placement(visible = true, transformation(origin = {120, 166}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator int_greyw annotation(
    Placement(visible = true, transformation(origin = {99, 167}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain E_gw_kwh(k = 1 / 1000 / 3600) annotation(
    Placement(visible = true, transformation(origin = {74, 168}, extent = {{6, -6}, {-6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k1 = -1) annotation(
    Placement(visible = true, transformation(origin = {21, 49}, extent = {{5, -5}, {-5, 5}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable COP_table(fileName = "C:/Users/vp3411/Documents/Programme/Modelica/RoofKIT/roofkit/Resources/BuildingData/GG/COP.txt", table = [0, 0], tableName = "COP", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {33, 143}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {-25, 55}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
equation
//Connections
//WeatherBus
  connect(weaDat1.weaBus, PV_Dach.weaBus);
  connect(weaDat1.weaBus, PV_SolarTree.weaBus);
  connect(weaDat1.weaBus, PV_Fass_West.weaBus);
  connect(weaDat1.weaBus, PV_Fass_Ost.weaBus);
  connect(weaDat1.weaBus, PV_Fass_Sued.weaBus);
  connect(weaDat1.weaBus, PV_Brandwand.weaBus);
  connect(weaDat1.weaBus, PV_Flachdach.weaBus);
//Others
  connect(conv.terminal_p, bat.terminal) annotation(
    Line(points = {{28, -124}, {-115, -124}, {-115, -140}, {-98, -140}}));
  connect(conv.terminal_n, grid.terminal) annotation(
    Line(points = {{8, -124}, {-43, -124}, {-43, -184}, {-196, -184}, {-196, 122}, {-90, 122}}));
  connect(RL.terminal, grid.terminal) annotation(
    Line(points = {{-172, -100}, {-172, -101.5}, {-196, -101.5}, {-196, 121}, {-90, 121}, {-90, 122}}));
  connect(gain_el.u, add_pow.y) annotation(
    Line(points = {{-142.6, -117}, {-136.6, -117}, {-136.6, -109}, {-148.6, -109}, {-148.6, -101}, {-144.6, -101}}, color = {0, 0, 127}));
  connect(RL.Pow, gain_el.y) annotation(
    Line(points = {{-158, -100}, {-154, -100}, {-154, -110}, {-166, -110}, {-166, -116}, {-158, -116}}, color = {0, 0, 127}));
  connect(bat.P, batteryControl_Contest.P) annotation(
    Line(points = {{-88, -130}, {-88, -120}, {-64, -120}, {-64, -100}, {-71, -100}}, color = {0, 0, 127}));
  connect(bat.SOC, batteryControl_Contest.SOC) annotation(
    Line(points = {{-76, -134}, {-68, -134}, {-68, -84}, {-102, -84}, {-102, -97}, {-96, -97}}, color = {0, 0, 127}));
  connect(add_pow.y, batteryControl_Contest.power_cons) annotation(
    Line(points = {{-144, -100}, {-146, -100}, {-146, -108}, {-108, -108}, {-108, -105}, {-95, -105}}, color = {0, 0, 127}));
  connect(add_pow.u3, var_load.y) annotation(
    Line(points = {{-130, -104}, {-120, -104}, {-120, -28}, {-98, -28}}, color = {0, 0, 127}));
  connect(add_pow.u1, BMS.y) annotation(
    Line(points = {{-130, -96}, {-126, -96}, {-126, -72}, {-140, -72}, {-140, -48}}, color = {0, 0, 127}));
  connect(batteryControl_Contest.PV_power, PV_sum.y) annotation(
    Line(points = {{-96, -110}, {-104, -110}, {-104, -114}, {-36, -114}, {-36, -106}, {-20, -106}}, color = {0, 0, 127}));
  connect(Vent_sum.y, Vent_SPF.u) annotation(
    Line(points = {{-110, 68}, {-98, 68}}, color = {0, 0, 127}));
  connect(Vent_SPF.y, var_load.u[1]) annotation(
    Line(points = {{-84, 68}, {-66, 68}, {-66, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(DHW_sum.y, DHW_energy.u) annotation(
    Line(points = {{71, 52}, {63, 52}}, color = {0, 0, 127}));
  connect(add_pow.u2, Mobility.y) annotation(
    Line(points = {{-130, -100}, {-124, -100}, {-124, -62}, {-104, -62}, {-104, -60}}, color = {0, 0, 127}));
  connect(grid.terminal, grid.terminal) annotation(
    Line(points = {{-90, 122}, {-90, 122}}, color = {255, 255, 255}));
  connect(PV_Dach.P, PV_sum.u[1]) annotation(
    Line(points = {{82, -94}, {16, -94}, {16, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_Fass_Ost.P, PV_sum.u[2]) annotation(
    Line(points = {{82, -124}, {72, -124}, {72, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_Fass_West.P, PV_sum.u[3]) annotation(
    Line(points = {{122, -126}, {116, -126}, {116, -118}, {52, -118}, {52, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_Fass_Sued.P, PV_sum.u[4]) annotation(
    Line(points = {{118, -96}, {108, -96}, {108, -84}, {14, -84}, {14, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_Brandwand.P, PV_sum.u[5]) annotation(
    Line(points = {{156, -98}, {148, -98}, {148, -88}, {8, -88}, {8, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_Flachdach.P, PV_sum.u[6]) annotation(
    Line(points = {{160, -128}, {152, -128}, {152, -118}, {42, -118}, {42, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(PV_SolarTree.P, PV_sum.u[7]) annotation(
    Line(points = {{164, -162}, {56, -162}, {56, -106}, {-6, -106}}, color = {0, 0, 127}));
  connect(conv.terminal_p, PV_Fass_Ost.terminal) annotation(
    Line(points = {{28, -124}, {48, -124}, {48, -152}, {108, -152}, {108, -132}, {102, -132}}));
  connect(PV_Dach.terminal, conv.terminal_p) annotation(
    Line(points = {{102, -102}, {106, -102}, {106, -114}, {42, -114}, {42, -124}, {28, -124}}));
  connect(PV_Fass_Sued.terminal, conv.terminal_p) annotation(
    Line(points = {{138, -104}, {146, -104}, {146, -116}, {38, -116}, {38, -124}, {28, -124}}));
  connect(PV_Fass_West.terminal, conv.terminal_p) annotation(
    Line(points = {{142, -134}, {150, -134}, {150, -154}, {46, -154}, {46, -124}, {28, -124}}));
  connect(PV_SolarTree.terminal, conv.terminal_p) annotation(
    Line(points = {{184, -170}, {190, -170}, {190, -188}, {52, -188}, {52, -124}, {28, -124}}));
  connect(PV_Flachdach.terminal, conv.terminal_p) annotation(
    Line(points = {{180, -136}, {188, -136}, {188, -152}, {35, -152}, {35, -124}, {28, -124}}));
  connect(PV_Brandwand.terminal, conv.terminal_p) annotation(
    Line(points = {{176, -106}, {192, -106}, {192, -156}, {28, -156}, {28, -124}}));
  connect(Heat_sum.y, add2_solCol.u1) annotation(
    Line(points = {{13, 72}, {6, 72}, {6, 60}, {6.5, 60}, {6.5, 58}, {3, 58}}, color = {0, 0, 127}));
  connect(lim_grid.y, E_f.u) annotation(
    Line(points = {{33, -60}, {27.5, -60}, {27.5, -46}, {46, -46}, {46, -28}, {42, -28}}, color = {0, 0, 127}));
  connect(gain_grid.y, lim_grid.u) annotation(
    Line(points = {{59, -60}, {47, -60}}, color = {0, 0, 127}));
  connect(E_c.y, E_eb.u1) annotation(
    Line(points = {{116, -24}, {108, -24}, {108, 4}, {94, 4}}, color = {0, 0, 127}));
  connect(E_c.u2, E_s.y) annotation(
    Line(points = {{136, -30}, {144, -30}, {144, -38}, {154, -38}}, color = {0, 0, 127}));
  connect(E_c.u1, E_h.y) annotation(
    Line(points = {{136, -20}, {144, -20}, {144, 0}, {159, 0}}, color = {0, 0, 127}));
  connect(E_c.y, E_c_kwh.u) annotation(
    Line(points = {{116, -24}, {114, -24}, {114, -4}, {134, -4}, {134, 8}, {130, 8}}, color = {0, 0, 127}));
  connect(E_eb_kwh.u, E_eb.y) annotation(
    Line(points = {{63, -2}, {71, -2}}, color = {0, 0, 127}));
  connect(E_g.y, E_eb.u2) annotation(
    Line(points = {{83, -42}, {74, -42}, {74, -24}, {102, -24}, {102, -8}, {94, -8}}, color = {0, 0, 127}));
  connect(gain_grid.u, realExpression.y) annotation(
    Line(points = {{73, -60}, {84, -60}, {84, -65}, {145, -65}}, color = {0, 0, 127}));
  connect(EE_house.y, var_load.u[2]) annotation(
    Line(points = {{-94, 6}, {-92, 6}, {-92, -10}, {-72, -10}, {-72, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(E_h.u, EE_house.y) annotation(
    Line(points = {{182, 0}, {182, 28}, {-114, 28}, {-114, 6}, {-94, 6}}, color = {0, 0, 127}));
  connect(add.u2, Vent_SPF.y) annotation(
    Line(points = {{111, 34}, {-50, 34}, {-50, 68}, {-84, 68}}, color = {0, 0, 127}));
  connect(add.y, E_s.u) annotation(
    Line(points = {{122.5, 37}, {206, 37}, {206, -38}, {176, -38}}, color = {0, 0, 127}));
  connect(PV_sum.y, E_g.u) annotation(
    Line(points = {{-20, -106}, {-24, -106}, {-24, -70}, {124, -70}, {124, -42}, {106, -42}}, color = {0, 0, 127}));
  connect(E_g_kwh.u, E_g.y) annotation(
    Line(points = {{68, -40}, {70, -40}, {70, -42}, {84, -42}}, color = {0, 0, 127}));
  connect(DHW_energy.y, greywater_rec.u) annotation(
    Line(points = {{49, 52}, {40, 52}, {40, 76}, {134, 76}, {134, 166}, {128, 166}}, color = {0, 0, 127}));
  connect(int_greyw.u, greywater_rec.y) annotation(
    Line(points = {{108, 168}, {114, 168}, {114, 166}}, color = {0, 0, 127}));
  connect(int_greyw.y, E_gw_kwh.u) annotation(
    Line(points = {{92, 168}, {82, 168}}, color = {0, 0, 127}));
  connect(DHW_energy.y, add1.u2) annotation(
    Line(points = {{49, 52}, {49, 53}, {38, 53}, {38, 52}, {34, 52}, {34, 46}, {28, 46}}, color = {0, 0, 127}));
  connect(add1.u1, greywater_rec.y) annotation(
    Line(points = {{28, 52}, {32, 52}, {32, 82}, {114, 82}, {114, 166}}, color = {0, 0, 127}));
  connect(add1.y, add2_solCol.u2) annotation(
    Line(points = {{16, 50}, {10, 50}, {10, 52}, {4, 52}}, color = {0, 0, 127}));
  connect(add2_solCol.y, division.u1) annotation(
    Line(points = {{-8, 56}, {-10, 56}, {-10, 60}, {-16, 60}}, color = {0, 0, 127}));
  connect(COP_table.y[1], division.u2) annotation(
    Line(points = {{40, 144}, {154, 144}, {154, 30}, {-14, 30}, {-14, 50}, {-16, 50}}, color = {0, 0, 127}));
  connect(division.y, var_load.u[3]) annotation(
    Line(points = {{-32, 56}, {-38, 56}, {-38, -28}, {-84, -28}}, color = {0, 0, 127}));
  connect(division.y, add.u1) annotation(
    Line(points = {{-32, 56}, {-34, 56}, {-34, 40}, {111, 40}}, color = {0, 0, 127}));
  connect(FirstFloor.y[2], Heat_sum.u[1]) annotation(
    Line(points = {{-2, 126}, {-4, 126}, {-4, 94}, {28, 94}, {28, 72}, {26, 72}}, color = {0, 0, 127}));
  connect(SecondFloor.y[2], Heat_sum.u[2]) annotation(
    Line(points = {{26, 126}, {30, 126}, {30, 72}, {26, 72}}, color = {0, 0, 127}));
  connect(ThirdFloor.y[2], Heat_sum.u[3]) annotation(
    Line(points = {{52, 126}, {44, 126}, {44, 72}, {26, 72}}, color = {0, 0, 127}));
  connect(FirstFloor.y[3], DHW_sum.u[1]) annotation(
    Line(points = {{-2, 126}, {0, 126}, {0, 86}, {96, 86}, {96, 52}, {84, 52}}, color = {0, 0, 127}));
  connect(SecondFloor.y[3], DHW_sum.u[2]) annotation(
    Line(points = {{26, 126}, {34, 126}, {34, 88}, {98, 88}, {98, 52}, {84, 52}}, color = {0, 0, 127}));
  connect(ThirdFloor.y[3], DHW_sum.u[3]) annotation(
    Line(points = {{52, 126}, {62, 126}, {62, 82}, {104, 82}, {104, 52}, {84, 52}}, color = {0, 0, 127}));
  connect(FirstFloor.y[5], Vent_sum.u[1]) annotation(
    Line(points = {{-2, 126}, {-4, 126}, {-4, 88}, {-136, 88}, {-136, 68}, {-124, 68}}, color = {0, 0, 127}));
  connect(SecondFloor.y[5], Vent_sum.u[2]) annotation(
    Line(points = {{26, 126}, {24, 126}, {24, 90}, {-130, 90}, {-130, 68}, {-124, 68}}, color = {0, 0, 127}));
  connect(ThirdFloor.y[5], Vent_sum.u[3]) annotation(
    Line(points = {{52, 126}, {54, 126}, {54, 86}, {-140, 86}, {-140, 68}, {-124, 68}}, color = {0, 0, 127}));
  connect(FirstFloor.y[4], EE_house.u[1]) annotation(
    Line(points = {{-2, 126}, {-4, 126}, {-4, 76}, {-74, 76}, {-74, 6}, {-80, 6}}, color = {0, 0, 127}));
  connect(SecondFloor.y[4], EE_house.u[2]) annotation(
    Line(points = {{26, 126}, {28, 126}, {28, 94}, {-70, 94}, {-70, 6}, {-80, 6}}, color = {0, 0, 127}));
  connect(ThirdFloor.y[4], EE_house.u[3]) annotation(
    Line(points = {{52, 126}, {50, 126}, {50, 94}, {-70, 94}, {-70, 6}, {-80, 6}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {36, 126}, fillColor = {170, 170, 127}, fillPattern = FillPattern.Solid, extent = {{-62, 26}, {62, -26}}), Rectangle(origin = {-112, -122}, fillColor = {223, 223, 0}, fillPattern = FillPattern.Solid, extent = {{66, -40}, {-66, 40}}), Rectangle(origin = {-97, 126}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-35, 26}, {35, -26}}), Rectangle(origin = {-95, -30}, fillColor = {78, 234, 114}, fillPattern = FillPattern.Solid, extent = {{99, -50}, {-99, 50}}), Rectangle(origin = {101, -30}, fillColor = {204, 142, 255}, fillPattern = FillPattern.Solid, extent = {{-93, 50}, {93, -50}})}, coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-6, Interval = 3600),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
end GG_Electrical_simplified;
