<?php
	//carga la plantilla con la header y el footer
require_once 'conexion.php';
require_once 'functions.php';
require_once 'functionsGeneralJS.php';
set_time_limit(0);
ini_set("session.cookie_lifetime","28800");
ini_set("session.gc_maxlifetime","28800");
  
session_start();
if(isset($_SESSION['logueado'])){
	require_once('layouts/layout.php');	
	//echo "entro por logueado";
}else{
	//echo "entro sin login";
	header("location:login.html");	
}

 ?>
