<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();

$nombre=$_POST["nombre"];
$abreviatura=$_POST["abreviatura"];
$campoForaneo=$_POST["campo_foraneo"];
$campoForaneo2=$_POST["campo_foraneo2"];
$nivel=$_POST["nivel"];
$codEstado="1";

//echo $nombre." ".$abreviatura." ".$table;
// Prepare
$stmt = $dbh->prepare("INSERT INTO $table (nombre, abreviatura, cod_estado, nivel,$keyForeignTable,$keyForeignTable2) VALUES (:nombre, :abreviatura, :cod_estado, :nivel, :campo_foraneo, :campo_foraneo2)");
// Bind
$stmt->bindParam(':nombre', $nombre);
$stmt->bindParam(':abreviatura', $abreviatura);
$stmt->bindParam(':cod_estado', $codEstado);
$stmt->bindParam(':nivel', $nivel);
$stmt->bindParam(':campo_foraneo', $campoForaneo);
$stmt->bindParam(':campo_foraneo2', $campoForaneo2);

$flagSuccess=$stmt->execute();
showAlertSuccessError($flagSuccess,$urlList);

?>
