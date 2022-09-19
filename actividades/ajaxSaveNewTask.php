<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();
$cod_personal  = $_SESSION['globalUser'];

$nombre				= $_POST["nombre"];
$observaciones		= $_POST["observaciones"];
$fechaInicio		= $_POST["fecha_inicio"];
$fechaLimite		= $_POST["fecha_limite"];
$prioridad			= $_POST["prioridad"];
$codComponentePEI	= $_POST["componente_pei"];

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

// Obtener ultimo registro de Actividad
$sqlActivity = "SELECT codigo FROM actividades
ORDER BY codigo DESC
LIMIT 1";
$stmtFindActivity = $dbh->prepare($sqlActivity);
$stmtFindActivity->execute();
while ($rowFind = $stmtFindActivity->fetch(PDO::FETCH_ASSOC)) {
	$codigo_actividad = $rowFind["codigo"];
}

// Registrar primer estado de KANBAN
$sqlInsert="INSERT INTO actividades_cambios_estado (cod_actividad, cod_personal, fecha, cod_estadoactividad)
	 VALUES ('$codigo_actividad','$cod_personal','$fechaInicio','$codEstadoKanban')";
//echo $sqlInsert;
$stmt = $dbh->prepare($sqlInsert);
$flagSuccess=$stmt->execute();


echo "1";

?>