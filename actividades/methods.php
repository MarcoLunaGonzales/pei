<?php
require_once '../conexion.php';
session_start();

$dbh = new Conexion();
/**
 * Almacenamiento de Archivos realacionadas a Actividades
 * method: POST
 * @autor: Ronald Mollericona
 **/

$cod_personal  = $_SESSION['globalUser'];
$code_activity = $_POST['code_activity'];

if($_POST['type'] == 0){
    $sqlActividad="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%d-%m-%Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
        (select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei, np.nombre as nombreproyecto, a.cod_padre as cod_padre, date_format(a.fecha_limite, '%d-%m-%Y') as fecha, a.observaciones as obs, a.cod_responsable, CONCAT(p.primer_nombre,' ', p.paterno,' ', p.materno) as nombre_responsable, ek.nombre estado_kanban
        from actividades a, actividades_prioridades ap, niveles_pei np, personal p, estados_kanban ek
        where a.cod_prioridad=ap.codigo 
        and a.cod_componentepei=np.codigo 
        and a.cod_responsable   = p.codigo
        and a.cod_estadokanban  = ek.codigo 
        and a.codigo='$code_activity'";
    $stmtActividad= $dbh->prepare($sqlActividad);
    $stmtActividad->execute();
    
    $subAcitividades= listaSubActividades($code_activity, $dbh);
    $archivos      = listaArchivos($code_activity, $dbh);
    $anotacion     = listaAnotaciones($code_activity, $cod_personal, $dbh);
    $presupuestos  = listaPresupuesto($code_activity, $dbh);
    $colaboradores = listaColaboradores($code_activity, $dbh);
    echo json_encode(array(
        'subAcitividades' => $subAcitividades,
        'archivos'      => $archivos,
        'anotacion'     => $anotacion,
        'presupuestos'  => $presupuestos,
        'colaboradores' => $colaboradores,
        'data'          => $stmtActividad->fetch(PDO::FETCH_ASSOC)
    ));
}else if($_POST['type'] == 1){
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
        $stmt->execute();
        /* Lista de registros Archivos */
        $content = listaArchivos($code_activity, $dbh);
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
    $anotacion     = $_POST['annotation'];
    $date          = date('Y-m-d');
    try {
        $sqlInsert   ="INSERT INTO actividades_anotaciones (cod_actividad, cod_personal, fecha, anotacion, cod_estado)
        	            VALUES ('$code_activity','$cod_personal','$date','$anotacion','1')";
        $stmt        = $dbh->prepare($sqlInsert);
        $stmt->execute();
        /* Lista de registros anotaciones*/
        $content = listaAnotaciones($code_activity, $cod_personal, $dbh);
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
    $staff_code    = $_POST['cod_personal'];
    $date          = date('Y-m-d');
    try {
        // Verificación de colaboradores asignados
        $sqlVerf = "SELECT * FROM actividades_colaboradores WHERE cod_actividad = $code_activity AND cod_personal = $staff_code";
        $stmtVerf = $dbh->prepare($sqlVerf);
        $stmtVerf->execute();
        if(count($stmtVerf->fetchAll())){
            echo json_encode(array(
                'status'    => 3
            ));
        }else{
            $sqlInsert   ="INSERT INTO actividades_colaboradores (cod_actividad, cod_personal, fecha_designacion, cod_estado)
                            VALUES ('$code_activity','$staff_code','$date','1')";
            $stmt        = $dbh->prepare($sqlInsert);
            $stmt->execute();
            /* Lista de registros colaboradores */
            $content = listaColaboradores($code_activity, $dbh);
            echo json_encode(array(
                'status'    => true,
                'content'   => $content
            ));
        }
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}
/**
 * Eliminar Nota de Actividad de acuerdo al usuario registrado
 * method: POST
 * @autor: Ronald Mollericona
 **/
else if($_POST['type'] == 4){
    $code_annotation = $_POST['codigo'];
    try {
        // Verificación de colaboradores asignados
        $sqlDel = "UPDATE actividades_anotaciones SET cod_estado = 2 WHERE codigo = $code_annotation";
        $stmtDel = $dbh->prepare($sqlDel);
        $stmtDel->execute();
        echo json_encode(array(
            'status'    => true,
        ));
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}
/**
 * Registrar el presupuesto asignado a la actividad
 * method: POST
 * @autor: Ronald Mollericona
 **/
else if($_POST['type'] == 5){
    $cod_account = $_POST['cod_account'];
    $amount      = $_POST['amount'];
    $date        = $_POST['dateBudget'];
    try {
        $sqlInsert    = "INSERT INTO actividades_presupuestos (cod_actividad, cod_cuenta, fecha_ejecucion, monto, cod_estado_presupuesto)
                        VALUES ('$code_activity','$cod_account','$date','$amount','1')";
        $stmt         = $dbh->prepare($sqlInsert);
        $stmt->execute();
        /* Lista de registros */
        $content = listaPresupuesto($code_activity, $dbh);
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
 * Registrar Sub Actividad
 * method: POST
 * @autor: Ronald Mollericona
 **/
else if($_POST['type'] == 6){
    $sub_nombre    = $_POST['sub_nombre'];
    $sub_fecha     = $_POST['sub_fecha'];
    $sub_prioridad = $_POST['sub_prioridad'];
    try {
        /* Obtenemos Configuración estado inicial de KANBAN */
        $sqlFindState = "SELECT * FROM configuraciones
        WHERE id_configuracion = 1";
        $stmtFindState= $dbh->prepare($sqlFindState);
        $stmtFindState->execute();
        while ($rowFind = $stmtFindState->fetch(PDO::FETCH_ASSOC)) {
            $cod_estadokanban  = $rowFind['valor_configuracion'];
        }
        /* Insertar Datos */
        $sqlInsert    = "INSERT INTO actividades (nombre, cod_prioridad, cod_estadokanban, fecha_limite, cod_responsable, cod_padre)
                        VALUES ('$sub_nombre', '$sub_prioridad', '$cod_estadokanban', '$sub_fecha', '$cod_personal','$code_activity')";
        $stmt         = $dbh->prepare($sqlInsert);
        $stmt->execute();
        /* Se obtiene el ultimo registro */
        $sqlActivity = "SELECT * FROM actividades
        ORDER BY codigo DESC
        LIMIT 1";

        $stmtActividad= $dbh->prepare($sqlActivity);
        $stmtActividad->execute();
        while ($rowActividad = $stmtActividad->fetch(PDO::FETCH_ASSOC)) {
            $codigoActividad = $rowActividad['codigo'];
        }
        echo json_encode(array(
            'status'        => true,
            'code_activity' => $codigoActividad
        ));
    } catch (Exception $e) {
        echo json_encode(array(
            'status' => false
        ));
    }
}
/* Función Lista Archivos Adjuntos */
function listaArchivos($code_activity, $dbh){
    $sqlFile = "SELECT codigo, date_format(fecha, '%d-%m-%Y') as fecha, ruta, filesize, UPPER(extension) as extension 
        FROM actividades_archivos 
        WHERE cod_actividad = $code_activity 
        ORDER BY codigo DESC";
    $stmFile = $dbh->prepare($sqlFile);
    $stmFile->execute();
    $content = '';
    $rows_files = $stmFile->fetchAll();
    $array_color = ['primary', 'secondary', 'warning'];
    $count_array = count($array_color);
    foreach ($rows_files as $file){
        $color_val = $array_color[random_int(0, $count_array-1)];
        $content .= '
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
                            <a href="file_activity/'.$file['ruta'].'" download="pei_'.$file['ruta'].'" class="btn btn-link font-16 text-muted">
                                <i class="dripicons-download"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            ';
    }
    return $content;
}
/* Función Lista Anotaciones */
function listaAnotaciones($code_activity, $cod_personal, $dbh){
    $sqlNote = "SELECT ac.codigo, date_format(ac.fecha, '%d-%m-%Y') as fecha, ac.anotacion, ac.cod_personal, CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as personal
        FROM actividades_anotaciones ac
        LEFT JOIN personal p ON p.codigo = ac.cod_personal
        WHERE ac.cod_actividad = '$code_activity' 
        AND ac.cod_estado = 1
        ORDER BY ac.codigo DESC";
    $stmtNote = $dbh->prepare($sqlNote);
    $stmtNote->execute();
    $content = '';
    $rows_notes = $stmtNote->fetchAll();
    foreach ($rows_notes as $note){
        $delete = '';
        if($note['cod_personal'] == $cod_personal){
            $delete = '<a href="javascript:(0);" class="btn btn-sm btn-link text-danger font-15 remove-note" data-codigo="'.$note['codigo'].'"><i class="fe-x"></i></a>';
        }
        $content .= '
        <div class="inbox-item item-note-'.$note['codigo'].'">
            <div class="inbox-item-img">
                <img src="assets2/images/users/default.png" class="rounded-circle" alt="perfil">
            </div>
            <p class="inbox-item-author">'.$note['personal'].'</p>
            <p class="inbox-item-text">'.$note['anotacion'].'</p>
            <p class="inbox-item-date">
                '.$note['fecha'].$delete.'
            </p>
        </div>
        ';
    }
    return $content;
}
/* Función Lista presupuesto */
function listaPresupuesto($code_activity, $dbh){
    $sqlAccount = "SELECT ap.codigo, date_format(ap.fecha_ejecucion, '%d-%m-%Y') as fecha, ap.monto, UPPER(p.nombre) as nombre
        FROM actividades_presupuestos ap
        LEFT JOIN plan_cuentas p ON p.codigo = ap.cod_cuenta
        WHERE ap.cod_actividad = '$code_activity' 
        ORDER BY ap.codigo DESC";
    $stmtAccount = $dbh->prepare($sqlAccount);
    $stmtAccount->execute();
    $content = '';
    $rows_account = $stmtAccount->fetchAll();
    foreach ($rows_account as $account){
        $content .= '
        <div class="inbox-item">
            <div class="row">
                <div class="col-md-8 inbox-item-text">
                    <p class="inbox-item-author">'.$account['nombre'].'</p>
                    <p class="mb-0 text-success"><i class="fe-file"></i>'.$account['monto'].' bs.</p>
                </div>
                <div class="col-md-4 inbox-item-date p-0 text-right">
                '.$account['fecha'].'
                </div>
            </div>
        </div>
        ';
    }
    return $content;
}
/* Función Lista Colaboradores */
function listaColaboradores($code_activity, $dbh){
    $sqlColl = "SELECT CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as nombre_compl, DATE_FORMAT(ac.fecha_designacion, '%d-%m-%Y') as fecha
            FROM actividades_colaboradores ac
            LEFT JOIN personal p on p.codigo = ac.cod_personal
            WHERE ac.cod_actividad = '$code_activity'";
    $stmtColl = $dbh->prepare($sqlColl);
    $stmtColl->execute();
    $content = '';
    $rows_coll = $stmtColl->fetchAll();
    foreach ($rows_coll as $collaborator){
        $content .= '
        <div class="inbox-item">
            <div class="d-flex align-items-start">
                <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                <div class="w-100">
                    <h5 class="mt-0 mt-1 mb-0 font-size-14">
                        '.$collaborator['nombre_compl'].'
                    </h5>
                </div>
            </div>
        </div>
        ';
    }
    return $content;
}
/* Función Lista Colaboradores */
function listaSubActividades($code_activity, $dbh){
    $sqlSubActivity = "SELECT codigo, nombre, fecha_limite
    FROM actividades
    WHERE cod_padre = '$code_activity'
    ORDER BY codigo DESC";
    $stmtSubActivity = $dbh->prepare($sqlSubActivity);
    $stmtSubActivity->execute();
    $content = '';
    $rows_sub_acivities = $stmtSubActivity->fetchAll();
    foreach ($rows_sub_acivities as $sub_activity){
        $content .= '
        <div class="inbox-item">
            <div class="row">
                <div class="col-md-13 inbox-item-text">
                    <p class="inbox-item-author show-activity" data-cod_actividad="'.$sub_activity['codigo'].'" style="cursor:pointer;"><i class="fe-file text-danger"></i> '.$sub_activity['nombre'].'</p>
                </div>
            </div>
        </div>
        ';
    }
    return $content;
}
?>