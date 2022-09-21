<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();
/**
 * Lista de Actividades e Hitos
 * method: POST
 * @autor: Ronald Mollericona
 **/

$cod_personal = $_SESSION['globalUser'];

// Obtiene fecha de Calendario
$fecha_inicio = date("Y-m-d H:i:s", strtotime($_GET['start']));
$fecha_final  = date("Y-m-d H:i:s", strtotime($_GET['end']));

// Consulta de Actividades Fechas de Inicio
$sqlActStart="	SELECT 1 as type, a.codigo as code, a.nombre as title, a.observaciones as description, DATE_FORMAT(aces.fecha,'%Y-%m-%d') as start, ('bg-primary') className
    from actividades a
    LEFT JOIN actividades_prioridades ap ON a.cod_prioridad = ap.codigo
    LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
    LEFT JOIN actividades_cambios_estado aces ON aces.cod_actividad = a.codigo
    WHERE a.cod_padre is null
    AND aces.cod_estadoactividad = 1
    AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')
    AND aces.fecha BETWEEN '$fecha_inicio' AND '$fecha_final'";
$stmtActivityStart = $dbh->prepare($sqlActStart);
$stmtActivityStart->execute();
$rowsActivityStart = $stmtActivityStart->fetchAll(PDO::FETCH_ASSOC);

// Consulta de Actividades Fechas Limite (Finalización)
$sqlActEnd="	SELECT 1 as type, a.codigo as code, a.nombre as title, a.observaciones as description, DATE_FORMAT(a.fecha_limite,'%Y-%m-%d') as start, ('bg-danger') className
    from actividades a
    LEFT JOIN actividades_prioridades ap ON a.cod_prioridad = ap.codigo
    LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
    WHERE a.cod_padre is null
    AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')
    AND a.fecha_limite BETWEEN '$fecha_inicio' AND '$fecha_final'";
$stmtActivityEnd = $dbh->prepare($sqlActEnd);
$stmtActivityEnd->execute();
$rowsActivityEnd = $stmtActivityEnd->fetchAll(PDO::FETCH_ASSOC);

// Hitos de horario
$sqlHitos ="	SELECT 2 as type, ahi.nombre as title, a.observaciones as description, DATE_FORMAT(ahi.fecha_hito,'%Y-%m-%d') as start, ('bg-success') className
    from actividades a
    LEFT JOIN actividades_prioridades ap ON a.cod_prioridad = ap.codigo
    LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
    LEFT JOIN actividades_hitos ahi ON ahi.cod_actividad = a.codigo
    WHERE a.cod_padre is null
    AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')
    AND ahi.fecha_hito BETWEEN '$fecha_inicio' AND '$fecha_final'";
$stmtHitos = $dbh->prepare($sqlHitos);
$stmtHitos->execute();
$rowsHitos = $stmtHitos->fetchAll(PDO::FETCH_ASSOC);

// Eventos Personales
$sqlEventos ="	SELECT 3 as type, e.detalle as title, e.observacion as description, DATE_FORMAT(e.fecha_inicio,'%Y-%m-%d %H:%i:%s') as start, DATE_FORMAT(e.fecha_fin,'%Y-%m-%d %H:%i:%s') as end, ('bg-warning') className
    from eventos e
    WHERE e.cod_personal = '$cod_personal'
    AND e.fecha_inicio BETWEEN '$fecha_inicio' AND '$fecha_final'";
$stmtEventos = $dbh->prepare($sqlEventos);
$stmtEventos->execute();
$rowsEventos = $stmtEventos->fetchAll(PDO::FETCH_ASSOC);

// Merge arrays
$array_data = array_merge($rowsActivityStart, $rowsActivityEnd, $rowsHitos, $rowsEventos);
echo json_encode($array_data);
?>