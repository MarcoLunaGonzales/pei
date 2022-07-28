<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();

$nombre=$_POST["nombre"];
$abreviatura=$_POST["abreviatura"];
$nivel=$_POST["nivel"];
$codEstado="1";

//echo $nombre." ".$abreviatura." ".$table;
// Prepare
$stmt = $dbh->prepare("INSERT INTO $table (nombre, abreviatura, nivel, cod_estado) VALUES (:nombre, :abreviatura, :nivel, :cod_estado)");
// Bind
$stmt->bindParam(':nombre', $nombre);
$stmt->bindParam(':abreviatura', $abreviatura);
$stmt->bindParam(':nivel', $nivel);
$stmt->bindParam(':cod_estado', $codEstado);

$flagSuccess=$stmt->execute();
showAlertSuccessError($flagSuccess,$urlList);

?>
