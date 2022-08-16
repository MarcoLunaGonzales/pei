<?php
require_once 'conexion.php';
date_default_timezone_set('America/La_Paz');

function listarCabecerasNiveles($nivel){
  $dbh = new Conexion();
  $sqlX="SELECT cd.abreviatura from nivelesconf_camposdisponibles ncc, campos_disponibles cd
   where ncc.cod_campodisponible=cd.codigo and ncc.cod_nivelconfiguracion=$nivel";
  $stmtX = $dbh->prepare($sqlX);
  $stmtX->execute();
  while ($rowX = $stmtX->fetch(PDO::FETCH_ASSOC)) {
      echo "<th>".$rowX['abreviatura']."</th>";
  }
   return;
}

function listarDatosNiveles($nivel, $nivelpei){
  $dbh = new Conexion();
  $sqlX="SELECT cd.codigo, cd.abreviatura from nivelesconf_camposdisponibles ncc, campos_disponibles cd
   where ncc.cod_campodisponible=cd.codigo and ncc.cod_nivelconfiguracion=$nivel";
  //echo $sqlX."<br>";
  $stmtX = $dbh->prepare($sqlX);
  $stmtX->execute();
  while ($rowX = $stmtX->fetch(PDO::FETCH_ASSOC)) {
      $codigoCampoX=$rowX['codigo'];

      $sqlY="SELECT npa.valor from niveles_pei_adicionales npa where npa.cod_campodisponible='$codigoCampoX' and npa.cod_nivelpei='$nivelpei'";
      //echo $sqlY."<br>";
      $stmtY = $dbh->prepare($sqlY);
      $stmtY->execute();
      $valorCampo="";
      while ($rowY = $stmtY->fetch(PDO::FETCH_ASSOC)) {
         $valorCampo=$rowY['valor'];
      }
      echo "<td>".$valorCampo."</td>";
   }   
   return;
}

function obtenerNivelHijo($nivel){
   $dbh = new Conexion();
  $sqlX="select codigo from niveles_configuracion where cod_padre='$nivel'";
  $stmtX = $dbh->prepare($sqlX);
  $stmtX->execute();
  $respuesta=0;
  while ($rowX = $stmtX->fetch(PDO::FETCH_ASSOC)) {
      $respuesta=$rowX['codigo'];
  }
  return ($respuesta);
}
  
?>
