<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();

$cod_personal  = $_SESSION['globalUser'];

/* Función Guardar Evento */
// Datos
$observacion = $_POST['observacion'];
$detalle = $_POST['detalle'];
$fecha   = $_POST['fecha'];
$fecha_inicio  = $fecha.' '.$_POST['inicio'];
$fecha_fin     = $fecha.' '.$_POST['fin'];
try {
    $sqlInsert   ="INSERT INTO eventos (cod_personal, detalle, observacion, fecha_inicio, fecha_fin, cod_estado)
                    VALUES ('$cod_personal','$detalle','$observacion','$fecha_inicio','$fecha_fin','1')";
    $stmt        = $dbh->prepare($sqlInsert);
    $stmt->execute();
    echo json_encode(array(
        'status' => true
    ));
} catch (Exception $e) {
    echo json_encode(array(
        'status' => false
    ));
}

?>