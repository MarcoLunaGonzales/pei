<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();
/**
 * Almacenamiento de Archivos realacionadas a Actividades
 * method: POST
 * @autor: Ronald Mollericona
 **/
$cod_personal = $_SESSION['globalUser'];
if($_POST['type'] == 1){
    $code_activity = $_POST['code_activity'];
    $date          = date('Y-m-d');
    // Preparación de archivo
    $folder        = 'file_activity';
    $dir           = dirname(__DIR__, 1) . "/" . $folder . "/";
    $file_name     = date('His') . basename($_FILES["file"]["name"]);
    $name          = $dir . $file_name;
    $type_file     = strtolower(pathinfo($name, PATHINFO_EXTENSION));
    // Tamaño de archivo
    $size          = $_POST['size'];
    $file_ext      = new SplFileInfo($name);
    $extension     = $file_ext->getExtension();
    if (move_uploaded_file($_FILES["file"] ["tmp_name"], $name)) {
        $sqlInsert = "INSERT INTO actividades_archivos (cod_actividad, cod_personal, fecha, ruta, filesize, extension, cod_estado)
        	            VALUES ('$code_activity','$cod_personal','$date','$file_name', '$size','$extension','1')";
        $stmt      = $dbh->prepare($sqlInsert);
        $flagSuccess = $stmt->execute();
        /* Se obtiene ultimo registro */
        $sqlid = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, ruta, filesize, UPPER(extension) as extension FROM actividades_archivos ORDER BY codigo DESC LIMIT 1";
        $stmid = $dbh->prepare($sqlid);
        $stmid->execute();

        echo json_encode(array(
            'status' => true,
            'data'   => $stmid->fetch(PDO::FETCH_ASSOC)
        ));
    } else {
        echo json_encode(array(
            'status' => false
        ));
    }
}
/**
 * Almacenamiento de Anotaciones de la Actividad
 * method: POST
 * @autor: Ronald Mollericona
 **/
else if($_POST['type'] == 2){
    $code_activity = $_POST['code_activity'];
    $anotacion     = $_POST['annotation'];
    $date          = date('Y-m-d');
    try {
        $sqlInsert   ="INSERT INTO actividades_anotaciones (cod_actividad, cod_personal, fecha, anotacion, cod_estado)
        	            VALUES ('$code_activity','$cod_personal','$date','$anotacion','1')";
        $stmt        = $dbh->prepare($sqlInsert);
        $flagSuccess = $stmt->execute();
        /* Se obtiene ultimo registro */
        $sqlid = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, anotacion FROM actividades_anotaciones ORDER BY codigo DESC LIMIT 1";
        $stmid = $dbh->prepare($sqlid);
        $stmid->execute();
        
        echo json_encode(array(
            'status' => true,
            'data'   => $stmid->fetch(PDO::FETCH_ASSOC)
        ));
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}

?>