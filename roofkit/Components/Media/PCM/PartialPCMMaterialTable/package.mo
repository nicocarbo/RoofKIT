within RoofKIT.Components.Media.PCM;
partial package PartialPCMMaterialTable
  constant String materialName;
  constant String tableName;
  constant String fileName "file name of the enthalpy curve";
  constant Modelica.SIunits.Density density;
  constant Modelica.SIunits.ThermalConductivity                         lambda_ver;
  constant Modelica.SIunits.ThermalConductivity                         lambda_hor;
  constant Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
  "smoothness of table interpolation";

  annotation(Dialog(group="table data interpretation"));
end PartialPCMMaterialTable;
