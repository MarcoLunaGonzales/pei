<?php

require_once '../layouts/body_empty.php';
require_once '../conexion.php';
require_once '../functionsGeneralJS.php';
require_once 'configModule.php';

$dbh = new Conexion();
$codigoNivelPEI=$_POST["codigo_nivel_pei"];
$codigoPEIPadre=$_POST["codigo_pei_padre"];
$codigoPEI=$_POST["codigo_pei"];


$sqlDelete="DELETE from nivelespei_unidadesareas where cod_nivelpei='$codigoPEI'";	    	
$stmtDel = $dbh->prepare($sqlDelete);	
$flagSuccess1=$stmtDel->execute();


foreach($_POST as $nombre_campo => $valor){ 
   	$asignacion = "\$" . $nombre_campo . "='" . $valor . "';"; 
   
   	//echo "CAMPOS: ".$asignacion."<br>";

	$cadenaBuscar="chk";
	$posicion = strpos($nombre_campo, $cadenaBuscar);

	if ($posicion === false) {
	}else{
		list($nameInsert, $unidadInsert, $areaInsert)=explode("|",$nombre_campo);
		//echo $nameInsert." ".$unidadInsert." ".$areaInsert."<br>";

	    $sqlInsert="";
    	$sqlInsert="INSERT INTO nivelespei_unidadesareas (cod_nivelpei, cod_unidadorganizacional, cod_area) values ('$codigoPEI', '$unidadInsert', '$areaInsert')";	    	
	    $stmtInsert = $dbh->prepare($sqlInsert);	
		$flagSuccess2=$stmtInsert->execute();

		if($flagSuccess2==false){
			$flagSuccessDetail=false;
		}
	}
}

showAlertSuccessError($flagSuccess1,$urlList4.'&codigo_nivel_conf='.$codigoNivelPEI.'&codigo_pei_padre='.$codigoPEIPadre);

?>
