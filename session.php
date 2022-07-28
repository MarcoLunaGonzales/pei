<?php
require_once 'functions.php';
require_once 'conexion.php';
// tiempo de la sesion por 8 horas

$dbh = new Conexion();
session_start();

date_default_timezone_set('America/La_Paz');

$user=$_POST["user"];
$password=$_POST["password"];

//OBTENEMOS EL VALOR DE LA CONFIGURACION 1 -> LOGIN PROPIO DE MONITOREO    2-> LOGIN POR SERVICIO WEB
$tipoLogin=obtieneValorConfig(-10);
$banderaLogin=0;
if($tipoLogin==2){
	//echo "entro por Servicio Ibnor";
	$sIdentificador = "ifinanciero";
	$sKey="ce94a8dabdf0b112eafa27a5aa475751";
	$nombreuser=$user;
	$claveuser=$password;
	$claveuser=md5($password);
	$datos=array("sIdentificador"=>$sIdentificador, "sKey"=>$sKey, 
				 "operacion"=>"Login", "nombreUser"=>$nombreuser, "claveUser"=>$claveuser);
	$datos=json_encode($datos);
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,"http://ibnored.ibnorca.org/wsibno/verifica/ws-user-personal.php");
	curl_setopt($ch, CURLOPT_POST, TRUE);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $datos);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$remote_server_output = curl_exec ($ch);
	curl_close ($ch);
	$obj=json_decode($remote_server_output);

	header('Content-type: application/json'); 	
	print_r($remote_server_output); 

	$banderaLogin=$obj->estado;
	if($banderaLogin=="true"){
		$banderaLogin=1;
	}
	$idUsuarioSW=$obj->usuario->IdUsuario;
	$idUsuarioSW2=$obj->usuario->IdClienteContacto;

}

if($banderaLogin==1 || $tipoLogin==1){
	//echo "entro por modulo propio";
	$sql="";
	if($tipoLogin==1){
		$sql="SELECT p.codigo, p.nombre, p.cod_area, p.cod_unidad as cod_unidadorganizacional, pd.perfil from personal2 p, personal_datosadicionales pd 
		where p.codigo=pd.cod_personal and pd.usuario='$user' and pd.contrasena='$password'";		
	}else{
		$sql="SELECT p.codigo, CONCAT_WS(' ',p.paterno,p.materno,p.primer_nombre)as nombre, p.cod_area, p.cod_unidadorganizacional, 1 as perfil
			from personal p 
			where (p.codigo='$idUsuarioSW' or p.codigo='$idUsuarioSW2') ";		
	}

	//echo $sql;
	$stmt = $dbh->prepare($sql);
	$stmt->execute();
	$stmt->bindColumn('codigo', $codigo);
	$stmt->bindColumn('nombre', $nombre);
	$stmt->bindColumn('cod_area', $codArea);
	$stmt->bindColumn('cod_unidadorganizacional', $codUnidad);
	$stmt->bindColumn('perfil', $perfil);

	while ($rowDetalle = $stmt->fetch(PDO::FETCH_BOUND)) {
		//echo "ENTRO A DETALLE";
		
		//echo "usuario: ".$idUsuarioSW." unidad: ".$codUnidad;
		if($codUnidad>0){
			$nombreUnidad=abrevUnidad($codUnidad);
		}
		if($codArea>0){
			$nombreArea=abrevArea($codArea);
		}

		$_SESSION['globalUser']=$codigo;
		$_SESSION['globalNameUser']=$nombre;

		$_SESSION['logueado']=1;
		$_SESSION['globalPerfil']=$perfil;

		$_SESSION['globalAdmin']=1;

		/*$sIdentificador = "ifinanciero";
		$sKey="ce94a8dabdf0b112eafa27a5aa475751";
		$datos=array("sIdentificador"=>$sIdentificador, "sKey"=>$sKey, "operacion"=>"Menu", "IdUsuario"=>$idUsuarioSW);
		$datos=json_encode($datos);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL,"http://ibnored.ibnorca.org/wsibno/verifica/ws-user-personal.php");
		curl_setopt($ch, CURLOPT_POST, TRUE);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $datos);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		$remote_server_output = curl_exec ($ch);
		curl_close ($ch);
		//header('Content-type: application/json');   
		//print_r($remote_server_output);       
		$obj=json_decode($remote_server_output);
		$_SESSION['globalMenuJson']=$obj;
		*/
	}
}

header("location:index.php");

?>