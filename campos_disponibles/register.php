<?php

require_once 'conexion.php';
require_once 'styles.php';
require_once 'configModule.php';

$dbh = new Conexion();
?>

<div class="content">
	<div class="container-fluid">

		<div class="col-md-12">
		  <form id="form1" class="form-horizontal" action="<?=$urlSave;?>" method="post">
			<div class="card">
			  <div class="card-header <?=$colorCard;?> card-header-text">
				<div class="card-text">
				  <h4 class="card-title">Registrar <?=$moduleNameSingular;?></h4>
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
					
					<div class="row">
					  <label class="col-sm-2 col-form-label"><?= $nameForeignField; ?></label>
					  <div class="col-sm-7">
						<div class="form-group">
							<select name="campo_foraneo" id="campo_foraneo" class="single-select" data-style="btn btn-warning" required>
	                            <option value="" disabled selected="selected">-</option>
	                            <?php             
	                              	$sqlForaneo="SELECT codigo,nombre FROM $foreignTable where cod_estado=1";
	                               	$stmtForaneo=$dbh->prepare($sqlForaneo);
	                                $stmtForaneo->execute();
	                                $stmtForaneo->bindColumn('codigo', $codigoF);
	                                $stmtForaneo->bindColumn('nombre', $nombreF);

	                                while ($rowForaneo = $stmtForaneo->fetch(PDO::FETCH_BOUND)) {         
	                            ?>
	                            <option value="<?= $codigoF; ?>" ><?= $nombreF; ?></option>
	                            <?php 
	                                }   
                                ?>
	                        </select>					  
						</div>
					  </div>
					</div>

			  </div>
			  <div class="card-footer ml-auto mr-auto">
				<button type="submit" class="<?=$buttonVerde;?>"><i class='bx bxs-save mr-1'></i>Guardar</button>
				<a href="<?=$urlList2;?>" class="<?=$buttonCancel;?>"><i class='bx bx-undo mr-1'></i>Cancelar</a>
			  </div>
			</div>
		  </form>
		</div>
	
	</div>
</div>