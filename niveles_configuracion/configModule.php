<?php
//AQUI SE DEFINEN LAS VARIABLES PARA EL ABM
$table="niveles_configuracion";
$moduleNameSingular="Nivel Configuracion";
$moduleNamePlural="Niveles de Configuracion";

$foreignTable="empresas";
$keyForeignTable="cod_empresa";

$nameForeignField="Empresa";

$urlList="../index.php?opcion=listNivelesConfiguracion";
$urlList2="index.php?opcion=listNivelesConfiguracion";
$urlRegister="index.php?opcion=registerNivelConfiguracion";
$urlEdit="index.php?opcion=editNivelConfiguracion";
$urlDelete="index.php?opcion=deleteNivelConfiguracion";
$urlSave="niveles_configuracion/save.php";
$urlSaveEdit="niveles_configuracion/saveEdit.php";
$urlSaveDelete="";
$urlDetail="index.php?opcion=NivelesRegisterFields";

?>