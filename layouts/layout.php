<?php 
  require_once 'functions.php';
  //include("librerias.php");// se debe cambiar a la parte posterior
  require_once("cabecera.php");
  require_once("menu.php");
?>    
<div class="page-wrapper">
  <!--page-content-wrapper-->
  <div class="page-content-wrapper">
    <div class="page-content">      
      <?php 
        $tipoLogin=obtenerValorConfiguracion(-10);
        require_once('routing.php');
      ?>  
    </div> 
  </div>
</div> 
<?php
  require_once('pie.php');
?>