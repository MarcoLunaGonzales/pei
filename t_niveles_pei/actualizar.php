<?php

require_once 'conexion.php';
require_once 'styles.php';
require_once 'configModule.php';
require_once 'functionsGeneralJS.php';
require_once 'functionsNames.php';


$dbh = new Conexion();

$codigoNivelConf=$_GET['codigo_nivel_conf'];
$codigoPEIPadre=$_GET['codigo_pei_padre'];


$nombreNivel=nombreNivelConfiguracion($codigoNivelConf);

?>
<form id="form1" class="form-horizontal" action="<?=$urlSave;?>" method="post">

<input type="hidden" name="codigo_nivel_conf" id="codigo_nivel_conf" value="<?= $codigoNivelConf; ?>"   > 
<input type="hidden" name="codigo_nivel_padre" id="codigo_nivel_padre" value="<?= $codigoPEIPadre; ?>"   > 

<div class="content">
	<div class="container-fluid">

		<div class="col-md-12">
		  
			<div class="card">
			  <div class="card-header <?=$colorCard;?> card-header-text">
				<div class="card-text">
				  <h4 class="card-title">Registrar <?=$nombreNivel;?></h4>
				</div>
			  </div>
			  <div class="card-body ">
					<div class="row">
					  <label class="col-sm-2 col-form-label">Nombre</label>
					  <div class="col-sm-7">
						<div class="form-group">
						  <input class="form-control" type="text" name="nombre" id="nombre" required="true" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
						</div>
					  </div>
					</div>
					<div class="row">
					  <label class="col-sm-2 col-form-label">Abreviatura</label>
					  <div class="col-sm-7">
						<div class="form-group">
						  <input class="form-control" type="text" name="abreviatura" id="abreviatura" required="true" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
						</div>
					  </div>
					</div>

				 <!--AQUI SE VIENEN LOS CAMPOS DINAMICOS-->
				 	<?php 
				 	$sqlCamposDinamicos="SELECT c.codigo, c.nombre, c.abreviatura, tc.string_formulario from nivelesconf_camposdisponibles ncc, campos_disponibles c, tipos_campo tc where ncc.cod_campodisponible=c.codigo and c.cod_tipocampo=tc.codigo and ncc.cod_nivelconfiguracion='$codigoNivelConf' ";
				 	$stmtCamposDinamicos = $dbh->prepare($sqlCamposDinamicos);
					$stmtCamposDinamicos->execute();
					while ($rowCamposDinamicos = $stmtCamposDinamicos->fetch(PDO::FETCH_ASSOC)) {
						$codigoCampo=$rowCamposDinamicos['codigo'];
						$nombreCampo=$rowCamposDinamicos['nombre'];
						$abreviaturaCampo=$rowCamposDinamicos['abreviatura'];
						$stringForm=$rowCamposDinamicos['string_formulario'];
						$stringForm=configurarCampoFormularioPersonalizado($stringForm,$codigoCampo);
				 	?>
				 	<div class="row">
					  <label class="col-sm-2 col-form-label"><?=$nombreCampo;?></label>
					  <div class="col-sm-7">
						<?= $stringForm; ?>
					  </div>
					</div>
					<?php
					}
					?>
				 <!--FIN CAMPOS DINAMICOS-->

				 	<div class="row">
					  	<label class="col-sm-2 col-form-label">Habilitar Componente para Enlazar Tareas</label>
					  	<div class="col-sm-7">
					  		<div class="custom-control custom-switch">
							<input type="checkbox" class="custom-control-input" id="habilitar_actividades" name="habilitar_actividades">
							<label class="custom-control-label" for="habilitar_actividades">Habilitar</label>
							</div>
						</div>
					</div>

			  </div>
			</div>
		</div>
	</div>
	<div class="card-footer ml-auto mr-auto">
				<button type="submit" class="<?=$buttonVerde;?>"><i class='bx bxs-save mr-1'></i>Guardar</button>
				<a href="<?=$urlList3;?>&codigo_nivel_conf=<?=$codigoNivelConf;?>&codigo_pei_padre=<?=$codigoPEIPadre;?>" class="<?=$buttonCancel;?>"><i class='bx bx-undo mr-1'></i>Cancelar</a>
  	</div>
</div>

</form>
