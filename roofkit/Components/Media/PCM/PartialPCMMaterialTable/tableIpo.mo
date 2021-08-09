within RoofKIT.Components.Media.PCM.PartialPCMMaterialTable;
function tableIpo
  "Interpolate 1-dim. table defined by matrix (for details see: Modelica/C-Sources/ModelicaTables.h)"
  input Integer tableID "es wird über die TableID auf die Tabelle zugegriffen";
  input Integer icol; //Spaltennummer
  input Real u
    "Wert in erster Spalte, zu dem der zugehörige value gesucht wird";
  output Real value;
external "C" value=ModelicaTables_CombiTable1D_interpolate(tableID, icol, u);
  annotation(Library="ModelicaExternalC");
end tableIpo;
