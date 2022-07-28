<?php 
	
	if(isset($_GET['opcion'])){
        //UNIDADES ORGANIZACIONALES
		if ($_GET['opcion']=='listNivelesPlan') {
			require_once('niveles_plan/list.php');
		}
		if ($_GET['opcion']=='registerNivelPlan') {
			require_once('niveles_plan/register.php');
		}
		if ($_GET['opcion']=='editUnidadOrg') {
			$codigo=$_GET['codigo'];
			require_once('niveles_plan/edit.php');
		}
		if ($_GET['opcion']=='deleteUnidadOrg') {
			$codigo=$_GET['codigo'];
			require_once('niveles_plan/saveDelete.php');
		}		
		if ($_GET['opcion']=='registerOfPOA') {
			require_once('niveles_plan/registerOfPOA.php');
		}
		if ($_GET['opcion']=='registerOfArea') {
			$codigo=$_GET['codigo'];
			require_once('niveles_plan/registerOfArea.php');
		}		
		if ($_GET['opcion']=='registerOfHijo') {
			$codigo=$_GET['codigo'];
			require_once('niveles_plan/registerOfHijo.php');
		}		

	}else{
		require_once("principal.php");
	}

 ?>