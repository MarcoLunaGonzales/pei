<?php
require_once '../conexion.php';
$dbh = new Conexion();

$globalAdmin=$_SESSION["globalAdmin"];
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

    if (move_uploaded_file($_FILES["file"] ["tmp_name"], $name)) {
        $sqlInsert="INSERT INTO actividades_archivos (cod_actividad, cod_personal, fecha, ruta, cod_estado)
        	 VALUES ('$code_activity','1','$date','$file_name','1')";
        $stmt = $dbh->prepare($sqlInsert);
        $flagSuccess=$stmt->execute();
        echo "archivo subido con exito";
    } else {
        echo "error en la subida del archivo";
    }
}

?>