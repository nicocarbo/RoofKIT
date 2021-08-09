within RoofKIT.Components.Media.PCM.table_h;
package Eis_Wasser
  extends PartialPCMMaterialTable(
  final materialName="Eis_Wasser",
  final tableName="table",
  final fileName=
      "/net/home4/abachmai/Solbau/01_Tools/01_Modelica/02_Bibliotheken/ise/ISELib/Fluid/Storage/Eisspeicher/00_Input_Data/01_Eisspeicher_h_T_table/h_T_Eis_Wasser.txt",
  final density=1000,
  final lambda_ver=8,
  final lambda_hor=25,
  final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments);
    //Temperaturgrenzen in Materialdatei: 271,15 - 313,15 K
end Eis_Wasser;
