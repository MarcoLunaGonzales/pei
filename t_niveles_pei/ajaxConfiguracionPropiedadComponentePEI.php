<?php 
require_once '../conexion.php';
require_once '../styles.php';
require_once '../functionsGeneralJS.php';
require_once '../functionsNames.php';
require_once '../functionsNivelesPEI.php';


$dbh = new Conexion();

$codigoNivelConf=$_POST['codigoNivelPEI'];

//$codigoPEIPadre=$_GET['codigo_pei_padre'];


$nombreNivel=nombreNivelConfiguracion($codigoNivelConf);

?>
<div class="col-sm-12">
  <div class="card">
    <div class="card-header card-header-text <?=$colorCardDetail?>">
      <div class="card-text">
        <h6 class="card-category">Configurar Accesos -> <?=$nombreNivel;?></h6>
    </div>
    <div class="card-body table-responsive">
      <table class="table table-hover">
        <thead>
			<th class="text-primary">Unidad\Area</th>
        <?php
		$stmtA = $dbh->prepare("SELECT a.codigo, a.abreviatura FROM areas a where a.cod_estado=1 ORDER BY 2");
		$stmtA->execute();
		while ($rowA = $stmtA->fetch(PDO::FETCH_ASSOC)) {
			$codigoA=$rowA['codigo'];
			$abreviaturaA=$rowA['abreviatura'];
		?>
			<th class="text-primary"><?=$abreviaturaA?></th>
		<?php	
		}
        ?>
        </thead>
        <tbody>
            <?php
			$stmtU = $dbh->prepare("SELECT u.codigo, u.abreviatura FROM unidades_organizacionales u where u.cod_estado=1 ORDER BY 2");
			$stmtU->execute();
			while ($rowU = $stmtU->fetch(PDO::FETCH_ASSOC)) {
				$codigoU=$rowU['codigo'];
				$abreviaturaU=$rowU['abreviatura'];
			?>                      
			<tr>
				<th class="text-primary"><?=$abreviaturaU?></th>
			<?php	
				$stmtA->execute();
				while ($rowA = $stmtA->fetch(PDO::FETCH_ASSOC)) {
					$codigoA=$rowA['codigo'];
					$abreviaturaA=$rowA['abreviatura'];

					
					$sqlVeri="SELECT count(*) as filas FROM nivelespei_unidadesareas where cod_nivelpei='$codigoNivelConf' and cod_unidadorganizacional='$codigoU' and cod_area='$codigoA'";
					$stmtVeri = $dbh->prepare($sqlVeri);
					$stmtVeri->execute();
					while ($rowVeri = $stmtVeri->fetch(PDO::FETCH_ASSOC)) {
						$flagVerifica=$rowVeri['filas'];
						$iconCheck="";
						if($flagVerifica==1){
							$iconCheck="bx bxs-check-circle";
						}else{
							$iconCheck="";
						}
					}
			?>
					<td>
						<div class="card-icon">
		        	<i class="<?=$iconCheck;?>"></i>
        		</div>
					</td>
				<?php	
				}
			}
            ?>
          	</tr>
        </tbody>
      </table>
    </div>
  </div>
</div>