<?php
//AQUI SE DEFINEN LAS VARIABLES PARA EL ABM
$table="niveles_configuracion";

$table2="niveles_pei";

$moduleNameSingular="Gestion del PEI";
$moduleNamePlural="Gestion del PEI";

$foreignTable="empresas";
$keyForeignTable="cod_empresa";

$nameForeignField="Empresa";

$urlList="../index.php?opcion=listNivelesPEI";
$urlList2="index.php?opcion=listNivelesPEI";
$urlList3="index.php?opcion=ListNivelDetallePEI";

$urlRegister="index.php?opcion=registerNivelConfiguracion";
$urlEdit="index.php?opcion=editNivelConfiguracion";
$urlDelete="index.php?opcion=deleteNivelConfiguracion";
$urlSave="t_niveles_pei/save.php";
$urlSaveEdit="t_niveles_pei/saveEdit.php";
$urlSaveDelete="";

$urlDetail="index.php?opcion=NivelesRegisterFields";
$urlSaveDetail="niveles_configuracion/saveDetailCamposNiveles.php";

?>