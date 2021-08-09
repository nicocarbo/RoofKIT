within RoofKIT.Components.Media.PCM.PartialPCMMaterialTable;
function tableInit
  "Initialize 1-dim. table defined by matrix (for details see: Modelica/C-Sources/ModelicaTables.h)"
    input String tableName "Name der Tabelle, der in der Datei angegeben ist";
    input String fileName "Pfad zur Tabelle";
    input Real table[ :, :]
    "Array für mögliche Tabelle (wird in meinem Fall nicht genutzt, weil ich die Tabelle über einen Pfad einlese";
    input Modelica.Blocks.Types.Smoothness smoothness
    "Art, wie interpoliert wird";
    output Integer tableID
    "TableID = wird beim initialisieren einmal erzeugt, wenn Tabelle in den Hauptspeicher geschrieben wird";
    external "C" tableID = ModelicaTables_CombiTable1D_init(
                 tableName, fileName, table, size(table, 1), size(table, 2),
                 smoothness);
    annotation(Library="ModelicaExternalC");
end tableInit;
