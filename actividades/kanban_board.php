<?php
    require_once 'conexion.php';
    require_once 'layouts/body_empty.php';

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

        <!-- Style input type FILE -->
		<link href="assets/css/customStyle.css" rel="stylesheet" type="text/css" />

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
                    <div class="container-fluid ml-0 mr-0">
                        
                        <!-- start page title -->
                        <div class="row">
                            <div class="col-lg-12">
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
                        $array_colors = ['secondary', 'primary', 'warning', 'success', 'danger', 'info'];
                        $count_array  = count($array_colors) - 1;
                        $count_val    = 0;
                        $sqlEK="SELECT ek.codigo, ek.nombre, ek.descripcion 
                        from estados_kanban ek 
                        where ek.cod_estado = 1
                        and ek.codigo < 5
                        order by 1";
                        $stmtEK= $dbh->prepare($sqlEK);
                        $stmtEK->execute();
                        while ($rowEK = $stmtEK->fetch(PDO::FETCH_ASSOC)) {
                            $codigoEK=$rowEK['codigo'];
                            $nombreEK=$rowEK['nombre'];
                            $descripcionEK=$rowEK['descripcion'];
                        ?>
                            <div class="col-lg-3">
                                <div class="card">
                                    <div class="card-header bg-<?=$array_colors[$count_val];?>">
                                        <h4 class="header-title text-white"><?=$nombreEK;?></h4>
                                    </div>
                                    <div class="card-body">
    
                                        <ul class="sortable-list tasklist list-unstyled border" id="<?=$nombreEK;?>" ondrop="drop(this)" data-estado_tablero="<?=$codigoEK;?>">
                                        <?php
                                        $count_val = ($count_val != $count_array) ? ($count_val + 1) : 0;
                                        
                                        $sqlAct="SELECT a.codigo, a.nombre, a.cod_estadokanban as estado, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color 
                                        from actividades a
                                        LEFT JOIN actividades_prioridades ap ON ap.codigo = a.cod_prioridad
                                        LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
                                        WHERE a.cod_estadokanban = '$codigoEK'
                                        AND a.cod_padre is null
                                        AND (a.cod_responsable = '$cod_personal' OR aco.cod_personal = '$cod_personal')";
                                        $stmtAct= $dbh->prepare($sqlAct);
                                        $stmtAct->execute();
                                        while ($rowAct = $stmtAct->fetch(PDO::FETCH_ASSOC)) {
                                            $codigoActividad=$rowAct['codigo'];
                                            $nombreActividad=$rowAct['nombre'];
                                            $estadoActividad=$rowAct['estado']+1;
                                            $obsActividad=$rowAct['observaciones'];
                                            $fechaLimiteActividad=$rowAct['fecha_limite'];
                                            $codPrioridadActividad=$rowAct['cod_prioridad'];
                                            $nombrePrioridadActividad=$rowAct['nombre_prioridad'];
                                            $colorActividad=$rowAct['color'];
                                            /**
                                             * Lista de Colaboradores asignados a la Actividad
                                             * @autor: Ronald Mollericona
                                            **/
                                            $sqlColl = "SELECT ac.cod_personal as codigo_personal, 
                                            CONCAT(p.primer_nombre, ' ', p.paterno, ' ', p.materno) as nombre_compl,
                                            pimg.imagen as imagen_personal,
                                            ac.cod_estado as estado
                                            FROM actividades_colaboradores ac
                                            LEFT JOIN personal p on p.codigo = ac.cod_personal
                                            LEFT JOIN personalimagen pimg on pimg.codigo = ac.cod_personal
                                            WHERE ac.cod_actividad = $codigoActividad
                                            AND ac.cod_estado = 1";
                                            $stmtColl = $dbh->prepare($sqlColl);
                                            $stmtColl->execute();
                                            $rows_coll = $stmtColl->fetchAll();
                                        ?>
                                            <li draggable="true" ondragstart="drag(this)" id="task<?=$codigoActividad;?>" data-cod_actividad="<?=$codigoActividad;?>" data-estado_actual="<?=$estadoActividad-1;?>">
                                                <span class="badge bg-soft-<?=$colorActividad;?> text-<?=$colorActividad;?> float-end"><?=$nombrePrioridadActividad;?></span>                                                
                                                <h5 class="mt-0"><a href="javascript: void(0);" class="text-dark" onclick="javascript:showModallistTaskDetail(<?=$codigoActividad?>)"><?=$nombreActividad?></a></h5>
                                                <?php if(($estadoActividad - 1)< 4){ ?>
                                                <?php } ?>
                                                <p><?=$obsActividad;?></p>
                                                <div class="clearfix"></div>
                                                <div class="row">
                                                    <div class="col">
                                                        <p class="font-13 mt-2 mb-0"><i class="mdi mdi-calendar"></i><?=$fechaLimiteActividad;?></p>
                                                    </div>
                                                    <div class="col-auto">
                                                        <div class="text-end">
                                                            <?php
                                                                foreach($rows_coll as $collaborator){
                                                            ?>
                                                                <a href="javascript: void(0);" class="text-muted">
                                                                    <img src="<?=$ruta;?><?=$collaborator['imagen_personal'];?>" alt="task-user" class="avatar-sm img-thumbnail rounded-circle" title="<?=$collaborator['nombre_compl'];?>">
                                                                </a> 
                                                            <?php
                                                                }
                                                            ?>
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
                                        <!-- <button type="button" class="btn btn-primary m-2" onclick="showModalNewTask(<?=$codigoEK;?>)">Small Modal</button> -->
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

    <!-- Detalle de Información Actividad -->
    <div class="modal fade" id="modal_task_detail" tabindex="-1" role="dialog" aria-labelledby="scrollableModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div id="div_task_detail">
                </div>
            </div>
        </div>
    </div>
    <!-- Detalle -->  

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
        <!-- Modal Nuevo Archivo -->
        <div class="modal fade" id="modalNewFile" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-top">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <h5 class="modal-title text-white">Añadir Archivo</h5>
                        <button type="button" class="btn-close bg-white close-file" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="form-file">
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="col-sm-12 col-form-label">Detalle</label>
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                            <textarea rows="3" class="form-control" name="detail_file" id="detail_file" placeholder="Ingrese detalle de Archivo.." autocomplete="off"></textarea>
                                            </div>
                                        </div>
                                        <label class="col-sm-12 col-form-label">Archivo</label>
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                            <input class="form-control" type="file" name="file" id="file"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary close-file" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary save-file">Guardar</button>
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
                                    <label class="col-form-label">Financiamiento:</label>
                                    <select name="cod_account" id="cod_account" class="form-control" data-style="btn btn-warning" required>
                                        <?php             
                                            $sqlFinancing   = "SELECT pf.codigo, pf.abreviatura, pf.nombre 
                                                FROM proyectos_financiacionexterna pf";
                                            $stmtFinancing  = $dbh->prepare($sqlFinancing);
                                            $stmtFinancing->execute();
                                            $rows_financing = $stmtFinancing->fetchAll();
                                            foreach ($rows_financing as $financing){       
                                        ?>
                                        <option value="<?= $financing['codigo']; ?>"  ><?= $financing['nombre']; ?></option>
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

        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>
        <script src="assets2/libs/sortablejs/Sortable.min.js"></script>
        <!-- Init -->
        <script src="assets2/js/pages/kanban.init.js"></script>
        <!-- App js -->
        <script src="assets2/js/app.min.js"></script>
        <!-- Script - Lista de Actividades -->
        <script src="assets/js/functionActivity.js"></script>
        <script>
            // Modificación de Estado KANBAN
            $('body').on('click', '.update_state_k', function(){
                let code_activity = $(this).data('cod_actividad');
                let estado        = $(this).data('estado');

                let formData = new FormData();
                formData.append('type', 7);         // Tipo 7 : Actualización de Datos
                formData.append('data', estado);
                formData.append('select_data', 5);
                formData.append('code_activity', code_activity);
                
                $.ajax({
                    url:"actividades/methods.php",
                    type:"POST",
                    contentType: false,
                    processData: false,
                    data: formData,
                    success:function(response){
                        let resp = JSON.parse(response);
                        $('#modalNewSubActivity').modal('hide');
                        swal({
                            title: 'Exitoso!',
                            text: "Se actualizo el estado correctamente!",
                            type: 'success',
                            showCancelButton: false,
                            confirmButtonClass: 'btn btn-primary',
                            confirmButtonText: 'Aceptar',
                            buttonsStyling: false
                        }).then((result) => {
                            if (result.value) {
                                location.reload();
                            }
                        });
                    }
                    
                });
            });
            
            /**
             * Acción de actualización de estado
            */
            let cod_actividad_kanban = 0;
            let estado_actual = 0;
            let elemento_id   = 0;
            // En arrastre
            function drag(item) {
                cod_actividad_kanban = item.dataset.cod_actividad; // Codigo Actividad
                estado_actual        = item.dataset.estado_actual; // Estado Actual
                elemento_id          = item.id;                    // ID elemento
            }
            // En Caida, cambio de estado Actividad
            function drop(item) {
                let estado_kanban = item.dataset.estado_tablero; // Nuevo Estado de Actividad
                let formData      = new FormData();
                formData.append('type', 7);         // Tipo 7 : Actualización de Datos
                formData.append('data', estado_kanban);
                formData.append('select_data', 5);
                formData.append('code_activity', cod_actividad_kanban);
                if(estado_kanban < estado_actual){
                    notificacionMsg("No se puede retroceder el estado de la Actividad!");
                }else if(estado_kanban == 5){
                    notificacionMsg("No se puede realizar esta acción");
                }else if(estado_kanban > estado_actual){
                    // Actualización de Data-Estado
                    document.getElementById(elemento_id).dataset.estado_actual = estado_kanban;
                    $.ajax({
                        url:"actividades/methods.php",
                        type:"POST",
                        contentType: false,
                        processData: false,
                        data: formData,
                        success:function(response){
                            let resp = JSON.parse(response);
                            responseAlert(resp.status);
                        }
                    });
                }
            }
            /* Notificación de Mensaje de cambio de Estado */
            function notificacionMsg(mssg){
                swal({
                    title: 'Oops!',
                    text: mssg,
                    type: 'warning',
                    showCancelButton: false,
                    confirmButtonClass: 'btn btn-primary',
                    confirmButtonText: 'Aceptar',
                    buttonsStyling: false
                }).then((result) => {
                    if (result.value) {
                        location.reload();
                    }
                });
            }
        </script>
    </body>
</html>