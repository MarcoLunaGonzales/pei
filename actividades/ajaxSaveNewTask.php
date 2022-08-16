<?php
require_once '../conexion.php';
$dbh = new Conexion();

$nombre=$_POST["nombre"];
$observaciones=$_POST["observaciones"];
$fechaLimite=$_POST["fecha_limite"];
$prioridad=$_POST["prioridad"];
$codEstadoKanban=$_POST["estado_kanban"];

$sqlInsert="INSERT INTO actividades (nombre, observaciones, fecha_limite, cod_estadokanban, cod_prioridad)
	 VALUES ('$nombre','$observaciones','$fechaLimite','$codEstadoKanban','$prioridad')";
//echo $sqlInsert;
$stmt = $dbh->prepare($sqlInsert);
$flagSuccess=$stmt->execute();

echo "1";

?>