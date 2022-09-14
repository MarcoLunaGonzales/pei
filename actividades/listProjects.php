<?php
require_once 'conexion.php';
require_once 'layouts/body_empty2.php';

$globalUnidadX=$_SESSION["globalUO"];
$globalAreaX=$_SESSION["globalArea"];

$nombreUnidadCabecera = $_SESSION["globalNameUO"];
$nombreAreaCabecera   = $_SESSION["globalNameArea"]; 
$cod_personal         = $_SESSION['globalUser'];

$dbh = new Conexion();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Project Listing | UBold - Responsive Admin Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="A fully featured admin theme which can be used to build CRM, CMS, etc." name="description" />
        <meta content="Coderthemes" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="assets2/images/favicon.ico">

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
    <body data-theme="light" data-layout-mode="horizontal" data-topbar-color="dark" data-menu-position="fixed">

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
                                    <div class="page-title-right">
                                        <!--ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">UBold</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Projects</a></li>
                                            <li class="breadcrumb-item active">Projects List</li>
                                        </ol-->
                                    </div>
                                    <h4 class="page-title">Lista de Proyectos Asignados</h4>
                                </div>
                            </div>
                        </div>     
                        <!-- end page title --> 

                        <div class="row mb-2">
                            <!--div class="col-sm-4">
                                <a href="project-create.html" class="btn btn-danger rounded-pill waves-effect waves-light mb-3"><i class="mdi mdi-plus"></i> Create Project</a>
                            </div-->
                            <div class="col-sm-8">
                                <!--div class="text-sm-end">
                                    <div class="btn-group mb-3">
                                        <button type="button" class="btn btn-primary">All</button>
                                    </div>
                                    <div class="btn-group mb-3 ms-1">
                                        <button type="button" class="btn btn-light">Ongoing</button>
                                        <button type="button" class="btn btn-light">Finished</button>
                                    </div>
                                    <div class="btn-group mb-3 ms-2 d-none d-sm-inline-block">
                                        <button type="button" class="btn btn-dark"><i class="mdi mdi-apps"></i></button>
                                    </div>
                                    <div class="btn-group mb-3 d-none d-sm-inline-block">
                                        <button type="button" class="btn btn-link text-dark"><i class="mdi mdi-format-list-bulleted-type"></i></button>
                                    </div>
                                </div-->
                            </div><!-- end col-->
                        </div> 
                        <!-- end row-->


                        <div class="row">
                            <?php
                            $sqlProj="SELECT np.codigo, 
                                np.nombre, 
                                np.abreviatura, 
                                (SELECT COUNT(*) as act_total
                                FROM actividades a
                                LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
                                WHERE a.cod_componentepei = np.codigo
                                AND a.cod_padre is null
                                AND a.cod_responsable = '$cod_personal'
                                OR aco.cod_personal = '$cod_personal') as act_total,

                                (SELECT COUNT(aa.codigo)
                                FROM actividades a
                                LEFT JOIN actividades_anotaciones aa ON aa.cod_actividad = a.codigo
                                LEFT JOIN actividades_colaboradores aco ON aco.cod_actividad = a.codigo
                                WHERE a.cod_componentepei = np.codigo
                                AND aa.cod_estado = 1
                                AND a.cod_padre is null
                                AND a.cod_responsable = '$cod_personal'
                                OR aco.cod_personal = '$cod_personal') as ant_total
                            from niveles_pei np, nivelespei_unidadesareas npua 
                            where np.codigo=npua.cod_nivelpei 
                            and npua.cod_area='$globalAreaX' 
                            and npua.cod_unidadorganizacional='$globalUnidadX'";
                            //echo $sqlProj;
                            $stmtProj= $dbh->prepare($sqlProj);
                            $stmtProj->execute();
                            while ($rowProj = $stmtProj->fetch(PDO::FETCH_ASSOC)) {
                                $codigoProyecto=$rowProj['codigo'];
                                $nombreProyecto=$rowProj['nombre'];
                                $totalActividades=$rowProj['act_total'];
                                $totalAnotaciones=$rowProj['ant_total'];
                                $abreviaturaProyecto=$rowProj['abreviatura'];
                            ?>
                            <div class="col-lg-4">
                                <div class="card project-box">
                                    <div class="card-body">
                                        <!-- Title-->
                                        <h4 class="mt-0"><a href="index.php?opcion=listTasks&cod_proyecto=<?=$codigoProyecto;?>" class="text-dark"><?=$nombreProyecto;?></a></h4>
                                        <p class="text-muted text-uppercase"><i class="mdi mdi-account-circle"></i> <small><?=$abreviaturaProyecto;?></small></p>
                                        <!-- Task info-->
                                        <p class="mb-1">
                                            <span class="pe-2 text-nowrap mb-2 d-inline-block">
                                                <i class="mdi mdi-format-list-bulleted-type text-muted"></i>
                                                <b><?=$totalActividades;?></b> Actividades
                                            </span>
                                            <span class="text-nowrap mb-2 d-inline-block">
                                                <i class="mdi mdi-comment-multiple-outline text-muted"></i>
                                                <b><?=$totalAnotaciones;?></b> Comentarios
                                            </span>
                                        </p>
                                        <!-- Team-->
                                        <!-- <div class="avatar-group mb-3" id="tooltips-container">
                                            <a href="javascript: void(0);" class="avatar-group-item">
                                                <img src="assets2/images/users/user-1.jpg" class="rounded-circle avatar-sm" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Mat Helme" />
                                            </a>
    
                                            <a href="javascript: void(0);" class="avatar-group-item">
                                                <img src="assets2/images/users/user-2.jpg" class="rounded-circle avatar-sm" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Michael Zenaty" />
                                            </a>
    
                                            <a href="javascript: void(0);" class="avatar-group-item">
                                                <img src="assets2/images/users/user-3.jpg" class="rounded-circle avatar-sm" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="James Anderson" />
                                            </a>
    
                                            <a href="javascript: void(0);" class="avatar-group-item">
                                                <img src="assets2/images/users/user-4.jpg" class="rounded-circle avatar-sm" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Mat Helme" />
                                            </a>
    
                                            <a href="javascript: void(0);" class="avatar-group-item">
                                                <img src="assets2/images/users/user-5.jpg" class="rounded-circle avatar-sm" alt="friend" data-bs-container="#tooltips-container" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Username" />
                                            </a>
                                        </div> -->
                                        <!-- Progress-->
                                        <!--p class="mb-2 fw-semibold">Task completed: <span class="float-end">28/78</span></p>
                                        <div class="progress mb-1" style="height: 7px;">
                                            <div class="progress-bar"
                                                 role="progressbar" aria-valuenow="34" aria-valuemin="0" aria-valuemax="100"
                                                 style="width: 34%;">
                                            </div>
                                        </div--><!-- /.progress .no-rounded -->
                                    </div>
                                </div> <!-- end card box-->
                            </div><!-- end col-->
                            <?php 
                            }
                            ?>


                        </div>
                        <!-- end row -->

                        
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

        <!-- Vendor js -->
        <script src="assets2/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="assets2/js/app.min.js"></script>
        
    </body>
</html>