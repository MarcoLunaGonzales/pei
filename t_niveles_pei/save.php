<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();

$nombre=$_POST["nombre"];
$abreviatura=$_POST["abreviatura"];
$codNivelConf=$_POST["codigo_nivel_conf"];
$codigoPEIPadre=$_POST["codigo_nivel_padre"];
$habilitarActividades=$_POST["habilitar_actividades"];

if($habilitarActividades=="on"){
	$habilitarActividades=1;
}else{
	$habilitarActividades=0;
}

$codEstado="1";

$sqlInsert="INSERT INTO $table2 (nombre, abreviatura, cod_estado, cod_padre, cod_nivelconfiguracion, bandera_actividades) 
	VALUES ('$nombre','$abreviatura','$codEstado','$codigoPEIPadre','$codNivelConf','$habilitarActividades')";
$stmt = $dbh->prepare($sqlInsert);
$flagSuccess=$stmt->execute();
$codigoInsertadoCabecera = $dbh->lastInsertId();

foreach($_POST as $nombre_campo => $valor){ 
   	$asignacion = "\$" . $nombre_campo . "='" . $valor . "';"; 
   
   	//echo "CAMPOS: ".$asignacion."<br>";

	$cadenaBuscar='campopersonalizado';
	$posicion = strpos($nombre_campo, $cadenaBuscar);

	if ($posicion === false) {
	}else{
		list($campoInsert, $campoIndex)=explode("|",$nombre_campo);

	    $sqlInsertAdicional="";
    	$sqlInsertAdicional="INSERT INTO niveles_pei_adicionales (cod_nivelpei, cod_campodisponible, valor) values ('$codigoInsertadoCabecera', '$campoIndex', '$valor')";	    	
	    $stmtInsertAdicional = $dbh->prepare($sqlInsertAdicional);	
		$flagSuccess2=$stmtInsertAdicional->execute();

		if($flagSuccess2==false){
			$flagSuccessDetail=false;
		}
	}
}

showAlertSuccessError($flagSuccess,$urlList);

?>
