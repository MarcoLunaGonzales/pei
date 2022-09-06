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

    /**
     * Lista de Archivos de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlActividadFiles="SELECT fecha, ruta, extension from actividades_archivos where cod_actividad = '$codigoActividad'";
    $stmtActividadFiles= $dbh->prepare($sqlActividadFiles);
    $stmtActividadFiles->execute();

    $stmtActividadFiles->bindColumn('fecha', $fecha);
    $stmtActividadFiles->bindColumn('ruta', $ruta);
    $stmtActividadFiles->bindColumn('extension', $extension);
    /**
     * Lista de Notas de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlNote="SELECT fecha, anotacion from actividades_anotaciones where cod_actividad = '$codigoActividad'";
    $stmtNote= $dbh->prepare($sqlNote);
    $stmtNote->execute();

    $stmtNote->bindColumn('fecha', $fecha);
    $stmtNote->bindColumn('anotacion', $anotacion);
?>
<div id="bodyTaskComplete">    
    <div class="modal-header">
        <h5 class="modal-title" id="scrollableModalTitle">Actividad <?=$nombreActividad;?>  Proyecto: <?=$nombreProyecto;?></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div class="row">
    		<div class="col-lg-8">
                <!-- ARCHIVOS -->
                <input type="text" id="codeActivity" value="<?=$codigoActividad;?>" hidden>
                <div class="card mb-3">
                    <label for="example-textarea" class="form-label">Archivos adjuntos:</label>
                    <!-- <div class="card mb-1 shadow-none border">
                        <div class="p-2">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-danger text-white rounded">
                                            X
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 font-size-14">No hay archivos adjuntos</h5>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <?php
                        while ($rowaf = $stmtActividadFiles->fetch(PDO::FETCH_BOUND)) {
                    ?>
                        <div class="card mb-1 shadow-none border">
                            <div class="p-2">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <div class="avatar-sm">
                                            <span class="avatar-title badge-soft-primary text-primary rounded">
                                                <?=strtoupper($extension);?>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col ps-0">
                                        <a href="file_activity/<?=$ruta;?>" download="pei_<?=$ruta?>" class="text-muted fw-bold"><?=$ruta;?></a>
                                        <p class="mb-0 font-12">2.3 MB</p>
                                    </div>
                                    <div class="col-auto">
                                        <!-- Button -->
                                        <a href="javascript:void(0);" class="btn btn-link font-16 text-muted">
                                            <i class="dripicons-download"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php
                            }
                    ?>
                </div>
                <!-- FIN NOTAS -->
                <label for="example-textarea" class="form-label">Notas:</label>
                <!-- Lista de Notas -->
                    <?php
                        while ($rown = $stmtNote->fetch(PDO::FETCH_BOUND)) {
                    ?>                      
                        <div class="d-flex align-items-start p-1">
                            <img src="assets2/images/users/user-9.jpg" class="me-2 rounded-circle" height="36" alt="Arya Stark">
                            <div class="w-100">
                                <h5 class="mt-0 mb-0 font-size-14">
                                    <span class="float-end text-muted font-12"><?=date('d-m-Y', strtotime($fecha));?></span>
                                    <?=$anotacion;?>
                                </h5>
                                <!-- <p class="mt-1 mb-0 text-muted">
                                    Se deberia revisar el diseno del proyecto.
                                </p> -->
                            </div>
                        </div>
                    <?php
                        }
                    ?>
                <!-- Fin lista de Notas -->
                <!-- Nueva Nota-->
                <div class="mt-3">
                    <label for="example-textarea" class="form-label">Nueva nota:</label>
                    <div class="row">
                        <div class="col-md-12">
                            <textarea class="form-control" id="annotation" rows="3" placeholder="Escriba una nota.."></textarea>
                        </div>
                        <div class="col-md-12 text-rigth">
                            <button type="button" class="btn btn-primary btn-block border" id="save-annotation"> Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 pt-3">
                <div class="file-select" id="src-file1" >
                    <input type="file" id="src-file1-input" name="src-file1" aria-label="Archivo">
                </div>
            </div>
    	</div>
    </div>
</div>
    