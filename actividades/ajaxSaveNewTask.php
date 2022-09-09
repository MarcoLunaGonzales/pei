<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();
$cod_personal  = $_SESSION['globalUser'];

$nombre=$_POST["nombre"];
$observaciones=$_POST["observaciones"];
$fechaLimite=$_POST["fecha_limite"];
$prioridad=$_POST["prioridad"];
$codComponentePEI=$_POST["componente_pei"];

/* Obtenemos Configuración estado inicial de KANBAN */
$sqlFindState = "SELECT * FROM configuraciones
WHERE id_configuracion = 1";
$stmtFindState= $dbh->prepare($sqlFindState);
$stmtFindState->execute();
while ($rowFind = $stmtFindState->fetch(PDO::FETCH_ASSOC)) {
	$codEstadoKanban = $rowFind["valor_configuracion"];
}

$sqlInsert="INSERT INTO actividades (nombre, observaciones, fecha_limite, cod_responsable, cod_estadokanban, cod_prioridad, cod_componentepei)
	 VALUES ('$nombre','$observaciones','$fechaLimite','$cod_personal','$codEstadoKanban','$prioridad','$codComponentePEI')";
//echo $sqlInsert;
$stmt = $dbh->prepare($sqlInsert);
$flagSuccess=$stmt->execute();

echo "1";

?>