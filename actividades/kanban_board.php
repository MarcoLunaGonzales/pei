<?php
require_once 'conexion.php';
require_once 'layouts/body_empty.php';

$dbh = new Conexion();

?>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Pizarra Kanban - MinkaSoftware</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <!--link rel="shortcut icon" href="assets2/images/favicon.ico"-->
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
    <body data-layout-mode="horizontal" data-theme="ligth" data-layout-width="fluid">

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
                                            <li class="breadcrumb-item active">Kanban Board</li>
                                        </ol>
                                    </div-->
                                    <h4 class="page-title">Pizarra Kanban - PEI</h4>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title --> 

                        <div class="row">
                            
                        <!--INICIANDO COLUMNA-->
                        <?php
                        $sqlEK="SELECT ek.codigo, ek.nombre, ek.descripcion from estados_kanban ek where ek.cod_estado=1 order by 1";
                        $stmtEK= $dbh->prepare($sqlEK);
                        $stmtEK->execute();
                        while ($rowEK = $stmtEK->fetch(PDO::FETCH_ASSOC)) {
                            $codigoEK=$rowEK['codigo'];
                            $nombreEK=$rowEK['nombre'];
                            $descripcionEK=$rowEK['descripcion'];
                        ?>
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="dropdown float-end">
                                            <a href="#" class="dropdown-toggle arrow-none" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="mdi mdi-dots-vertical m-0 text-muted h3"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <a class="dropdown-item" href="#">Edit</a>
                                                <a class="dropdown-item" href="#">Delete</a>
                                                <a class="dropdown-item" href="#">Add Members</a>
                                                <a class="dropdown-item" href="#">Add Due Date</a>
                                            </div>
                                        </div> <!-- end dropdown -->
                                        
                                        <h4 class="header-title"><?=$nombreEK;?></h4>
                                        <p class="sub-header">
                                            <?=$descripcionEK;?>
                                        </p>
    
                                        <ul class="sortable-list tasklist list-unstyled" id="<?=$nombreEK;?>">
                                        <?php
                                        $sqlAct="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color from actividades a, actividades_prioridades ap where a.cod_prioridad=ap.codigo and a.cod_estadokanban='$codigoEK'";
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
                                        
                                        ?>
                                            <li id="task<?=$codigoActividad;?>">
                                                <span class="badge bg-soft-<?=$colorActividad;?> text-<?=$colorActividad;?> float-end"><?=$nombrePrioridadActividad;?></span>
                                                <h5 class="mt-0"><a href="javascript: void(0);" class="text-dark"><?=$nombreActividad?></a></h5>
                                                <div class="form-check float-end ps-0">
                                                    <input class="form-check-input" type="checkbox" value="">
                                                </div>
                                                <p><?=$obsActividad;?></p>
                                                <div class="clearfix"></div>
                                                <div class="row">
                                                    <div class="col">
                                                        <p class="font-13 mt-2 mb-0"><i class="mdi mdi-calendar"></i><?=$fechaLimiteActividad;?></p>
                                                    </div>
                                                    <div class="col-auto">
                                                        <div class="text-end">
                                                            <a href="javascript: void(0);" class="text-muted">
                                                                <img src="assets2/images/users/user-1.jpg" alt="task-user" class="avatar-sm img-thumbnail rounded-circle">
                                                            </a> 
                                                            <a href="javascript: void(0);" class="text-muted">
                                                                <img src="assets2/images/users/user-3.jpg" alt="task-user" class="avatar-sm img-thumbnail rounded-circle">
                                                            </a> 
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        <?php
                                        }
                                        ?>
                                        <!--Este campo es para la creacion de nuevas tareas-->
                                        <input type="hidden" id="estado_activo" name="estado_activo" value="0">

                                        <div id="ajaxNewTask"></div>

                                        </ul>
                                        <button type="button" class="btn btn-primary m-2" onclick="showModalNewTask(<?=$codigoEK;?>)">Small Modal</button>
                                    </div>
                                </div>
                            </div> <!-- FINALIZANDO COLUMNA -->
                        <?php
                        }
                        ?>
                        </div>
                        <!-- end row -->                        
                    </div> <!-- container -->
                </div> <!-- content -->

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



        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>
        <script src="assets2/libs/sortablejs/Sortable.min.js"></script>
        <!-- Init -->
        <script src="assets2/js/pages/kanban.init.js"></script>
        <!-- App js -->
        <script src="assets2/js/app.min.js"></script>
    </body>
</html>