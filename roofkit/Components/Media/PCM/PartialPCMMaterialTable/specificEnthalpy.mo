within RoofKIT.Components.Media.PCM.PartialPCMMaterialTable;
function specificEnthalpy
  input Integer tableID;
  input Modelica.SIunits.Temperature T;
  output Modelica.SIunits.SpecificEnthalpy h;
algorithm
  h := tableIpo(
      tableID,
      2,
      T);//2= zweite Spalte (hier immer festgesetzt, weil ich immer nur zwei Spalten habe)
end specificEnthalpy;
