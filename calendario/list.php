<?php
require_once 'conexion.php';
require_once 'layouts/body_empty2.php';

$globalUnidadX=$_SESSION["globalUO"];
$globalAreaX=$_SESSION["globalArea"];

$nombreUnidadCabecera = $_SESSION["globalNameUO"];
$nombreAreaCabecera   = $_SESSION["globalNameArea"]; 
$cod_personal         = $_SESSION['globalUser'];

$dbh = new Conexion();
// Codigo de PERSONAL Logueado
$cod_personal = $_SESSION['globalUser'];

/* Obtenemos Configuración de ruta de imagenes */
$sqlFind = "SELECT * FROM configuraciones
WHERE id_configuracion = 2";
$stmtFind = $dbh->prepare($sqlFind);
$stmtFind->execute();
while ($row = $stmtFind->fetch(PDO::FETCH_ASSOC)) {
    $ruta  = $row['valor_configuracion'];
}
?>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Calendar | UBold - Responsive Admin Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets2/images/favicon.ico">

        <!-- Plugin css -->
        <link href="assets2/libs/fullcalendar/main.min.css" rel="stylesheet" type="text/css" />

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
        <style>
            .external-event{
                cursor: default;
            }
        </style>
    </head>

        <!-- body start -->
        <body  data-layout-mode="detached" data-theme="light" data-topbar-color="dark" data-menu-position="fixed" data-leftbar-color="light" data-leftbar-size='default' data-sidebar-user='true'>


        <!-- Begin page -->
        <div id="wrapper">

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content">

                <!-- Start Content-->
                <div class="container-fluid">
                    <!-- start page title -->
                    <div class="row">
                        <div class="col-12">
                            <div class="page-title-box">
                                <h4 class="page-title">Calendario</h4>
                            </div>
                        </div>
                    </div>     
                    <!-- end page title --> 
                    <div class="row">
                        <div class="col-12">

                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-2">
                                            <button class="btn btn-lg font-16 btn-primary w-100" id="new-event">
                                                <i class="mdi mdi-plus-circle-outline"></i> Nuevo Evento</button>
                                            
                                            <div id="external-events">
                                                <br>
                                                <h5>Descripción de Eventos</h5>
                                                <div class="external-event bg-success" data-class="bg-success">
                                                    <i class="mdi mdi-checkbox-blank-circle me-2 vertical-middle"></i>Hitos
                                                </div>
                                                <div class="external-event bg-primary" data-class="bg-info">
                                                    <i class="mdi mdi-checkbox-blank-circle me-2 vertical-middle"></i>Inicio de Actividad
                                                </div>
                                                <div class="external-event bg-danger" data-class="bg-danger">
                                                    <i class="mdi mdi-checkbox-blank-circle me-2 vertical-middle"></i>Fin de Actividad
                                                </div>
                                                <div class="external-event bg-warning" data-class="bg-warning">
                                                    <i class="mdi mdi-checkbox-blank-circle me-2 vertical-middle"></i>Eventos Personales
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-10">
                                            <div id="calendar"></div>
                                        </div> <!-- end col -->

                                    </div>  <!-- end row -->
                                </div> <!-- end card body-->
                            </div> <!-- end card -->

                            <!-- Add New Event MODAL -->
                            <div class="modal fade" id="event-modal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header py-3 px-4 border-bottom-0 d-block">
                                            <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                                            <h5 class="modal-title" id="modal-title">Event</h5>
                                        </div>
                                        <div class="modal-body px-4 pb-4 pt-0">
                                            <form class="needs-validation" name="event-form" id="form-event" novalidate>
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Event Name</label>
                                                            <input class="form-control" placeholder="Insert Event Name"
                                                                type="text" name="title" id="event-title" required />
                                                            <div class="invalid-feedback">Please provide a valid event name</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Category</label>
                                                            <select class="form-select" name="category" id="event-category" required>
                                                                <option value="bg-danger" selected>Danger</option>
                                                                <option value="bg-success">Success</option>
                                                                <option value="bg-primary">Primary</option>
                                                                <option value="bg-info">Info</option>
                                                                <option value="bg-dark">Dark</option>
                                                                <option value="bg-warning">Warning</option>
                                                            </select>
                                                            <div class="invalid-feedback">Please select a valid event category</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col-md-6 col-4">
                                                        <button type="button" class="btn btn-danger" id="btn-delete-event">Delete</button>
                                                    </div>
                                                    <div class="col-md-6 col-8 text-end">
                                                        <button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-success" id="btn-save-event">Save</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div> <!-- end modal-content-->
                                </div> <!-- end modal dialog-->
                            </div>
                            <!-- Modal para Crear Evento -->
                            <div class="modal fade" id="new-event-modal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header py-3 px-4 border-bottom-0 d-block">
                                            <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                                            <h5 class="modal-title" id="modal-title">Nuevo Evento</h5>
                                        </div>
                                        <div class="modal-body px-4 pb-4 pt-0">
                                            <form id="new-form-event">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Detalle:</label>
                                                            <input class="form-control" placeholder="Insert Event Name"
                                                                type="text" name="title" id="detalle"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-12">
                                                        <div class="mb-3">
                                                            <label class="form-label">Fecha:</label>
                                                            <input class="form-control" placeholder="Insert Event Name"
                                                                type="date" min="<?=date('Y-m-d');?>" name="title" id="fecha"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Hora Inicio:</label>
                                                            <input class="form-control" placeholder="Insert Event Name" type="time" name="title" id="inicio"/>
                                                        </div>
                                                    </div>
                                                    <div class="col-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Hora Fin:</label>
                                                            <input class="form-control" placeholder="Insert Event Name"
                                                                type="time" name="title" id="fin"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col-md-12 text-end">
                                                        <button type="submit" class="btn btn-primary" id="save-event">Guardar</button>
                                                        <button type="button" class="btn btn-danger me-1" data-bs-dismiss="modal">Cancelar</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div> <!-- end modal-content-->
                                </div> <!-- end modal dialog-->
                            </div>
                            <!-- end modal-->
                            <!-- Detalle de Información Actividad -->
                            <div class="modal fade" id="modal_task_detail" tabindex="-1" role="dialog" aria-labelledby="scrollableModalTitle" aria-hidden="true">
                                <div class="modal-dialog modal-xl" role="document">
                                    <div class="modal-content">
                                        <div id="div_task_detail">
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                                        <select name="cod_personal" id="cod_personal" class="form-control" data-style="btn btn-warning" required>
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
                                                            <option value="">-</option>
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
                            <!-- Detalle -->  
                        </div>
                        <!-- end col-12 -->
                    </div> <!-- end row -->
                    
                </div> <!-- container -->

            </div> <!-- content -->

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->


        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>

        <!-- plugin js -->
        <script src="assets2/libs/moment/min/moment.min.js"></script>
        <script src="assets2/libs/fullcalendar/main.min.js"></script>

        <!-- Calendar init -->
        <script src="assets2/js/pages/calendar.init.js"></script>

        <!-- App js -->
        <script src="assets2/js/app.min.js"></script> 
        <!-- Script - Lista de Actividades -->
        <script src="assets/js/functionActivity.js"></script>
        <script>
            $('#new-event').click(function(){
                $('#new-event-modal').modal('show');
            });
            
            /**
             * Registro de Nuevo Evento
             **/
            $('body').on('click', '#save-event', function(){
                let detalle = $('#detalle').val();
                let fecha   = $('#fecha').val();
                let inicio  = $('#inicio').val();
                let fin     = $('#fin').val();
                if(detalle != '' && fecha != '' && inicio != '' && fin != ''){
                    let formData = new FormData();
                    formData.append('detalle', detalle);
                    formData.append('fecha', fecha);
                    formData.append('inicio', inicio);
                    formData.append('fin', fin);
                    $.ajax({
                        url:"calendario/methods.php",
                        type:"POST",
                        contentType: false,
                        processData: false,
                        data: formData,
                        success:function(response){
                            let resp = JSON.parse(response);
                            responseAlert(resp.status);
                            // location.reload();
                        }
                    });

                }else{
                    Swal.fire(
                        'Oops...',
                        'Debe llenar los campos del formulario',
                        'warning'
                    );
                }
            });

            /**
             * Mensaje de alerta despues de recibir respuesta del BACKEND
             **/
            function responseAlert(status){
                if(status){
                    Swal.fire(
                        'Correcto!',
                        'El proceso se completo correctamente',
                        'success'
                    );
                }else{
                    Swal.fire(
                        'Oops...',
                        '¡Algo salió mal!',
                        'error'
                    );
                }
            }
        </script>       
    </body>
</html>