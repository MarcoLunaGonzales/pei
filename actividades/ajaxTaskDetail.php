<?php

require_once '../conexion.php';
session_start();
$dbh = new Conexion();
$codigoActividad = $_GET["codigo_actividad"];
$cod_personal    = $_SESSION['globalUser'];

/* Verificación de Tipo de Actividad(Padre o Sub-Actividad) */
$sqlVerf = "SELECT * FROM actividades WHERE codigo = '$codigoActividad'";
$stmtVerf= $dbh->prepare($sqlVerf);
$stmtVerf->execute();

/* Obtenemos Configuración de ruta de imagenes */
$sqlFind = "SELECT * FROM configuraciones
WHERE id_configuracion = 2";
$stmtFind = $dbh->prepare($sqlFind);
$stmtFind->execute();
while ($row = $stmtFind->fetch(PDO::FETCH_ASSOC)) {
    $ruta  = $row['valor_configuracion'];
}
/* Obtenemos Configuración estado inicial de KANBAN */
$sqlFindState = "SELECT * FROM configuraciones
WHERE id_configuracion = 1";
$stmtFindState= $dbh->prepare($sqlFindState);
$stmtFindState->execute();
while ($rowFind = $stmtFindState->fetch(PDO::FETCH_ASSOC)) {
	$codEstadoKanban = $rowFind["valor_configuracion"];
}

$verf_sub_activity = true;     // Verificación de SubActividad
$subA_start_date   = '';       // Validación Fecha Inicio
$subA_limit_date   = '';       // Validación Fecha limite
$codigo_padre      = '';       // Codigo padre de Actividad

while ($rowVerf = $stmtVerf->fetch(PDO::FETCH_ASSOC)) {
    if(!empty($rowVerf['cod_padre'])){
        $verf_sub_activity = false;
        $codigo_padre    = $rowVerf['cod_padre'];
        $actividad_padre = $rowVerf['nombre'];
    }
}

    if(!$verf_sub_activity){
        $sqlActividad="SELECT a.codigo, 
            a.nombre, 
            a.observaciones, 
            DATE_FORMAT(a.fecha_limite,'%d-%m-%Y')as fecha_limite, 
            a.cod_prioridad, 
            ap.nombre as nombre_prioridad, 
            ap.color,
            a.cod_padre as cod_padre,
            a.observaciones as obs,
            a.cod_responsable,
            CONCAT(p.primer_nombre,' ', p.paterno,' ', p.materno) as nombre_responsable,
            ek.codigo cod_estado, 
            ek.nombre estado_kanban,
            pimg.imagen as imagen_personal,
            DATE_FORMAT(ace.fecha,'%d-%m-%Y')as fecha_inicial
        from actividades a, actividades_prioridades ap, personal p, estados_kanban ek, personalimagen pimg, actividades_cambios_estado ace
        where a.cod_prioridad   = ap.codigo
        and a.cod_responsable   = p.codigo 
        and a.cod_estadokanban  = ek.codigo 
        and a.cod_responsable = pimg.codigo
        and a.codigo = ace.cod_actividad
        and ace.cod_estadoactividad = $codEstadoKanban
        and a.codigo = '$codigoActividad'";
        // Datos de Actividad Padre
        $sqlPadre  = "SELECT a.fecha_limite as fecha_limite, DATE_FORMAT(ace.fecha,'%d-%m-%Y')as fecha_inicial
        FROM actividades a, actividades_cambios_estado ace
        WHERE a.codigo = $codigo_padre
        and a.codigo = ace.cod_actividad
        and ace.cod_estadoactividad = $codEstadoKanban";
        $stmtPadre = $dbh->prepare($sqlPadre);
        $stmtPadre->execute();
        while ($rowPadre    = $stmtPadre->fetch(PDO::FETCH_ASSOC)) {
            $subA_limit_date = $rowPadre['fecha_limite'];
            $subA_start_date = $rowPadre['fecha_inicial'];
        }
    }else{
        $sqlActividad="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%d-%m-%Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
        (select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei, np.nombre as nombreproyecto, a.cod_padre as cod_padre, a.observaciones as obs, a.cod_responsable, CONCAT(p.primer_nombre,' ', p.paterno,' ', p.materno) as nombre_responsable, ek.codigo cod_estado, ek.nombre estado_kanban,
        pimg.imagen as imagen_personal, DATE_FORMAT(ace.fecha,'%d-%m-%Y')as fecha_inicial
        from actividades a, actividades_prioridades ap, niveles_pei np, personal p, estados_kanban ek, personalimagen pimg, actividades_cambios_estado ace
        where a.cod_prioridad=ap.codigo 
        and a.cod_componentepei=np.codigo 
        and a.cod_responsable   = p.codigo
        and a.cod_estadokanban  = ek.codigo 
        and a.cod_responsable = pimg.codigo
        and a.codigo = ace.cod_actividad
        and ace.cod_estadoactividad = $codEstadoKanban
        and a.codigo='$codigoActividad'";
    }
    
    //echo $sqlActividad;

    $stmtActividad= $dbh->prepare($sqlActividad);
    $stmtActividad->execute();
    
    $nombreActividad="";
    $codigoActividad=0;
    $obs="";
    $fechaInicial="";
    $fechaLimite="";
    $nombre_responsable="";
    $estado_kanban=0;
    $cod_estado=0;
    $imagen_personal="";
    $nombreProyecto="";

    while ($rowActividad    = $stmtActividad->fetch(PDO::FETCH_ASSOC)) {
        $codigoActividad    = $rowActividad['codigo'];
        $obs                = $rowActividad['obs'];
        $nombreActividad    = $rowActividad['nombre'];
        $fechaInicial       = $rowActividad['fecha_inicial'];
        $fechaLimite        = $rowActividad['fecha_limite'];
        $nombre_responsable = $rowActividad['nombre_responsable'];
        $estado_kanban      = $rowActividad['estado_kanban'];
        $cod_estado         = $rowActividad['cod_estado'];
        $imagen_personal    = $rowActividad['imagen_personal'];
        $nombreProyecto     = ($verf_sub_activity)?$rowActividad['nombreproyecto']:'';
       
    }
    /**********************************************/
    $array_color = ['primary', 'secondary', 'warning'];
    $count_array = count($array_color);
    /**
     * Lista de Archivos de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlActividadFiles="SELECT codigo, detalle, fecha, ruta, filesize, extension from actividades_archivos where cod_actividad = '$codigoActividad' ORDER BY codigo DESC";
    $stmtActividadFiles= $dbh->prepare($sqlActividadFiles);
    $stmtActividadFiles->execute();

    /**
     * Lista de Notas de Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlNote="SELECT an.codigo, date_format(an.fecha, '%d-%m-%Y') as fecha, an.anotacion, an.cod_personal, CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as personal, pimg.imagen as imagen_personal
    FROM actividades_anotaciones an
    LEFT JOIN personal p ON p.codigo = an.cod_personal
    LEFT JOIN personalimagen pimg on pimg.codigo = an.cod_personal
    WHERE an.cod_actividad = '$codigoActividad' 
    AND an.cod_estado = 1
    ORDER BY an.codigo DESC";
    $stmtNote= $dbh->prepare($sqlNote);
    $stmtNote->execute();
    
    /**
     * Lista de Colaboradores asignados a la Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlColl = "SELECT ac.cod_personal as codigo_personal, CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as nombre_compl, 
    DATE_FORMAT(ac.fecha_designacion, '%d-%m-%Y') as fecha,
    pimg.imagen as imagen_personal,
    ac.cod_estado as estado
    FROM actividades_colaboradores ac
    LEFT JOIN personal p on p.codigo = ac.cod_personal
    LEFT JOIN personalimagen pimg on pimg.codigo = ac.cod_personal
    WHERE ac.cod_actividad = $codigoActividad
    AND ac.cod_estado = 1";
    $stmtColl = $dbh->prepare($sqlColl);
    $stmtColl->execute();

    /**
     * Lista de Presupuestos asignados a la actividad
     * @autor: Ronald Mollericona
    **/
    $sqlAccount = "SELECT ap.codigo, date_format(ap.fecha_ejecucion, '%d-%m-%Y') as fecha, ap.monto, UPPER(p.nombre) as nombre, ac.nombre as nombre_estado, ac.estado_etiqueta as etiqueta, ap.cod_estado_presupuesto as estado_presupuesto
    FROM actividades_presupuestos ap
    LEFT JOIN plan_cuentas p ON p.codigo = ap.cod_cuenta
    LEFT JOIN estados_actividades_presupuesto ac ON ac.codigo = ap.cod_estado_presupuesto
    WHERE ap.cod_actividad = '$codigoActividad'
    AND ap.cod_estado = 1
    AND ap.cod_estado_presupuesto > 0
    ORDER BY ap.codigo DESC";
    $stmtAccount = $dbh->prepare($sqlAccount);
    $stmtAccount->execute();
    
    /**
     * Lista de Sub-Actividades relacionadas a la Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlSubActivity = "SELECT codigo, nombre, fecha_limite
    FROM actividades
    WHERE cod_padre = '$codigoActividad'
    ORDER BY codigo DESC";
    $stmtsubActivity = $dbh->prepare($sqlSubActivity);
    $stmtsubActivity->execute();

    /**
     * Lista de Hitos relacionadas a la Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlHito = "SELECT ah.codigo, 
                ah.cod_actividad, 
                ah.cod_personal,
                date_format(ah.fecha_registro, '%d-%m-%Y') as fecha_registro,
                date_format(ah.fecha_hito, '%d-%m-%Y') as fecha_hito,
                ah.nombre,
                ah.cod_estado
    FROM actividades_hitos ah
    WHERE ah.cod_actividad = '$codigoActividad'
    AND ah.cod_estado = 1
    ORDER BY ah.codigo DESC";
    $stmtHito = $dbh->prepare($sqlHito);
    $stmtHito->execute();

    /**
     * Lista de Funciones relacionadas a la Actividad
     * @autor: Ronald Mollericona
    **/
    $sqlFuncion = "SELECT afc.codigo, cf.nombre_funcion
    FROM actividades_funciones_cargo afc
    LEFT JOIN cargos_funciones cf ON cf.cod_funcion = afc.cod_funcion_cargo
    WHERE afc.cod_actividad = '$codigoActividad'
    AND afc.cod_estado = 1";
    $stmtFuncion = $dbh->prepare($sqlFuncion);
    $stmtFuncion->execute();

    /**
     * Seguimiento de estado de actividad
     * @autor: Ronald Mollericona
    **/
    $sqlSeguimiento = "SELECT ace.codigo, 
    DATE_FORMAT(ace.fecha,'%d-%m-%Y') as fecha, 
    DATE_FORMAT(ace.fecha,'%H:%i') as hora,
    ek.color,
    ek.icon,
    CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as empleado,
    ek.nombre as nombre_estado,
    ek.codigo as cod_estado
    FROM actividades_cambios_estado ace
    LEFT JOIN personal p ON p.codigo = ace.cod_personal
    LEFT JOIN estados_kanban ek ON ek.codigo = ace.cod_estadoactividad
    WHERE ace.cod_actividad = '$codigoActividad'
    ORDER BY ace.codigo DESC";
    $stmtSeguimiento = $dbh->prepare($sqlSeguimiento);
    $stmtSeguimiento->execute();
    
    
?>
<div id="bodyTaskComplete">    
    <div class="modal-header bg-<?= ($verf_sub_activity)?'primary':'warning'; ?>">
        <h5 class="modal-title text-white" id="scrollableModalTitle"><?= ($verf_sub_activity)?'Actividad':'Sub-Actividad'; ?></h5>
        <button type="button" class="btn-close bg-white" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div class="row">
    		<div class="col-md-8">
                <!-- Nueva Nota-->
                <div class="card p-2 pt-0 mb-1 border">
                    <div class="row">
                        <div class="col-4">
                            <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Nombre</p>
                            <div class="d-flex align-items-start">
                                <!-- Información -->
                                <div class="w-100 data_select" style="cursor:pointer;" data-select="1" data-inp="name_up">
                                    <h5 class="mt-1 font-size-14">
                                        <i class='fe-award font-16 text-danger'></i> <?=$nombreActividad;?>
                                    </h5>
                                </div>
                                <!-- Actualzación -->
                                <input type="text" class="form-control data_update" id="name_up" placeholder="Ingresar nombre de actividad" value="<?=$nombreActividad;?>" style="display:none;">
                            </div>
                        </div>
                        <?php if($verf_sub_activity){ ?>
                            <div class="col-md-4">
                                <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Proyecto</p>
                                <div class="d-flex align-items-start">
                                    <div class="w-100">
                                        <h5 class="mt-1 font-size-14">
                                            <i class='fe-file font-16 text-warning'></i> <?=$nombreProyecto;?>
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        <?php } ?>
                        <div class="col-md-4">
                            <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Responsable</p>
                            <div class="d-flex align-items-start">
                                <img src="<?=$ruta?><?=$imagen_personal;?>" alt="Arya S" class="rounded-circle me-2" height="24" />
                                <!-- Información -->
                                <div class="w-100 data_select" style="cursor:pointer;" data-select="2" data-inp="responsible_up">
                                    <h5 class="mt-1 font-size-14">
                                        <?=$nombre_responsable;?>
                                    </h5>
                                </div>
                                
                                <!-- Actualzación -->
                                <select name="responsible_up" id="responsible_up" class="form-control data_update"  style="display:none;">
                                    <?php             
                                        $sqlColl   = "SELECT codigo, CONCAT(primer_nombre, ' ', paterno, ' ',materno) as nombre_personal 
                                        FROM personal 
                                        WHERE cod_estadopersonal = 1
                                        ORDER BY nombre_personal ASC";
                                        $stmtC  = $dbh->prepare($sqlColl);
                                        $stmtC->execute();
                                        $rows_collaborators = $stmtC->fetchAll();
                                        foreach ($rows_collaborators as $collabolator){       
                                    ?>
                                    <option value="<?= $collabolator['codigo']; ?>"  ><?= $collabolator['nombre_personal']; ?></option>
                                    <?php 
                                        }   
                                    ?>
                                </select> 
                            </div>
                        </div>
                        <div class="col-md-4">
                            <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Fecha Inicio</p>
                            <div class="d-flex align-items-start">
                                <!-- Información -->
                                <div class="w-100 data_select" style="cursor:pointer;" data-select="3" data-inp="date_start_up">
                                    <h5 class="mt-1 font-size-14">
                                        <i class="fe-check-square font-16 text-primary"></i> <?=$fechaInicial;?>
                                    </h5>
                                </div>
                                <!-- Actualzación -->
                                <?php
                                    if(!$verf_sub_activity){
                                ?>
                                    <input type="date" min="<?=date('Y-m-d', strtotime($subA_start_date));?>" max="<?=date('Y-m-d', strtotime($subA_limit_date));?>" class="form-control data_update" id="date_start_up" value="<?=date('Y-m-d', strtotime($fechaInicial));?>" style="display:none;">
                                <?php
                                    }else{
                                ?>
                                    <input type="date" class="form-control data_update" id="date_start_up" value="<?=date('Y-m-d', strtotime($fechaInicial));?>" style="display:none;">
                                <?php
                                    }
                                ?>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Fecha Limite</p>
                            <div class="d-flex align-items-start">
                                <!-- Información -->
                                <div class="w-100 data_select" style="cursor:pointer;" data-select="4" data-inp="date_end_up">
                                    <h5 class="mt-1 font-size-14">
                                        <i class='fe-calendar font-16 text-success'></i> <?=$fechaLimite;?>
                                    </h5>
                                </div>
                                <!-- Actualzación -->
                                <?php
                                    if(!$verf_sub_activity){
                                ?>
                                    <input type="date" max="<?=date('Y-m-d', strtotime($subA_limit_date));?>" class="form-control data_update" id="date_end_up" value="<?=date('Y-m-d', strtotime($fechaLimite));?>" style="display:none;">
                                <?php
                                    }else{
                                ?>
                                    <input type="date" class="form-control data_update" id="date_end_up" value="<?=date('Y-m-d', strtotime($fechaLimite));?>" style="display:none;">
                                <?php
                                    }
                                ?>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <p class="mt-2 mb-1 text-muted">
                                <i class="fe-chevron-right"></i> Estado 
                                <!-- Paralizar -->
                                <?php if($cod_estado == 2){?>
                                    <i class="fe-alert-octagon text-danger data_update_state" data-select="5" data-state="5"></i>
                                <?php }?>
                                <!-- Continuar en Proceso -->
                                <?php if($cod_estado == 5){?>
                                    <i class="fe-check-circle text-success data_update_state" data-select="5" data-state="2"></i>
                                <?php }?>
                            </p>
                            <div class="d-flex align-items-start">
                                <!-- Información para actualizar -->
                                <h5 class="mt-1 font-size-14 <?=($cod_estado < 4 ?'data_select':'');?>" style="cursor:pointer;" data-select="5" data-inp="state_up">
                                    <i class='fe-bell font-16 text-warning'></i> <?=$estado_kanban;?>
                                </h5>
                                <!-- Actualzación -->
                                <select name="state_up" id="state_up" class="form-control data_update"  style="display:none;">
                                    <?php             
                                        $sqlColl   = "SELECT codigo, nombre 
                                        FROM estados_kanban 
                                        WHERE codigo >= $cod_estado
                                        AND codigo < 5
                                        ORDER BY codigo ASC";
                                        $stmtState = $dbh->prepare($sqlColl);
                                        $stmtState->execute();
                                        $rows_state = $stmtState->fetchAll();
                                        foreach ($rows_state as $state){       
                                    ?>
                                    <option value="<?= $state['codigo']; ?>"  ><?= $state['nombre']; ?></option>
                                    <?php 
                                        }   
                                    ?>
                                </select> 
                            </div>
                        </div>
                        <div class="col-md-<?= $verf_sub_activity?'12':'4' ?>">
                            <p class="mt-2 mb-1 text-muted"><i class="fe-chevron-right"></i> Descripción</p>
                            <div class="d-flex align-items-start">
                                <!-- Información -->
                                <div class="w-100 data_select" style="cursor:pointer;" data-select="6" data-inp="description_up">
                                    <h5 class="mt-1 font-size-14">
                                        <i class='fe-file-text font-16 text-info'></i> <?=$obs;?>
                                    </h5>
                                </div>
                                <!-- Actualzación -->
                                <textarea class="form-control data_update" name="description_up" id="description_up" style="display:none;"><?=$obs;?></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Nueva Nota-->
                <div class="card p-2 mb-1 border">
                    <h5 class="card-title font-16 text-primary"><i class="fe-airplay"></i> Detalle</h5>
                    <div class="border rounded">
                        <form action="#" class="comment-area-box">
                            <textarea rows="3" class="form-control border-0 resize-none" id="annotation" placeholder="Escriba una nota.."></textarea>
                            <div class="p-2 bg-light d-flex justify-content-between align-items-center">
                                <!-- <div class="file-select" id="src-file1" >
                                    <input type="file" id="src-file1-input" name="src-file1" aria-label="Archivo">
                                </div> -->
                                <button type="button" class="btn btn-sm btn-primary" id="add-file"><i class="mdi mdi-plus"></i> Adjuntar Archivo</button>
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
                                            <a href="file_activity/<?=$file['ruta'];?>" download="pei_<?=$file['ruta']?>" class="text-muted fw-bold"><?=$file['detalle'];?></a>
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
                                    <img src="<?=$ruta?><?=$note['imagen_personal'];?>" class="rounded-circle" alt="perfil">
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
                <!-- Hitos -->
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <button type="button" class="btn btn-success rounded-pill btn-sm float-end addHito" data-start="<?=date('Y-m-d', strtotime($fechaInicial));?>" data-end="<?=date('Y-m-d', strtotime($fechaLimite));?>">
                            <i class="mdi mdi-plus"></i>
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-bell"></i> Hitos</h5>
                    </div>
                    <div class="inbox-widget" data-simplebar style="max-height: 220px;">
                        <?php
                            if(!count($rowsHito = $stmtHito->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-folder-minus"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted"> No se encontró hitos...</h5>
                                </div>
                            </div>
                        </div> 
                        <?php
                            }else{
                                foreach ($rowsHito as $hito){
                        ?>
                            <div class="inbox-item">
                                <div class="row">
                                    <div class="col-md-8 inbox-item-text">
                                        <p class="inbox-item-author"><i class="fe-play text-danger"></i> <?=$hito['nombre'];?></p>
                                    </div>
                                    <div class="col-md-4 inbox-item-date p-0 text-right">
                                        <?=$hito['fecha_hito'];?>
                                    </div>
                                </div>
                            </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <!-- SubActividades-->
                <?php
                    if($verf_sub_activity){
                ?>
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <button type="button" class="btn btn-success rounded-pill btn-sm addSubActivity float-end" data-start="<?=date('Y-m-d', strtotime($fechaInicial));?>" data-end="<?=date('Y-m-d', strtotime($fechaLimite));?>" data-val="<?=date('Y-m-d', strtotime($fechaInicial));?>">
                            <i class="mdi mdi-plus"></i>
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-paperclip"></i>Sub Actividades</h5>
                    </div>
                    <div class="inbox-widget" data-simplebar style="max-height: 220px;">
                        <?php
                            if(!count($rows_sub_activity = $stmtsubActivity->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-folder-minus"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted"> No se encontró subactividades...</h5>
                                </div>
                            </div>
                        </div> 
                        <?php
                            }else{
                                foreach ($rows_sub_activity as $sub_activity){
                        ?>
                            <div class="inbox-item">
                                <div class="row">
                                    <div class="col-md-13 inbox-item-text">
                                        <p class="inbox-item-author show-activity" data-cod_actividad="<?=$sub_activity['codigo'];?>" style="cursor:pointer;">
                                        <i class="fe-copy text-warning"></i> <?=$sub_activity['nombre'];?></p>
                                    </div>
                                </div>
                            </div>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <?php
                    }
                ?>
                <!-- Presupuesto-->
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <button type="button" class="btn btn-success rounded-pill btn-sm addBudget float-end">
                            <i class="mdi mdi-plus"></i>
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-tag"></i> Presupuesto</h5>
                    </div>
                    <div class="inbox-widget component-budget" data-simplebar style="max-height: 220px;">
                        <?php
                            if(!count($rows_account = $stmtAccount->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-thumbs-down"></i>
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
                            <div class="inbox-item <?=($account['estado_presupuesto'] == 1 ? 'selectBudget':'');?>" <?=($account['estado_presupuesto'] == 1 ? 'style="cursor:pointer;"':'');?> data-codigo="<?=$account['codigo'];?>">
                                <div class="row">
                                    <div class="col-md-8 inbox-item-text">
                                        <p class="inbox-item-author"><?=$account['nombre'];?></p>
                                        <p class="mb-0 text-success"><i class="fe-file"></i> <?=$account['monto'];?> bs.</p>
                                    </div>
                                    <div class="col-md-4 inbox-item-date p-0 text-right">
                                        <?=$account['fecha'];?>
                                        <span class="badge bg-<?=$account['etiqueta'];?> float-end p-1"><?=$account['nombre_estado'];?></span>
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
                        <button type="button" class="btn btn-success rounded-pill btn-sm addCollaborator float-end">
                            <i class="mdi mdi-plus"></i>
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-users"></i> Colaboradores</h5>
                    </div>
                    <div class="inbox-widget component-collaborator" data-simplebar style="max-height: 300px;">
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
                        <div class="inbox-item <?=($collaborator['estado'] == 1 ? 'selectCollaborator':'');?>" <?=($collaborator['estado'] == 1 ? 'style="cursor:pointer;"':'');?> data-codigo_personal="<?=$collaborator['codigo_personal'];?>">
                            <div class="d-flex align-items-start">
                                <img src="<?=$ruta;?><?=$collaborator['imagen_personal'];?>" class="me-2 rounded-circle" height="36" alt="Perfil">
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
                <!-- Funciones de Cargo -->
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <button type="button" class="btn btn-success rounded-pill btn-sm float-end addPosition">
                            <i class="mdi mdi-plus"></i>
                        </button>
                        <h5 class="header-title mt-1 text-primary"><i class="fe-airplay"></i> Funciones de Cargo</h5>
                    </div>

                    <div class="inbox-widget" data-simplebar style="max-height: 220px;">
                        <?php
                            if(!count($rowsFuncion = $stmtFuncion->fetchAll())){
                        ?>
                        <div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-folder-minus"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted"> No se encontró funciones...</h5>
                                </div>
                            </div>
                        </div> 
                        <?php
                            }else{
                                foreach ($rowsFuncion as $funcion){
                        ?>
                            <a href="javascript: void(0);" class="text-reset mb-2 d-block selectFunction" data-codigo="<?=$funcion['codigo']?>">
                                <i class="mdi mdi-checkbox-blank-circle-outline me-1 text-warning"></i>
                                <span class="mb-0 mt-1"><?=$funcion['nombre_funcion']?></span>
                            </a>
                        <?php
                                }
                            }
                        ?>
                    </div>
                </div>
                <!-- Seguimiento de Actividad -->
                <div class="card p-2 mb-1 border">
                    <div class="pb-1">
                        <h5 class="header-title mt-1 text-primary"><i class="fe-airplay"></i> Seguimiento de Actividad</h5>
                    </div>

                    <div class="inbox-widget" data-simplebar style="max-height: 220px;">
                        <?php
                            $rowsSeguimiento = $stmtSeguimiento->fetchAll();
                            foreach ($rowsSeguimiento as $seguimiento){
                        ?>
                            <div class="inbox-item">
                                <div class="row">
                                    <div class="col-md-8 inbox-item-text">
                                        <p class="inbox-item-author">
                                            <i class="<?=$seguimiento['icon'];?>"></i> <?=($seguimiento['cod_estado'] == 1 ? 'Creada':'Actualizada');?></p>
                                        <p class="mb-0 text-secondary">
                                            <b>Por:</b> <?=$seguimiento['empleado'];?>
                                        </p>
                                    </div>
                                    <div class="col-md-4 inbox-item-date p-0 text-right">
                                        <?=$seguimiento['fecha'];?>
                                        <span class="badge bg-<?=$seguimiento['color'];?> float-end p-1"><?=$seguimiento['nombre_estado'];?></span>
                                    </div>
                                </div>
                            </div>
                        <?php
                            }
                        ?>
                    </div>
                </div>
            </div>
    	</div>
    </div>
</div>