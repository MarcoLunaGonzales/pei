<?php

require_once 'conexion.php';
require_once 'styles.php';
require_once 'configModule.php';
require_once 'functionsGeneralJS.php';
require_once 'functionsNames.php';


$dbh = new Conexion();

$codigoNivelConf = $_GET['codigo_nivel_conf'];
$codigoPEIPadre  = $_GET['codigo_pei_padre'];

//RECIBIMOS LAS VARIABLES
$stmt = $dbh->prepare("SELECT np.codigo, np.nombre, np.abreviatura, np.bandera_actividades 
FROM niveles_pei np WHERE codigo=:codigo");
// Ejecutamos
$stmt->bindParam(':codigo', $codigoPEIPadre);
$stmt->execute();

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
	$conf_codigo 			  = $row['codigo'];
	$conf_nombre 			  = $row['nombre'];
	$conf_abreviatura		  = $row['abreviatura'];
	$conf_bandera_actividades = $row['bandera_actividades'];
}



$nombreNivel=nombreNivelConfiguracion($codigoNivelConf);

?>
<form id="form1" class="form-horizontal" action="<?=$urlSaveUpdate;?>" method="post">

<input type="hidden" name="codigo_nivel_conf" id="codigo_nivel_conf" value="<?= $codigoNivelConf; ?>"   > 
<input type="hidden" name="codigo_nivel_padre" id="codigo_nivel_padre" value="<?= $codigoPEIPadre; ?>"   > 

<div class="content">
	<div class="container-fluid">

		<div class="col-md-12">
		  
			<div class="card">
			  <div class="card-header <?=$colorCard;?> card-header-text">
				<div class="card-text">
				  <h4 class="card-title">Actualizar <?=$nombreNivel;?></h4>
				</div>
			  </div>
			  <div class="card-body ">
			  <input type="text" name="codigo_niveles_pei" value="<?=$conf_codigo;?>" hidden/>
					<div class="row">
					  <label class="col-sm-2 col-form-label">Nombre</label>
					  <div class="col-sm-7">
						<div class="form-group">
						  <input class="form-control" type="text" name="nombre" id="nombre" required="true" onkeyup="javascript:this.value=this.value.toUpperCase();" value="<?=$conf_nombre;?>"/>
						</div>
					  </div>
					</div>
					<div class="row">
					  <label class="col-sm-2 col-form-label">Abreviatura</label>
					  <div class="col-sm-7">
						<div class="form-group">
						  <input class="form-control" type="text" name="abreviatura" id="abreviatura" required="true" onkeyup="javascript:this.value=this.value.toUpperCase();" value="<?=$conf_abreviatura;?>"/>
						</div>
					  </div>
					</div>

				 <!--AQUI SE VIENEN LOS CAMPOS DINAMICOS-->
				 	<?php 
				 	$sqlCamposDinamicos="SELECT npa.valor as valor, c.codigo, c.nombre, c.abreviatura, tc.string_formulario 
					from nivelesconf_camposdisponibles ncc, niveles_pei_adicionales npa, campos_disponibles c, tipos_campo tc 
					where npa.cod_campodisponible=c.codigo 
					and ncc.cod_campodisponible=c.codigo 
					and c.cod_tipocampo=tc.codigo 
					and npa.cod_nivelpei='$codigoPEIPadre' ";
				 	$stmtCamposDinamicos = $dbh->prepare($sqlCamposDinamicos);
					$stmtCamposDinamicos->execute();
					while ($rowCamposDinamicos = $stmtCamposDinamicos->fetch(PDO::FETCH_ASSOC)) {
						$valorCampo = $rowCamposDinamicos['valor'];
						$codigoCampo=$rowCamposDinamicos['codigo'];
						$nombreCampo=$rowCamposDinamicos['nombre'];
						$abreviaturaCampo=$rowCamposDinamicos['abreviatura'];
						$stringForm=$rowCamposDinamicos['string_formulario'];
						$stringForm=configurarCampoFormulario($stringForm,$codigoCampo,$valorCampo);
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
							<input type="checkbox" class="custom-control-input" id="habilitar_actividades" name="habilitar_actividades" <?=($conf_bandera_actividades==1?'checked':'');?>>
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
