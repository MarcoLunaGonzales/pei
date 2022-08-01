<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();

$codigo=$_POST["codigo"];
$nombre=$_POST["nombre"];
$abreviatura=$_POST["abreviatura"];
$campoForaneo=$_POST["campo_foraneo"];
$codEstado="1";

// Prepare
$stmt = $dbh->prepare("UPDATE $table set nombre=:nombre, abreviatura=:abreviatura, $keyForeignTable=:campo_foraneo where codigo=:codigo");
// Bind
$stmt->bindParam(':codigo', $codigo);
$stmt->bindParam(':nombre', $nombre);
$stmt->bindParam(':abreviatura', $abreviatura);
$stmt->bindParam(':campo_foraneo', $campoForaneo);

$flagSuccess=$stmt->execute();
showAlertSuccessError($flagSuccess,$urlList);

?>