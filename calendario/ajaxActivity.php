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
$fecha_inicio = $_GET['start'];
$fecha_final  = $_GET['end'];

// Consulta de Actividades asignadas
$sqlAct="SELECT a.nombre as title, a.observaciones as description, DATE_FORMAT(a.fecha_limite,'%Y-%m-%d') as start
    from actividades a
    LEFT JOIN actividades_prioridades ap ON a.cod_prioridad = ap.codigo
    LEFT JOIN personalimagen pimg ON a.cod_responsable = pimg.codigo
    LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
    WHERE a.cod_padre is null
    AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')";
$stmtActivity = $dbh->prepare($sqlAct);
$stmtActivity->execute();
$rowsActivity = $stmtActivity->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($rowsActivity);
?>