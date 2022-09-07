<?php

require_once '../conexion.php';
session_start();
$dbh = new Conexion();
$codigoActividad = $_GET["codigo_actividad"];
$cod_personal    = $_SESSION['globalUser'];

$sqlActividad="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
(select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei, np.nombre as nombreproyecto from actividades a, actividades_prioridades ap, niveles_pei np where a.cod_prioridad=ap.codigo and a.cod_componentepei=np.codigo and a.codigo='$codigoActividad'";

$stmtActividad= $dbh->prepare($sqlActividad);
$stmtActividad->execute();
$nombreActividad="";
$nombreProyecto="";
while ($rowActividad = $stmtActividad->fetch(PDO::FETCH_ASSOC)) {
    $codigoActividad=$rowActividad['codigo'];
	$nombreActividad=$rowActividad['nombre'];
	$nombreProyecto=$rowActividad['nombreproyecto'];
}
    /**********************************************/
    $array_color = ['primary', 'secondary', 'warning'];
    $count_array = count($array_color);
    /**
     * Lista de Archivos de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlActividadFiles="SELECT codigo, fecha, ruta, filesize, extension from actividades_archivos where cod_actividad = '$codigoActividad' ORDER BY codigo DESC";
    $stmtActividadFiles= $dbh->prepare($sqlActividadFiles);
    $stmtActividadFiles->execute();

    /**
     * Lista de Notas de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlNote="SELECT ac.codigo, date_format(ac.fecha, '%d-%m-%Y') as fecha, ac.anotacion, ac.cod_personal, CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as personal
    FROM actividades_anotaciones ac
    LEFT JOIN personal p ON p.codigo = ac.cod_personal
    WHERE ac.cod_actividad = '$codigoActividad' 
    AND ac.cod_estado = 1
    ORDER BY ac.codigo DESC";
    $stmtNote= $dbh->prepare($sqlNote);
    $stmtNote->execute();
    
    /**
     * Lista de Colaboradores asignados a la Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlColl = "SELECT CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as nombre_compl, DATE_FORMAT(ac.fecha_designacion, '%d-%m-%Y') as fecha
    FROM actividades_colaboradores ac
    LEFT JOIN personal p on p.codigo = ac.cod_personal
    WHERE cod_actividad = $codigoActividad";
    $stmtColl = $dbh->prepare($sqlColl);
    $stmtColl->execute();

    /**
     * Lista de Presupuestos asignados a la actividad
     * @autor: Ronald Mollericona
    **/
    $sqlAccount = "SELECT ap.codigo, date_format(ap.fecha_ejecucion, '%d-%m-%Y') as fecha, ap.monto, UPPER(p.nombre) as nombre
    FROM actividades_presupuestos ap
    LEFT JOIN plan_cuentas p ON p.codigo = ap.cod_cuenta
    WHERE ap.cod_actividad = '$codigoActividad' 
    ORDER BY ap.codigo DESC";
    $stmtAccount = $dbh->prepare($sqlAccount);
    $stmtAccount->execute();

?>
<div id="bodyTaskComplete">    
    <div class="modal-header bg-primary">
        <h5 class="modal-title text-white" id="scrollableModalTitle">Actividad <?=$nombreActividad;?>  Proyecto: <?=$nombreProyecto;?></h5>
        <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div class="row">
    		<div class="col-md-8">
                <!-- Nueva Nota-->
                <div class="card p-2 mb-1 border">
                    <h5 class="card-title font-16 text-primary"><i class="fe-airplay"></i> Detalle</h5>
                    <div class="border rounded">
                        <form action="#" class="comment-area-box">
                            <textarea rows="3" class="form-control border-0 resize-none" id="annotation" placeholder="Escriba una nota.."></textarea>
                            <div class="p-2 bg-light d-flex justify-content-between align-items-center">
                                <div class="file-select" id="src-file1" >
                                    <input type="file" id="src-file1-input" name="src-file1" aria-label="Archivo">
                                </div>
                                <button type="button" class="btn btn-sm btn-success" id="save-annotation"><i class="mdi mdi-send"></i> Enviar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- ARCHIVOS -->
                <input type="text" id="codeActivity" value="<?=$codigoActividad;?>" hidden>
                <div class="card p-2 mb-1 border">
                    <h5 class="card-title font-16 text-primary"><i class="fe-download-cloud"></i> Archivos adjuntos</h5>
                    <div class="inbox-widget component-file" data-simplebar style="max-height: 200px;">
                        <?php
                            if(!count($rows_files = $stmtActividadFiles->fetchAll())){
                        ?>
                            <div class="card mb-1 shadow-none border">
                                <div class="p-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto">
                                            <div class="avatar-sm">
                                                <span class="avatar-title badge-soft-danger text-danger rounded">
                                                    X
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col ps-0">
                                            <h5 class="mt-0 mb-0 text-muted">No hay archivos adjuntos</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php
                            }else{
                            foreach ($rows_files as $file){
                        ?>   
                            <div class="card shadow-none border">
                                <div class="p-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto">
                                            <div class="avatar-sm">
                                                <?php $color_val = $array_color[random_int(0, $count_array-1)]; ?>
                                                <span class="avatar-title badge-soft-<?= $color_val; ?> text-<?= $color_val; ?> rounded">
                                                    <?=strtoupper($file['extension']);?>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col ps-0">
                                            <a href="file_activity/<?=$file['ruta'];?>" download="pei_<?=$file['ruta']?>" class="text-muted fw-bold"><?=$file['ruta'];?></a>
                                            <p class="mb-0 font-12"><?=$file['filesize'];?></p>
                                        </div>
                                        <div class="col-auto">
                                            <a href="file_activity/<?=$file['ruta'];?>" download="pei_<?=$file['ruta']?>" class="btn btn-link font-16 text-muted">
                                                <i class="dripicons-download"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <!-- FIN NOTAS -->
                <div class="card p-2 border">
                    <h5 class="card-title font-16 text-primary"><i class="fe-feather"></i> Notas</h5>
                    <!-- Lista de Notas -->
                    <div class="inbox-widget component-annotation" data-simplebar style="max-height: 350px;">
                        <?php
                            if(!count($rows_notes = $stmtNote->fetchAll())){
                        ?>
                            <div class="card shadow-none border">
                                <div class="p-2">
                                    <div class="row align-items-center">
                                        <div class="col-auto">
                                            <div class="avatar-sm">
                                                <span class="avatar-title badge-soft-danger text-danger rounded">
                                                    <i class="fe-message-circle"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col ps-0">
                                            <h5 class="mt-0 mb-0 text-muted">No hay notas registradas.</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php
                            }else{
                                foreach ($rows_notes as $note){
                        ?>
                            <div class="inbox-item item-note-<?=$note['codigo'];?>">
                                <div class="inbox-item-img">
                                    <img src="assets2/images/users/default.png" class="rounded-circle" alt="perfil">
                                </div>
                                <p class="inbox-item-author"><?=$note['personal'];?></p>
                                <p class="inbox-item-text"><?=$note['anotacion'];?></p>
                                <p class="inbox-item-date">
                                    <?=$note['fecha'];?>
                                    <?php
                                        if($note['cod_personal'] == $cod_personal){
                                    ?>
                                    <a href="javascript:(0);" class="btn btn-sm btn-link text-danger font-15 remove-note" data-codigo="<?=$note['codigo'];?>"><i class="fe-x"></i></a>
                                    <?php
                                        }
                                    ?>
                                </p>
                            </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <!-- Fin lista de Notas -->
            </div>
    		<div class="col-md-4">
                <!-- Presupuesto-->
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <button type="button" class="btn btn-success btn-sm addBudget float-end pl-1 pr-1">
                            <i class="mdi mdi-plus"></i> Nuevo
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-tag"></i> Presupuesto</h5>
                    </div>
                    <div class="inbox-widget component-budget" data-simplebar style="max-height: 250px;">
                        <?php
                            if(!count($rows_account = $stmtAccount->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-user-x"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted">Actividad sin presupuesto...</h5>
                                </div>
                            </div>
                        </div> 
                        <?php
                            }else{
                                foreach ($rows_account as $account){
                        ?>
                            <div class="inbox-item">
                                <div class="row">
                                    <div class="col-md-8 inbox-item-text">
                                        <p class="inbox-item-author"><?=$account['nombre'];?></p>
                                        <p class="mb-0 text-success"><i class="fe-file"></i> <?=$account['monto'];?> bs.</p>
                                    </div>
                                    <div class="col-md-4 inbox-item-date p-0 text-right">
                                    <?=$account['fecha'];?>
                                    </div>
                                </div>
                            </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <!-- Colaboradores-->
                <div class="card p-2 mb-1 border">
                    <div>
                        <button type="button" class="btn btn-success btn-sm addCollaborator float-end pl-1 pr-1">
                            <i class="mdi mdi-plus"></i> Nuevo
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-users"></i> Colaboradores</h5>
                    </div>
                    <div class="inbox-widget component-collaborator" data-simplebar style="max-height: 350px;">
                        <?php
                            if(!count($rows_coll = $stmtColl->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-user-x"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted">Actividad sin colaboradores...</h5>
                                </div>
                            </div>
                        </div> 
                        <?php
                            }else{
                                foreach ($rows_coll as $collaborator){
                        ?>
                        <!-- <div class="mt-2" id="tooltips-container">
                            <a href="javascript:void(0);" class="d-inline-block">
                                <img src="assets2/images/users/default.png" class="rounded-circle avatar-xs" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="top" title="Mat Helme">
                            </a>
                        </div> -->
                        <div class="inbox-item">
                            <div class="d-flex align-items-start">
                                <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                                <div class="w-100">
                                    <h5 class="mt-0 mt-1 mb-0 font-size-14">
                                        <?=$collaborator['nombre_compl'];?>
                                    </h5>
                                </div>
                            </div>
                        </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
            </div>
    	</div>
    </div>
</div>
    