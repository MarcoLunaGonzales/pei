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
        $sqlFile = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, ruta, filesize, UPPER(extension) as extension FROM actividades_archivos ORDER BY codigo DESC";
        $stmFile = $dbh->prepare($sqlFile);
        $stmFile->execute();
        $content = '';
        $rows_files = $stmFile->fetchAll();
        $array_color = ['primary', 'secondary', 'warning'];
        $count_array = count($array_color);
        foreach ($rows_files as $file){
            $color_val = $array_color[random_int(0, $count_array-1)];
            $content .= '
                <div class="inbox-item">
                    <div class="card shadow-none border">
                        <div class="p-2">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-'.$color_val.' text-'.$color_val.' rounded">
                                            '.$file['extension'].'
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <a href="file_activity/'.$file['ruta'].'" download="pei_'.$file['ruta'].'" class="text-muted fw-bold">'.$file['ruta'].'</a>
                                    <p class="mb-0 font-12">'.$file['filesize'].'</p>
                                </div>
                                <div class="col-auto">
                                    <a href="file_activity/'.$file['ruta'].'" download="pei_'.$file['ruta'].' class="btn btn-link font-16 text-muted">
                                        <i class="dripicons-download"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                ';
        }
        echo json_encode(array(
            'status'  => true,
            'content' => $content
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
        $sqlNote = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, anotacion FROM actividades_anotaciones ORDER BY codigo DESC";
        $stmtNote = $dbh->prepare($sqlNote);
        $stmtNote->execute();
        $content = '';
        $rows_notes = $stmtNote->fetchAll();
        foreach ($rows_notes as $note){
            $content .= '
            <div class="inbox-item">
                <div class="d-flex align-items-start p-1">
                    <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                    <div class="w-100">
                        <h5 class="mt-0 mb-0 font-size-14 pt-1">
                            <span class="float-end text-muted font-12">'.$note['fecha'].'</span>
                            '.$note['anotacion'].'
                        </h5>
                    </div>
                </div>
            </div>
            ';
        }
        echo json_encode(array(
            'status'    => true,
            'content'   => $content
        ));
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}
/**
 * Almacenamiento la asignación del colaborador
 * method: POST
 * @autor: Ronald Mollericona
 **/
else if($_POST['type'] == 3){
    $staff = $_POST['cod_personal'];
    $date  = date('Y-m-d');
    try {
        $sqlInsert   ="INSERT INTO actividades_anotaciones (cod_actividad, cod_personal, fecha, anotacion, cod_estado)
        	            VALUES ('$code_activity','$cod_personal','$date','$anotacion','1')";
        $stmt        = $dbh->prepare($sqlInsert);
        $flagSuccess = $stmt->execute();
        /* Se obtiene ultimo registro */
        $sqlNote = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, anotacion FROM actividades_anotaciones ORDER BY codigo DESC";
        $stmtNote = $dbh->prepare($sqlNote);
        $stmtNote->execute();
        $content = '';
        $rows_notes = $stmtNote->fetchAll();
        foreach ($rows_notes as $note){
            $content .= '
            <div class="inbox-item">
                <div class="d-flex align-items-start p-1">
                    <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                    <div class="w-100">
                        <h5 class="mt-0 mb-0 font-size-14 pt-1">
                            <span class="float-end text-muted font-12">'.$note['fecha'].'</span>
                            '.$note['anotacion'].'
                        </h5>
                    </div>
                </div>
            </div>
            ';
        }
        echo json_encode(array(
            'status'    => true,
            'content'   => $content
        ));
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}

?>