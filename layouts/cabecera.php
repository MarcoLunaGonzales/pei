<?php 

  require_once("conexion.php");
  $dbh = new Conexion();

  $nombreUnidadCabecera=$_SESSION["globalNameUO"];
  $nombreAreaCabecera=$_SESSION["globalNameArea"]; 
  $nombreUsuario=$_SESSION["globalNameUser"]; 
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>PEI - Ibnorca</title>
  <!--favicon-->
  <link rel="icon" href="assets/images/favicon-32x32.png" type="image/png" />
  <!--plugins-->
  <link href="assets/plugins/select2/css/select2.min.css" rel="stylesheet" />
  <link href="assets/plugins/select2/css/select2-bootstrap4.css" rel="stylesheet" />
  <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet" />
  <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet" />
  <link href="assets/plugins/metismenu/css/metisMenu.min.css" rel="stylesheet" />
  
  <!-- loader-->
  <link href="assets/css/pace.min.css" rel="stylesheet" />
  <script src="assets/js/pace.min.js"></script>
  <script src="assets/js/sweetalert2.js"></script>
  <script src="assets/js/alertsJS.js"></script>
  <script src="assets/js/functionsJS.js"></script>


  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
  <!-- Icons CSS -->
  <link rel="stylesheet" href="assets/css/icons.css" />
  <!--link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"-->
  <!-- App CSS -->
  <link rel="stylesheet" href="assets/css/app.css" />
  <link rel="stylesheet" href="assets/css/dark-header.css" />
  <link rel="stylesheet" href="assets/css/dark-theme.css" />
</head>

<body>
  <!-- wrapper -->
  <div class="wrapper">
    <!--header-->
    <header class="top-header">
      <nav class="navbar navbar-expand">
        <div class="sidebar-header">
          <div class="d-none d-lg-flex">
            <img src="assets/images/logo-icon.png" class="logo-icon-2" alt="" />
          </div>
          <div>
            <h4 class="d-none d-lg-flex logo-text">PEI</h4>
          </div>
          <a href="javascript:;" class="toggle-btn ml-lg-auto"> <i class="bx bx-menu"></i>
          </a>
        </div>
        <div class="flex-grow-1 search-bar">
          <div class="input-group">
            <div class="input-group-prepend search-arrow-back">
              <button class="btn btn-search-back" type="button"><i class="bx bx-arrow-back"></i>
              </button>
            </div>
            <input type="text" class="form-control" placeholder="search" />
            <div class="input-group-append">
              <button class="btn btn-search" type="button"><i class="lni lni-search-alt"></i>
              </button>
            </div>
          </div>
        </div>
        <div class="right-topbar ml-auto">
          <ul class="navbar-nav">
            <li class="nav-item dropdown dropdown-lg">
              <a class="nav-link dropdown-toggle dropdown-toggle-nocaret position-relative" href="javascript:;" data-toggle="dropdown"> <i class="bx bx-bell vertical-align-middle"></i>
                <span class="msg-count">8</span>
              </a>
              <div class="dropdown-menu dropdown-menu-right">
                <a href="javascript:;">
                  <div class="msg-header">
                    <h6 class="msg-header-title">8 New</h6>
                    <p class="msg-header-subtitle">Application Notifications</p>
                  </div>
                </a>
                <div class="header-notifications-list">
                  <a class="dropdown-item" href="javascript:;">
                    <div class="media align-items-center">
                      <div class="notify bg-light-success text-success"><i class='bx bx-check-square'></i>
                      </div>
                      <div class="media-body">
                        <h6 class="msg-name">Your item is shipped <span class="msg-time float-right">5 hrs
                          ago</span></h6>
                        <p class="msg-info">Successfully shipped your item</p>
                      </div>
                    </div>
                  </a>
                  <a class="dropdown-item" href="javascript:;">
                    <div class="media align-items-center">
                      <div class="notify bg-light-sinata text-sinata"><i class='bx bx-user-pin'></i>
                      </div>
                      <div class="media-body">
                        <h6 class="msg-name">New 24 authors<span class="msg-time float-right">1 day
                          ago</span></h6>
                        <p class="msg-info">24 new authors joined last week</p>
                      </div>
                    </div>
                  </a>
                  <a class="dropdown-item" href="javascript:;">
                    <div class="media align-items-center">
                      <div class="notify bg-light-mehandi text-mehandi"><i class='bx bx-door-open'></i>
                      </div>
                      <div class="media-body">
                        <h6 class="msg-name">Defense Alerts <span class="msg-time float-right">2 weeks
                          ago</span></h6>
                        <p class="msg-info">45% less alerts last 4 weeks</p>
                      </div>
                    </div>
                  </a>
                </div>
                <a href="javascript:;">
                  <div class="text-center msg-footer">View All Notifications</div>
                </a>
              </div>
            </li>
            <li class="nav-item dropdown dropdown-user-profile">
              <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" href="javascript:;" data-toggle="dropdown">
                <div class="media user-box align-items-center">
                  <div class="media-body user-info">
                    <p class="user-name mb-0"><?=$nombreUsuario;?></p>
                    <p class="designattion mb-0"><?=$nombreUnidadCabecera;?>/<?=$nombreAreaCabecera;?></p>
                  </div>
                  <img src="https://via.placeholder.com/110x110" class="user-img" alt="user avatar">
                </div>
              </a>
              <div class="dropdown-menu dropdown-menu-right"> <a class="dropdown-item" href="javascript:;"><i
                    class="bx bx-user"></i><span>Profile</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="bx bx-cog"></i><span>Settings</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="bx bx-tachometer"></i><span>Dashboard</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="bx bx-wallet"></i><span>Earnings</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="bx bx-cloud-download"></i><span>Downloads</span></a>
                <div class="dropdown-divider mb-0"></div> 
                  <a class="dropdown-item" href="#" >
                    <i class="bx bx-power-off"></i>
                    <span>Cerrar Sesión</span>
                  </a>
              </div>
            </li>
            <!--li class="nav-item dropdown dropdown-language">
              <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" href="javascript:;" data-toggle="dropdown">
                <div class="lang d-flex">
                  <div><i class="flag-icon flag-icon-um"></i>
                  </div>
                  <div><span>En</span>
                  </div>
                </div>
              </a>
              <div class="dropdown-menu dropdown-menu-right"> <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-de"></i><span>German</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-fr"></i><span>French</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-um"></i><span>English</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-in"></i><span>Hindi</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-cn"></i><span>Chinese</span></a>
                <a class="dropdown-item" href="javascript:;"><i
                    class="flag-icon flag-icon-ae"></i><span>Arabic</span></a>
              </div>
            </li-->
          </ul>
        </div>
      </nav>
    </header>
    <!--end header-->


