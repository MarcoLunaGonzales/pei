<?php
require_once 'conexion.php';
require_once 'functionsNames.php';
require_once 'layouts/body_empty2.php';

$dbh = new Conexion();

$globalUnidadX          = $_SESSION["globalUO"];
$globalAreaX            = $_SESSION["globalArea"];
$nombreUnidadCabecera   = $_SESSION["globalNameUO"];
$nombreAreaCabecera     = $_SESSION["globalNameArea"];
$cod_personal           = $_SESSION['globalUser'];

$codProyecto=$_GET["cod_proyecto"];

$nombreProyecto="";
if($codProyecto!=0){
    $nombreProyecto=nombreNivelPEI($codProyecto);
}

/* Obtenemos Configuración de ruta de imagenes */
$sqlFind = "SELECT * FROM configuraciones
WHERE id_configuracion = 2";
$stmtFind = $dbh->prepare($sqlFind);
$stmtFind->execute();
while ($row = $stmtFind->fetch(PDO::FETCH_ASSOC)) {
    $ruta  = $row['valor_configuracion'];
}

/* Datos de Personal */
$sqlP = "SELECT cod_cargo 
FROM personal
WHERE codigo = $cod_personal";
$stmtP = $dbh->prepare($sqlP);
$stmtP->execute();
while ($rowP = $stmtP->fetch(PDO::FETCH_ASSOC)) {
    $codCargoP = $rowP['cod_cargo'];
}
?>



<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Lista de Actividades</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets2/images/favicon.ico">

        <!-- Plugins css -->
        <link href="assets2/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
        <link href="assets2/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
        <link href="assets2/libs/select2/css/select2.min.css" rel="stylesheet" type="text/css" />

		<!-- Bootstrap css -->
		<link href="assets2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<!-- App css -->
		<link href="assets2/css/app.min.css" rel="stylesheet" type="text/css" id="app-style"/>
		<!-- icons -->
		<link href="assets2/css/icons.min.css" rel="stylesheet" type="text/css" />
		<!-- Head js -->
		<script src="assets2/js/head.js"></script>
        <!-- Style input type FILE -->
		<link href="assets/css/customStyle.css" rel="stylesheet" type="text/css" />
        <!-- Sweet Alert-->
        <link href="assets2/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />

    </head>

    <!-- body start -->
    <body  data-layout-mode="horizontal" data-theme="light">
        <!-- Begin page -->
        <div id="wrapper">
            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->
            <div class="content-page" style="padding: 0px; margin-top: 0px;">
                <div class="content pb-3">

                    <!-- Start Content-->
                    <div class="container-fluid">
                        
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <!--div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">UBold</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Tasks</a></li>
                                            <li class="breadcrumb-item active">Tasks List</li>
                                        </ol>
                                    </div-->
                                    <h4 class="page-title">Lista de Actividades - <?=$nombreProyecto;?></h4>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title --> 

                        <!-- tasks panel -->
                        <div class="row">
                            <div class="col-xl-8">
                                <div class="row">
                                    <div class="col">
                                        <div class="card">
                                            <div class="card-body">
                                                <!-- cta -->
                                                <div class="row">
                                                    <div class="col-sm-3">
                                                    <!--Este campo es para la creacion de nuevas actividades-->
                                                    <input type="hidden" id="estado_activo" name="estado_activo" value="0">
                                                    
                                                    <button type="button" class="btn btn-primary" onclick="showModalNewTask(1)">
                                                            <i class='bx bx-plus mr-1'></i>Nueva Actividad</button>
                                                    </div>
                                                    <div class="col-sm-9">
                                                        <div class="float-sm-end mt-3 mt-sm-0">
                                                            
                                                            <div class="d-inline-block mb-3 mb-sm-0 me-sm-2">
                                                                <form class="search-bar form-inline">
                                                                    <div class="position-relative">
                                                                        <input type="text" class="form-control" placeholder="Search...">
                                                                        <span class="mdi mdi-magnify"></span>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="dropdown d-inline-block">
                                                                <button class="btn btn-light dropdown-toggle" type="button"
                                                                    data-bs-toggle="dropdown" aria-haspopup="true"
                                                                    aria-expanded="false">
                                                                    <i class="mdi mdi-filter-variant"></i>
                                                                </button>
                                                                <div class="dropdown-menu dropdown-menu-end">
                                                                    <a class="dropdown-item" href="#">Due Date</a>
                                                                    <a class="dropdown-item" href="#">Added Date</a>
                                                                    <a class="dropdown-item" href="#">Assignee</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mt-4" data-plugin="dragula" data-containers='["task-list-one", "task-list-two", "task-list-three"]'>
                                                    <div class="col">
                                                        <?php
                                                            $sqlAct="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
                                                                (select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei,
                                                                (SELECT COUNT(*) as files_count FROM actividades_archivos aa WHERE aa.cod_actividad = a.codigo AND aa.cod_estado = 1) as files_count,
                                                                (SELECT COUNT(*) as notes_count FROM actividades_anotaciones an WHERE an.cod_actividad = a.codigo AND an.cod_estado = 1) as notes_count,
                                                                (SELECT COUNT(*) as notes_count FROM actividades_anotaciones an WHERE an.cod_actividad = a.codigo AND an.cod_estado = 1) as notes_count,
                                                                pimg.imagen as imagen_personal
                                                                from actividades a
                                                                LEFT JOIN actividades_prioridades ap ON a.cod_prioridad = ap.codigo
                                                                LEFT JOIN personalimagen pimg ON a.cod_responsable = pimg.codigo
                                                                LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
                                                                WHERE a.cod_padre is null
                                                                AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')";
                                                            if($codProyecto!=0){
                                                                $sqlAct.=" and a.cod_componentepei='$codProyecto' ";
                                                            }
                                                                $stmtAct= $dbh->prepare($sqlAct);
                                                                $stmtAct->execute();
                                                                $countAct = $stmtAct->rowCount();
                                                        ?>
                                                        <a class="text-dark" data-bs-toggle="collapse" href="#todayTasks" aria-expanded="false" aria-controls="todayTasks">
                                                            <h5 class="mb-0"><i class="mdi mdi-chevron-down font-18"></i> Total <span class="text-muted font-14"><?=$countAct;?> Actividades</span></h5>
                                                        </a>
                                                
                                                        <div class="collapse show" id="todayTasks">
                                                            <div class="card mb-0 shadow-none">
                                                                <div class="card-body pb-0" id="task-list-one">
                                                                    
                                                        <?php
                                                            while ($rowAct = $stmtAct->fetch(PDO::FETCH_ASSOC)) {
                                                                $codigoActividad=$rowAct['codigo'];
                                                                $nombreActividad=$rowAct['nombre'];
                                                                $obsActividad=$rowAct['observaciones'];
                                                                $fechaLimiteActividad=$rowAct['fecha_limite'];
                                                                $codPrioridadActividad=$rowAct['cod_prioridad'];
                                                                $nombrePrioridadActividad=$rowAct['nombre_prioridad'];
                                                                $colorActividad=$rowAct['color'];
                                                                $nombreComponentePEI=$rowAct['nombrecomponentepei'];
                                                                $files_count = $rowAct['files_count'];
                                                                $notes_count = $rowAct['notes_count'];
                                                                $imagen_personal = $rowAct['imagen_personal'];
                                                            
                                                        ?>
                                                                    <!-- task -->
                                                                    <div class="row justify-content-sm-between task-item">
                                                                        <div class="col-lg-6 mb-2">
                                                                            <div class="form-check">
                                                                                <input type="checkbox" class="form-check-input" id="task1" />
                                                                                <a href="" onclick="javascript:showModallistTaskDetail(<?=$codigoActividad?>)" ><label class="form-check-label" for="task1">
                                                                                    <?=$nombreComponentePEI;?> - <?=$nombreActividad;?> - <?=$obsActividad;?>
                                                                                </label></a>
                                                                            </div>
                                                                            <!-- end checkbox -->
                                                                        </div>
                                                                        <!-- end col -->
                                                                        <div class="col-lg-6">
                                                                            <div class="d-sm-flex justify-content-between">
                                                                                <div id="tooltips-container">
                                                                                    <img src="<?=$ruta?><?=$imagen_personal;?>" lt="image" class="avatar-xs rounded-circle" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Assigned to Arya S" />
                                                                                </div>
                                                                                <div class="mt-3 mt-sm-0">
                                                                                    <ul class="list-inline font-13 text-sm-end">
                                                                                        <li class="list-inline-item">
                                                                                            <span class="badge badge-soft-<?=$colorActividad;?> p-1"><?=$nombrePrioridadActividad;?></span>
                                                                                        </li>
                                                                                        <li class="list-inline-item pe-1">
                                                                                            <i class="mdi mdi-calendar-month-outline font-16 me-1"></i>
                                                                                            <?=$fechaLimiteActividad;?>
                                                                                        </li>
                                                                                        <li class="list-inline-item pe-1">
                                                                                            <i class="mdi mdi-tune font-16 me-1"></i>
                                                                                            <?=$files_count;?>
                                                                                        </li>
                                                                                        <li class="list-inline-item pe-2">
                                                                                            <i class="mdi mdi-comment-text-multiple-outline font-16 me-1"></i>
                                                                                            <?=$notes_count;?>
                                                                                        </li>
                                                                                        <li class="list-inline-item text-primary pe-2" style="cursor:pointer;">
                                                                                            <i class="fe-eye showActivity" data-cod_activity="<?=$codigoActividad?>"></i>
                                                                                        </li>
                                                                                    </ul>
                                                                                </div>
                                                                            </div>
                                                                            <!-- end .d-flex-->
                                                                        </div>
                                                                        <!-- end col -->
                                                                    </div>
                                                                    <!-- end task -->                                                               
                                                            <?php
                                                            }
                                                            ?>          

                                                                </div>
                                                                <!-- end card-body-->
                                                            </div>
                                                            <!-- end card -->
                                                        </div>
                                                        <!-- end .collapse-->
                                                
                                                    </div>
                                                    <!-- end col -->
                                                </div>
                                                <!-- end row -->
                                            </div> <!-- end card-body -->
                                        </div> <!-- end card -->
                                    </div> <!-- end col -->
                                </div> <!-- end row -->
                            </div> <!-- end col -->

                            <!-- task details -->
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col initial-activity">
                                                <div class="card-body text-center">
                                                    <div class="pt-2 pb-2">
                                                        <img src="assets2/images/detailActivity.svg" alt="profile-image" width="100%">
                
                                                        <h4 class="mt-3"><a href="extras-profile.html" class="text-dark">Manténgase al tanto y al día</a></h4>
                                                        <p class="text-muted">Invite a personas a las actividades, deje comentarios y añada fechas de limite. Le mostraremos la actividad selecciona más detallada en esta sección. <span> </p>
                                                    </div> <!-- end .padding -->
                                                </div>

                                                <!-- end comments -->
                                            </div>
                                            <div class="col detail-activity" style="display:none">
                                                <h4>Detalle de las actividades que son revisadas.</h4>

                                                <div class="row">
                                                    <div class="col-6">
                                                        <p class="mt-2 mb-1 text-muted">Responsable</p>
                                                        <div class="d-flex align-items-start">
                                                            <img src="assets2/images/users/user-9.jpg" alt="Arya S" class="rounded-circle me-2" height="24" />
                                                            <div class="w-100">
                                                                <h5 class="mt-1 font-size-14 user_manager">
                                                                </h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <p class="mt-2 mb-1 text-muted">Fecha Limite</p>
                                                        <div class="d-flex align-items-start">
                                                            <i class='mdi mdi-calendar-month-outline font-18 text-success me-1'></i>
                                                            <div class="w-100">
                                                                <h5 class="mt-1 font-size-14 date_limit">
                                                                </h5>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mt-3">
                                                    <div class="col">
                                                        <h5 class="mb-2 font-size-16"><i class='fe-file-text font-16 text-info'></i> Descripción</h5>
                                                        <div class="inbox-widget" data-simplebar style="max-height: 200px;">
                                                            <div class="card mb-1 shadow-none border">
                                                                <div class="p-2">
                                                                    <div class="row align-items-center">
                                                                        <h5 class="mt-0 mb-0 text-muted description_activity">No hay archivos adjuntos</h5>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <h5 class="mt-3 font-size-16"><i class="fe-paperclip text-success"></i> Sub-Actividades</h5>
                                                <div class="inbox-widget component-subActivity-show" data-simplebar style="max-height: 200px;">
                                                </div>

                                                <h5 class="mt-3 font-size-16"><i class="fe-download-cloud text-info"></i> Documentos Adjuntos</h5>
                                                
                                                <div class="inbox-widget component-file-show" data-simplebar style="max-height: 200px;">
                                                </div>

                                                <h5 class="mt-3 font-size-16"><i class="fe-feather text-primary"></i> Comentarios de la Actividad</h5>
                                                <div class="inbox-widget component-annotation-show" data-simplebar style="max-height: 200px;">
                                                </div>

                                                <h5 class="mt-3 font-size-16"><i class="fe-feather text-primary"></i> Seguimiento de Actividad</h5>
                                                <div class="inbox-widget component-tracing-show" data-simplebar style="max-height: 200px;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <script>document.write(new Date().getFullYear())</script> &copy; UBold theme by <a href="">Coderthemes</a> 
                            </div>
                            <div class="col-md-6">
                                <div class="text-md-end footer-links d-none d-sm-block">
                                    <a href="javascript:void(0);">About Us</a>
                                    <a href="javascript:void(0);">Help</a>
                                    <a href="javascript:void(0);">Contact Us</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->
        </div>
        <!-- END wrapper -->


    <!-- Modal -->
    <div class="modal fade" id="modalNewTask" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Adicionar Actividad</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Proyecto / Componente PEI</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                            <select name="componente_pei" id="componente_pei" class="form-control single-select" data-style="btn btn-warning" required>
                                <option value="" disabled selected="selected">-</option>
                                <?php             
                                    $sqlProj="SELECT np.codigo, np.nombre, np.abreviatura from niveles_pei np, nivelespei_unidadesareas npua where np.codigo=npua.cod_nivelpei and npua.cod_area='$globalAreaX' and npua.cod_unidadorganizacional='$globalUnidadX'";
                                    $stmtProj=$dbh->prepare($sqlProj);
                                    $stmtProj->execute();
                                    $stmtProj->bindColumn('codigo', $codigoF);
                                    $stmtProj->bindColumn('nombre', $nombreF);
                                    while ($rowProj = $stmtProj->fetch(PDO::FETCH_BOUND)) {         
                                ?>
                                <option value="<?= $codigoF; ?>" <?=($codigoF==$codProyecto)?"selected":"";?> ><?= $nombreF; ?></option>
                                <?php 
                                    }   
                                ?>
                            </select>                     
                        </div>
                    </div>
                    
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Nombre</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                          <input class="form-control" type="text" name="nombre" id="nombre" required="true" autocomplete="off" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Descripcion</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                            <textarea class="form-control" name="observaciones" id="observaciones"></textarea>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Fecha Inicio</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                          <input class="form-control" type="date" name="fecha_inicio" id="fecha_inicio" required="true"/>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Fecha Limite</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                          <input class="form-control" type="date" name="fecha_limite" id="fecha_limite" required="true"/>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Prioridad</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                            <select name="prioridad" id="prioridad" class="single-select form-control" data-style="btn btn-warning" required>
                                <option value="" disabled selected="selected">-</option>
                                <?php             
                                    $sqlForaneo="SELECT codigo,nombre FROM actividades_prioridades where cod_estado=1";
                                    $stmtForaneo=$dbh->prepare($sqlForaneo);
                                    $stmtForaneo->execute();
                                    $stmtForaneo->bindColumn('codigo', $codigoF);
                                    $stmtForaneo->bindColumn('nombre', $nombreF);
                                    while ($rowForaneo = $stmtForaneo->fetch(PDO::FETCH_BOUND)) {         
                                ?>
                                <option value="<?= $codigoF; ?>" ><?= $nombreF; ?></option>
                                <?php 
                                    }   
                                ?>
                            </select>                     
                        </div>
                      </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="saveNewTask();">Guardar Actividad</button>
                </div>
            </div>
        </div>
    </div>
    <!--END MODAL-->
    <!-- Long Content Scroll Modal -->
    <div class="modal fade" id="modal_task_detail" tabindex="-1" role="dialog" aria-labelledby="scrollableModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div id="div_task_detail">
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->  
    <!-- Modal Colaborador -->
    <div class="modal fade" id="modalCollaborator" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-top">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white">Añadir colaborador</h5>
                    <button type="button" class="btn-close bg-white close-collaborator" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-form-label">Colaborador:</label>
                                <select name="cod_personal" data-toggle="select2" data-width="100%" id="cod_personal" class="form-control" data-style="btn btn-warning" required>
                                    <?php             
                                        $sqlColl   = "SELECT codigo, CONCAT(primer_nombre, ' ', paterno, ' ',materno) as nombre_personal FROM personal 
                                        WHERE cod_estadopersonal = 1
                                        ORDER BY nombre_personal ASC";
                                        $stmtColl  = $dbh->prepare($sqlColl);
                                        $stmtColl->execute();
                                        $rows_collaborators = $stmtColl->fetchAll();
                                        foreach ($rows_collaborators as $collabolator){       
                                    ?>
                                    <option value="<?= $collabolator['codigo']; ?>"  ><?= $collabolator['nombre_personal']; ?></option>
                                    <?php 
                                        }   
                                    ?>
                                </select>                     
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-collaborator" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary save-collaborator">Guardar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Presupuesto -->
    <div class="modal fade" id="modalBudget" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-top">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white">Añadir Presupuesto</h5>
                    <button type="button" class="btn-close bg-white close-budget" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-form-label">Cuenta:</label>
                                <select name="cod_account" id="cod_account" class="form-control" data-style="btn btn-warning" required>
                                    <?php             
                                        $sqlAccount   = "SELECT p.codigo, p.numero, p.nombre 
                                            FROM plan_cuentas p 
                                            WHERE p.numero like '5%' 
                                            AND p.nivel = 5 
                                            AND p.cod_estadoreferencial = 1";
                                        $stmtAccount  = $dbh->prepare($sqlAccount);
                                        $stmtAccount->execute();
                                        $rows_accounts = $stmtAccount->fetchAll();
                                        foreach ($rows_accounts as $account){       
                                    ?>
                                    <option value="<?= $account['codigo']; ?>"  ><?= $account['numero']; ?> - <?= $account['nombre']; ?></option>
                                    <?php 
                                        }   
                                    ?>
                                </select>
                                <label class="col-form-label">Monto:</label>
                                <input type="number" step="0.1" autocomplete="off" id="amount" class="form-control" placeholder="Ingresar presupuesto"> 
                                <label class="col-form-label">Fecha Ejecucion:</label>
                                <input type="date" id="dateBudget" class="form-control">               
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-budget" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary save-budget">Guardar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Funciones Cargos -->
    <div class="modal fade" id="modalPosition" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-top">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white">Añadir Funciones</h5>
                    <button type="button" class="btn-close bg-white close-position" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-form-label">Funciones:</label>
                                <select name="cod_funcion" id="cod_funcion" class="form-control" data-style="btn btn-warning" required>
                                    <option value="" selected>-</option>
                                    <?php
                                        $sqlPosition   = "SELECT af.cod_funcion as codigo, af.nombre_funcion as nombre  FROM cargos_funciones af
                                            WHERE af.cod_estado = 1
                                            AND af.cod_funcion = '$codCargoP'
                                            ORDER BY codigo DESC";
                                        $stmtPosition  = $dbh->prepare($sqlPosition);
                                        $stmtPosition->execute();
                                        $rowsPositions = $stmtPosition->fetchAll();
                                        foreach ($rowsPositions as $position){       
                                    ?>
                                    <option value="<?= $position['codigo']; ?>"  ><?= $position['nombre']; ?></option>
                                    <?php
                                        }
                                    ?>
                                </select>             
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-position" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary save-position">Guardar</button>
                </div>
            </div>
        </div>
    </div> 
    
    <!-- Modal Nuevo Hito -->
    <div class="modal fade" id="modalNewHito" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-top">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white">Añadir Hito</h5>
                    <button type="button" class="btn-close bg-white close-hito" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-12 col-form-label">Nombre</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="text" name="nombre_hito" id="nombre_hito" required="true" autocomplete="off"/>
                                    </div>
                                </div>
                                <label class="col-sm-12 col-form-label">Fecha Hito</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="date" name="date_hito" id="date_hito" required="true"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-hito" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary save-hito">Guardar</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Nueva Sub Actividad -->
    <div class="modal fade" id="modalNewSubActivity" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-top">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title text-white">Añadir Sub Actividad</h5>
                    <button type="button" class="btn-close bg-white close-subActivity" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-12 col-form-label">Nombre</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="text" name="sub_nombre" id="sub_nombre" required="true" autocomplete="off" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
                                    </div>
                                </div>
                                <label class="col-sm-12 col-form-label">Fecha Inicial</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="date" name="sub_fecha_inicial" id="sub_fecha_inicial" required="true"/>
                                    </div>
                                </div>
                                <label class="col-sm-12 col-form-label">Fecha Limite</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="date" name="sub_fecha" id="sub_fecha" required="true"/>
                                    </div>
                                </div>
                                <label class="col-sm-12 col-form-label">Prioridad</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <select name="sub_prioridad" id="sub_prioridad" class="single-select form-control" data-style="btn btn-warning" required>
                                            <option value="" disabled selected="selected">-</option>
                                            <?php             
                                                $sqlForaneo="SELECT codigo,nombre FROM actividades_prioridades where cod_estado=1";
                                                $stmtForaneo=$dbh->prepare($sqlForaneo);
                                                $stmtForaneo->execute();
                                                $stmtForaneo->bindColumn('codigo', $codigoF);
                                                $stmtForaneo->bindColumn('nombre', $nombreF);
                                                while ($rowForaneo = $stmtForaneo->fetch(PDO::FETCH_BOUND)) {         
                                            ?>
                                            <option value="<?= $codigoF; ?>" ><?= $nombreF; ?></option>
                                            <?php 
                                                }   
                                            ?>
                                        </select>                     
                                    </div>              
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary close-subActivity" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary save-subActivity">Guardar</button>
                </div>
            </div>
        </div>
    </div>
        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>
        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>
        
        <script src="assets2/libs/select2/js/select2.min.js"></script>
        <!-- Dragula js -->
        <script src="assets2/libs/dragula/dragula.min.js"></script>
        <!-- Dragula init js-->
        <script src="assets2/js/pages/dragula.init.js"></script>
        <!-- Plugins js -->
        <script src="assets2/libs/quill/quill.min.js"></script>
        <!-- Init js-->
        <script src="assets2/js/pages/task.init.js"></script>
        <!-- Script - Lista de Actividades -->
        <script src="assets/js/functionActivity.js"></script>
    </body>
</html>