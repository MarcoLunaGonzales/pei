<?php 
	
	if(isset($_GET['opcion'])){
        //empresas
		if ($_GET['opcion']=='listEmpresas') {
			require_once('empresas/list.php');
		}
		if ($_GET['opcion']=='registerEmpresa') {
			require_once('empresas/register.php');
		}
		if ($_GET['opcion']=='editEmpresa') {
			$codigo=$_GET['codigo'];
			require_once('empresas/edit.php');
		}
		if ($_GET['opcion']=='deleteEmpresa') {
			$codigo=$_GET['codigo'];
			require_once('empresas/saveDelete.php');
		}

		//Tipos de Campos
		if ($_GET['opcion']=='listTiposCampo') {
			require_once('tipos_campo/list.php');
		}
		if ($_GET['opcion']=='registerTipoCampo') {
			require_once('tipos_campo/register.php');
		}
		if ($_GET['opcion']=='editTipoCampo') {
			$codigo=$_GET['codigo'];
			require_once('tipos_campo/edit.php');
		}
		if ($_GET['opcion']=='deleteTipoCampo') {
			$codigo=$_GET['codigo'];
			require_once('tipos_campo/saveDelete.php');
		}


		//Campos personalizados
		if ($_GET['opcion']=='listCamposPersonalizados') {
			require_once('campos_disponibles/list.php');
		}
		if ($_GET['opcion']=='registerCampoPersonalizado') {
			require_once('campos_disponibles/register.php');
		}
		if ($_GET['opcion']=='editCampoPersonalizado') {
			$codigo=$_GET['codigo'];
			require_once('campos_disponibles/edit.php');
		}
		if ($_GET['opcion']=='deleteCampoPersonalizado') {
			$codigo=$_GET['codigo'];
			require_once('campos_disponibles/saveDelete.php');
		}


        //NIVELES DE CONFIGURACION
		if ($_GET['opcion']=='listNivelesConfiguracion') {
			require_once('niveles_configuracion/list.php');
		}
		if ($_GET['opcion']=='registerNivelConfiguracion') {
			require_once('niveles_configuracion/register.php');
		}
		if ($_GET['opcion']=='editNivelConfiguracion') {
			$codigo=$_GET['codigo'];
			require_once('niveles_configuracion/edit.php');
		}
		if ($_GET['opcion']=='deleteNivelConfiguracion') {
			$codigo=$_GET['codigo'];
			require_once('niveles_configuracion/saveDelete.php');
		}			
		if ($_GET['opcion']=='NivelesRegisterFields') {
			$codigo=$_GET['codigo'];
			require_once('niveles_configuracion/registerCampos.php');
		}
		
		if ($_GET['opcion']=='registerOfPOA') {
			require_once('niveles_configuracion/registerOfPOA.php');
		}
		if ($_GET['opcion']=='registerOfArea') {
			$codigo=$_GET['codigo'];
			require_once('niveles_configuracion/registerOfArea.php');
		}		
		if ($_GET['opcion']=='registerOfHijo') {
			$codigo=$_GET['codigo'];
			require_once('niveles_configuracion/registerOfHijo.php');
		}		

	}else{
		require_once("principal.php");
	}

 ?>