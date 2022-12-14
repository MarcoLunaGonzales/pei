<?php 
require_once 'conexion.php';
require_once 'styles.php';
require_once 'functionsGeneralJS.php';
require_once 'functionsNames.php';
require_once 'functionsNivelesPEI.php';
require_once 't_niveles_pei/configModule.php';


$dbh = new Conexion();

$codigoNivelConf=$_GET['codigo_nivel_conf'];
$codigoPEI=$_GET['codigo_pei'];
$codigoPEIPadre=$_GET['codigo_pei_padre'];


$nombreNivel=nombreNivelPEI($codigoPEI);

?>
<form id="form1" class="form-horizontal" action="<?=$urlSaveConfPropiedad;?>" method="POST">

<input type="hidden" name="codigo_nivel_pei" name="codigo_nivel_pei" value="<?=$codigoNivelConf;?>">
<input type="hidden" name="codigo_pei_padre" name="codigo_pei_padre" value="<?=$codigoPEIPadre;?>">
<input type="hidden" name="codigo_pei" name="codigo_pei" value="<?=$codigoPEI;?>">

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

					
					$sqlVeri="SELECT count(*) as filas FROM nivelespei_unidadesareas where cod_nivelpei='$codigoPEI' and cod_unidadorganizacional='$codigoU' and cod_area='$codigoA'";
					//echo $sqlVeri;
					$stmtVeri = $dbh->prepare($sqlVeri);
					$stmtVeri->execute();
					while ($rowVeri = $stmtVeri->fetch(PDO::FETCH_ASSOC)) {
						$flagVerifica=$rowVeri['filas'];
						$iconCheck="";
						if($flagVerifica==1){
							$iconCheck="checked";
						}else{
							$iconCheck="";
						}
					}
			?>
					<td>
		        <div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="chk|<?=$codigoU;?>|<?=$codigoA;?>" name="chk|<?=$codigoU;?>|<?=$codigoA;?>" <?=$iconCheck;?> >
								<label class="custom-control-label" for="chk|<?=$codigoU;?>|<?=$codigoA;?>"></label>
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

	<div class="card-footer ml-auto mr-auto">
				<button type="submit" class="<?=$buttonVerde;?>"><i class='bx bxs-save mr-1'></i>Guardar</button>
	</div>

</div>


</form>