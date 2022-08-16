<?php
require_once 'conexion.php';
date_default_timezone_set('America/La_Paz');

 function abrevUnidad($codigo){
 $dbh = new Conexion();
 $stmt = $dbh->prepare("SELECT abreviatura FROM unidades_organizacionales where codigo in ($codigo)");
 $stmt->execute();
 $nombreX="";
 while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $nombreX.=$row['abreviatura']."-";
 }
 $nombreX=substr($nombreX, 0, -1);
 return($nombreX);
}
function abrevArea($codigo){
 $dbh = new Conexion();
 $sql="SELECT abreviatura FROM areas where codigo in ($codigo)";
 $stmt = $dbh->prepare($sql);
 //echo $sql;
 $stmt->execute();
 $cadenaAreas="";
 while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $cadenaAreas=$cadenaAreas."-".$row['abreviatura'];
 }
 $cadenaAreas=substr($cadenaAreas, 1);
 return($cadenaAreas);
}
function callService($parametros, $url){
    $parametros=json_encode($parametros);
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL,$url);
    curl_setopt($ch, CURLOPT_POST, TRUE);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $parametros);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $remote_server_output = curl_exec ($ch);
    curl_close ($ch);
    return $remote_server_output;   
 }


function obtieneValorConfig($codigo){
  $dbh = new Conexion();
  $stmt = $dbh->prepare("SELECT valor_configuracion FROM configuraciones where id_configuracion='$codigo'");
  $stmt->execute();
  $valor="";
  while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $valor=$row['valor_configuracion'];
  }  
  return $valor;
}


function redondearDecimal($valor) {
   $float_redondeado=round($valor * 100) / 100;
   return $float_redondeado;
}

function obtenerValorConfiguracion($id){
  $dbh = new Conexion();
  $stmt = $dbh->prepare("SELECT valor_configuracion from configuraciones c where id_configuracion=$id");
  $stmt->execute();
  $codigoComprobante=0;
  while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
     $codigoComprobante=$row['valor_configuracion'];
  }
  return($codigoComprobante);
}

function configurarCampoFormularioPersonalizado($stringForm,$codigoCampo){
   $stringNuevoForm=str_replace("XXXXX", "campopersonalizado|$codigoCampo", $stringForm);;
   return($stringNuevoForm);
}

?>
