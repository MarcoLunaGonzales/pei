<?php
require_once '../conexion.php';

$dbh = new Conexion();
/**
 * Almacenamiento de Archivos realacionadas a Actividades
 * method: POST
 * @autor: Ronald Mollericona
 **/
if($_POST['type'] == 1){
    $code_activity = $_POST['code_activity'];
    $date          = date('Y-m-d');
    // Preparación de archivo
    $folder        = 'file_activity';
    $dir           = dirname(__DIR__, 1) . "/" . $folder . "/";
    $file_name     = date('His') . basename($_FILES["file"]["name"]);
    $name          = $dir . $file_name;
    $type_file     = strtolower(pathinfo($name, PATHINFO_EXTENSION));
    // Se obtiene extension del archivo
    $file_ext      = new SplFileInfo($name);
    $extension     = $file_ext->getExtension();
    if (move_uploaded_file($_FILES["file"] ["tmp_name"], $name)) {
        $sqlInsert = "INSERT INTO actividades_archivos (cod_actividad, cod_personal, fecha, ruta, extension,cod_estado)
        	            VALUES ('$code_activity','1','$date','$file_name','$extension','1')";
        $stmt      = $dbh->prepare($sqlInsert);
        $flagSuccess = $stmt->execute();
        echo "Archivo subido con exito";
    } else {
        echo "Error en la subida del archivo";
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
        	            VALUES ('$code_activity','1','$date','$anotacion','1')";
        $stmt        = $dbh->prepare($sqlInsert);
        $flagSuccess = $stmt->execute();
        echo "Registro guardado con exito";
    } catch (Exception $e) {
        echo 'Excepción capturada: ',  $e->getMessage(), "\n";
    }
}

?>