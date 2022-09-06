<?php

require_once '../conexion.php';
$dbh = new Conexion();
$codigoActividad=$_GET["codigo_actividad"];

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
    $sqlNote="SELECT date_format(fecha, '%d-%m-%Y') as fecha, anotacion from actividades_anotaciones where cod_actividad = '$codigoActividad' ORDER BY codigo DESC";
    $stmtNote= $dbh->prepare($sqlNote);
    $stmtNote->execute();

?>
<div id="bodyTaskComplete">    
    <div class="modal-header">
        <h5 class="modal-title" id="scrollableModalTitle">Actividad <?=$nombreActividad;?>  Proyecto: <?=$nombreProyecto;?></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div class="row">
    		<div class="col-lg-8">
                <!-- Nueva Nota-->
                <div class="card p-2">
                    <h5 class="card-title font-16">Detalle de Actividad</h5>
                    <div class="border rounded">
                        <form action="#" class="comment-area-box">
                            <textarea rows="3" class="form-control border-0 resize-none" id="annotation" placeholder="Escriba una nota.."></textarea>
                            <div class="p-2 bg-light d-flex justify-content-between align-items-center">
                                <div class="file-select" id="src-file1" >
                                    <input type="file" id="src-file1-input" name="src-file1" aria-label="Archivo">
                                </div>
                                <button type="button" class="btn btn-sm btn-primary" id="save-annotation"><i class="mdi mdi-account me-1"></i>Agregar Colaborador</button>
                                <button type="button" class="btn btn-sm btn-success" id="save-annotation"><i class="mdi mdi-send me-1"></i>Enviar Nota</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- ARCHIVOS -->
                <input type="text" id="codeActivity" value="<?=$codigoActividad;?>" hidden>
                <div class="card p-2">
                    <h5 class="card-title font-16">Archivos adjuntos</h5>
                    <div class="component-file">
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
                                            <h5 class="mt-0 mb-0 font-size-14">No hay archivos adjuntos</h5>
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
                <div class="card p-2">
                    <h5 class="card-title font-16">Notas</h5>
                    <!-- Lista de Notas -->
                    <div class="component-annotation">
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
                                            <h5 class="mt-0 mb-0 font-size-14">No hay notas registradas.</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php
                            }else{
                                foreach ($rows_notes as $note){
                        ?>                      
                                <div class="d-flex align-items-start p-1">
                                    <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                                    <div class="w-100">
                                        <h5 class="mt-0 mb-0 font-size-14 pt-1">
                                            <span class="float-end text-muted font-12"><?=$note['fecha'];?></span>
                                            <?=$note['anotacion'];?>
                                        </h5>
                                    </div>
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
                <div class="card p-2">
                    <h5 class="card-title font-16">Colaboradores</h5>
                    <div class="post-user-comment-box m-1">
                        <div class="d-flex align-items-start">
                            <div class="d-flex align-items-start">
                                <img src="assets2/images/users/default.png" class="me-2 rounded-circle" height="36" alt="Perfil">
                                <div class="w-100">
                                    <h5 class="mt-0 mt-1 mb-0 font-size-14">
                                        Ronald Mollericona
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    	</div>
    </div>
</div>
    