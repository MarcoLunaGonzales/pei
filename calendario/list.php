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

                                        <div class="col-lg-12">
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
                            <!-- end modal-->
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

        <!-- <script>
            document.addEventListener('DOMContentLoaded', function() {
                let calendarEl = document.getElementById('calendar');

                let calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    height: 550,
                    locale:'es',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek'
                    },
                    buttonText:{
                        timeGridWeek:'Semana',
                        dayGridMonth:'Mes',
                        today:'Hoy',
                    },
                    editable: false,
                    events:  'calendario/ajaxActivity.php',
                });

                calendar.render();
            });
        </script> -->
        
    </body>
</html>