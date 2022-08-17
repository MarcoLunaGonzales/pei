<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();

$codigo=$_POST["codigo"];
$nombre=$_POST["nombre"];
$abreviatura=$_POST["abreviatura"];
$nivel=$_POST["nivel"];
$campoForaneo=$_POST["campo_foraneo"];
$campoForaneo2=$_POST["campo_foraneo2"];
$codEstado="1";

// Prepare
$stmt = $dbh->prepare("UPDATE $table set nombre=:nombre, abreviatura=:abreviatura, nivel=:nivel,  $keyForeignTable=:campo_foraneo, $keyForeignTable2=:campo_foraneo2 where codigo=:codigo");
// Bind
$stmt->bindParam(':codigo', $codigo);
$stmt->bindParam(':nombre', $nombre);
$stmt->bindParam(':abreviatura', $abreviatura);
$stmt->bindParam(':campo_foraneo', $campoForaneo);
$stmt->bindParam(':campo_foraneo2', $campoForaneo2);
$stmt->bindParam(':nivel', $nivel);
$flagSuccess=$stmt->execute();
showAlertSuccessError($flagSuccess,$urlList);

?>