  <?php
  require_once 'conexion.php';
  //Enviar correo con funcion Enviar

  date_default_timezone_set('America/La_Paz');
  function nombreNivelConfiguracion($codigo){
     $dbh = new Conexion();
     $stmt = $dbh->prepare("SELECT nombre FROM niveles_configuracion where codigo=:codigo");
     $stmt->bindParam(':codigo',$codigo);
     $stmt->execute();
     $nombreX="";
     while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $nombreX=$row['nombre'];
     }
     return($nombreX);
  }
  
?>
