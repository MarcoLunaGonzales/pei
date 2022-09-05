<?php
require_once 'conexion.php';
require_once 'functionsNames.php';
require_once 'layouts/body_empty2.php';

$dbh = new Conexion();

$globalUnidadX=$_SESSION["globalUO"];
$globalAreaX=$_SESSION["globalArea"];
$nombreUnidadCabecera=$_SESSION["globalNameUO"];
$nombreAreaCabecera=$_SESSION["globalNameArea"]; 

$codProyecto=$_GET["cod_proyecto"];

$nombreProyecto="";
if($codProyecto!=0){
    $nombreProyecto=nombreNivelPEI($codProyecto);
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

		<!-- Bootstrap css -->
		<link href="assets2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<!-- App css -->
		<link href="assets2/css/app.min.css" rel="stylesheet" type="text/css" id="app-style"/>
		<!-- icons -->
		<link href="assets2/css/icons.min.css" rel="stylesheet" type="text/css" />
		<!-- Head js -->
		<script src="assets2/js/head.js"></script>

    </head>

    <!-- body start -->
    <body  data-layout-mode="horizontal" data-theme="light">
        <!-- Begin page -->
        <div id="wrapper">
            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->
            <div class="content-page" style="padding: 0px; margin-top: 0px;">
                <div class="content">

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
                                    <h4 class="page-title">Lista de Tareas  -  <?=$nombreProyecto;?></h4>
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
                                                    <!--Este campo es para la creacion de nuevas tareas-->
                                                    <input type="hidden" id="estado_activo" name="estado_activo" value="0">
                                                    
                                                    <button type="button" class="btn btn-primary" onclick="showModalNewTask(1)">
                                                            <i class='bx bx-plus mr-1'></i>Nueva Tarea</button>
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
                                                        <a class="text-dark" data-bs-toggle="collapse" href="#todayTasks" aria-expanded="false" aria-controls="todayTasks">
                                                            <h5 class="mb-0"><i class="mdi mdi-chevron-down font-18"></i> Today <span class="text-muted font-14">(10)</span></h5>
                                                        </a>
                                                
                                                        <div class="collapse show" id="todayTasks">
                                                            <div class="card mb-0 shadow-none">
                                                                <div class="card-body pb-0" id="task-list-one">
                                                                    
                                                        <?php
                                                        $sqlAct="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
                                                            (select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei from actividades a, actividades_prioridades ap where a.cod_prioridad=ap.codigo";
                                                        if($codProyecto!=0){
                                                            $sqlAct.=" and a.cod_componentepei='$codProyecto' ";
                                                        }
                                                            $stmtAct= $dbh->prepare($sqlAct);
                                                            $stmtAct->execute();
                                                            while ($rowAct = $stmtAct->fetch(PDO::FETCH_ASSOC)) {
                                                                $codigoActividad=$rowAct['codigo'];
                                                                $nombreActividad=$rowAct['nombre'];
                                                                $obsActividad=$rowAct['observaciones'];
                                                                $fechaLimiteActividad=$rowAct['fecha_limite'];
                                                                $codPrioridadActividad=$rowAct['cod_prioridad'];
                                                                $nombrePrioridadActividad=$rowAct['nombre_prioridad'];
                                                                $colorActividad=$rowAct['color'];
                                                                $nombreComponentePEI=$rowAct['nombrecomponentepei'];
                                                            
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
                                                                                    <img src="assets2/images/users/user-9.jpg" lt="image" class="avatar-xs rounded-circle" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Assigned to Arya S" />
                                                                                </div>
                                                                                <div class="mt-3 mt-sm-0">
                                                                                    <ul class="list-inline font-13 text-sm-end">
                                                                                        <li class="list-inline-item pe-1">
                                                                                            <i class="mdi mdi-calendar-month-outline font-16 me-1"></i>
                                                                                            <?=$fechaLimiteActividad;?>
                                                                                        </li>
                                                                                        <li class="list-inline-item pe-1">
                                                                                            <i class="mdi mdi-tune font-16 me-1"></i>
                                                                                            3/7
                                                                                        </li>
                                                                                        <li class="list-inline-item pe-2">
                                                                                            <i class="mdi mdi-comment-text-multiple-outline font-16 me-1"></i>
                                                                                            21
                                                                                        </li>
                                                                                        <li class="list-inline-item">
                                                                                            <span class="badge badge-soft-<?=$colorActividad;?> p-1"><?=$nombrePrioridadActividad;?></span>
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
                                            <div class="col">
                                                <div class="dropdown float-end">
                                                    <a href="#" class="dropdown-toggle arrow-none text-muted"
                                                        data-bs-toggle="dropdown" aria-expanded="false">
                                                        <i class='mdi mdi-dots-horizontal font-18'></i>
                                                    </a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <!-- item-->
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                            <i class='mdi mdi-attachment me-1'></i>Attachment
                                                        </a>
                                                        <!-- item-->
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                            <i class='mdi mdi-pencil-outline me-1'></i>Edit
                                                        </a>
                                                        <!-- item-->
                                                        <a href="javascript:void(0);" class="dropdown-item">
                                                            <i class='mdi mdi-content-copy me-1'></i>Mark as Duplicate
                                                        </a>
                                                        <div class="dropdown-divider"></div>
                                                        <!-- item-->
                                                        <a href="javascript:void(0);" class="dropdown-item text-danger">
                                                            <i class='mdi mdi-delete-outline me-1'></i>Delete
                                                        </a>
                                                    </div> <!-- end dropdown menu-->
                                                </div> <!-- end dropdown-->

                                                <div class="form-check float-start">
                                                    <input type="checkbox" class="form-check-input" id="completedCheck">
                                                    <label class="form-check-label" for="completedCheck">
                                                        Marcar como completado!
                                                    </label>
                                                </div> <!-- end form-check-->
                                                <div class="clearfix"></div>

                                                <hr class="my-2" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col">
                                                <h4>Detalle de las tareas que son revisadas.</h4>

                                                <div class="row">
                                                    <div class="col-6">
                                                        <!-- assignee -->
                                                        <p class="mt-2 mb-1 text-muted">Asignado A</p>
                                                        <div class="d-flex align-items-start">
                                                            <img src="assets2/images/users/user-9.jpg" alt="Arya S" class="rounded-circle me-2" height="24" />
                                                            <div class="w-100">
                                                                <h5 class="mt-1 font-size-14">
                                                                    Marco Luna 
                                                                </h5>
                                                            </div>
                                                        </div>
                                                        <!-- end assignee -->
                                                    </div> <!-- end col -->

                                                    <div class="col-6">
                                                        <!-- start due date -->
                                                        <p class="mt-2 mb-1 text-muted">Fecha Limite</p>
                                                        <div class="d-flex align-items-start">
                                                            <i class='mdi mdi-calendar-month-outline font-18 text-success me-1'></i>
                                                            <div class="w-100">
                                                                <h5 class="mt-1 font-size-14">
                                                                    Hoy 10am
                                                                </h5>
                                                            </div>
                                                        </div>
                                                        <!-- end due date -->
                                                    </div> <!-- end col -->
                                                </div> <!-- end row -->

                                                <!-- task description -->
                                                <div class="row mt-3">
                                                    <div class="col">
                                                        <div id="bubble-editor" style="height: 120px;">
                                                            <p>Este es un detalle de lo que debe mostrarse como descripcion de las notas de la tarea.</p>
                                                            <ul>
                                                                <li>XXXXXX  YYYYYYY ZZZZZZ.</li>
                                                                <li>Editar el documento!</li>
                                                            </ul>
                                                            <p>Final del detalle de la tarea</p>
                                                        </div>
                                                    </div> <!-- end col -->
                                                </div>
                                                <!-- end task description -->

                                                <!-- start sub tasks/checklists -->
                                                <h5 class="mt-4 mb-2 font-size-16">Sub-Tareas</h5>
                                                <div class="form-check mt-1">
                                                    <input type="checkbox" class="form-check-input" id="checklist1">
                                                    <label class="form-check-label strikethrough" for="checklist1">
                                                        Sub-Tarea1
                                                    </label>
                                                </div>

                                                <div class="form-check mt-1">
                                                    <input type="checkbox" class="form-check-input" id="checklist2">
                                                    <label class="form-check-label strikethrough" for="checklist2">
                                                        Sub-Tarea2
                                                    </label>
                                                </div>

                                                <div class="form-check mt-1">
                                                    <input type="checkbox" class="form-check-input" id="checklist3">
                                                    <label class="form-check-label strikethrough" for="checklist3">
                                                        Sub-Tarea3
                                                    </label>
                                                </div>
                                                <!-- end sub tasks/checklists -->

                                                <!-- start attachments -->
                                                <h5 class="mt-4 mb-2 font-size-16">Documentos Adjuntos</h5>
                                                <div class="card mb-1 shadow-none border">
                                                    <div class="p-2">
                                                        <div class="row align-items-center">
                                                            <div class="col-auto">
                                                                <div class="avatar-sm">
                                                                    <span class="avatar-title badge-soft-primary text-primary rounded">
                                                                        ZIP
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col ps-0">
                                                                <a href="javascript:void(0);" class="text-muted fw-bold">planificacion.zip</a>
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
        
                                                <div class="card mb-1 shadow-none border">
                                                    <div class="p-2">
                                                        <div class="row align-items-center">
                                                            <div class="col-auto">
                                                                <div class="avatar-sm">
                                                                    <span class="avatar-title badge-soft-primary text-primary rounded">
                                                                        JPG
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="col ps-0">
                                                                <a href="javascript:void(0);" class="text-muted fw-bold">DisenoArquitectura.jpg</a>
                                                                <p class="mb-0 font-12">3.25 MB</p>
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
                                                <!-- end attachments -->

                                                <!-- comments -->
                                                <div class="row mt-3">
                                                    <div class="col">
                                                        <h5 class="mb-2 font-size-16">Comentarios de la Tarea</h5>
                                                
                                                        <div class="d-flex align-items-start mt-3 p-1">
                                                            <img src="assets2/images/users/user-9.jpg" class="me-2 rounded-circle" height="36" alt="Arya Stark" />
                                                            <div class="w-100">
                                                                <h5 class="mt-0 mb-0 font-size-14">
                                                                    <span class="float-end text-muted font-12">4:30am</span>
                                                                    Willy Miranda
                                                                </h5>
                                                                <p class="mt-1 mb-0 text-muted">
                                                                    Se deberia revisar el diseno del proyecto.
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <!-- end comment -->
                                                
                                                        <hr />
                                                
                                                        <div class="d-flex align-items-start mt-2 p-1">
                                                            <img src="assets2/images/users/user-5.jpg" class="me-2 rounded-circle" height="36" alt="Dominc B" />
                                                            <div class="w-100">
                                                                <h5 class="mt-0 mb-0 font-size-14">
                                                                    <span class="float-end text-muted font-12">3:30am</span>
                                                                    Cristina Mejia
                                                                </h5>
                                                                <p class="mt-1 mb-0 text-muted">
                                                                    @WillyMiranda, revisar semanalmente el proyecto.
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <!-- end comment-->
                                                
                                                        <hr />

                                                    </div>
                                                    <!-- end col -->
                                                </div>
                                                <!-- end row -->

                                                <div class="row mt-2">
                                                    <div class="col">
                                                        <div class="border rounded">
                                                            <form action="#">
                                                                <textarea rows="3" class="form-control border-0 resize-none" placeholder="Tus Comentarios...."></textarea>
                                                                <div class="p-2 bg-light d-flex justify-content-between align-items-center">
                                                                    <div>
                                                                        <a href="#" class="btn btn-sm px-2 font-16 btn-light"><i class="mdi mdi-cloud-upload-outline"></i></a>
                                                                        <a href="#" class="btn btn-sm px-2 font-16 btn-light"><i class="mdi mdi-at"></i></a>
                                                                    </div>
                                                                    <button type="submit" class="btn btn-sm btn-success"><i class="mdi mdi-send me-1"></i>Enviar Comentario</button>
                                                                </div>
                                                            </form>
                                                        </div> <!-- end .border-->
                                                    </div> <!-- end col-->
                                                </div>
                                                <!-- end comments -->
                                            </div> <!-- end col -->
                                        </div> <!-- end row-->
                                    </div> <!-- end card-body -->
                                </div> <!-- end card-->
                            </div> <!-- end col -->
                        </div>
                        
                    </div> <!-- container -->

                </div> <!-- content -->

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
                    <h5 class="modal-title">Adicionar Tarea</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Proyecto / Componente PEI</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                            <select name="componente_pei" id="componente_pei" class="single-select" data-style="btn btn-warning" required>
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
                          <input class="form-control" type="text" name="nombre" id="nombre" required="true" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <label class="col-sm-3 col-form-label">Descripcion</label>
                      <div class="col-sm-8">
                        <div class="form-group">
                            <textarea class="form-control" name="observaciones" id="observaciones">
                            </textarea>
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
                            <select name="prioridad" id="prioridad" class="single-select" data-style="btn btn-warning" required>
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
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div id="div_task_detail">
                </div>
            </div><!-- /.modal-content -->
        </div>
    </div><!-- /.modal -->  



        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>
        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>
        <!-- Dragula js -->
        <script src="assets2/libs/dragula/dragula.min.js"></script>
        <!-- Dragula init js-->
        <script src="assets2/js/pages/dragula.init.js"></script>
        <!-- Plugins js -->
        <script src="assets2/libs/quill/quill.min.js"></script>
        <!-- Init js-->
        <script src="assets2/js/pages/task.init.js"></script>
    </body>
</html>