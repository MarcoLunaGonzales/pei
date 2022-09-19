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

echo json_encode(array(
    'status' => $fecha_inicio
));
?>