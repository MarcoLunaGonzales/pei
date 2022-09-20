<?php

require_once 'conexion.php';
require_once 'configModule.php';
require_once 'styles.php';
require_once 'functionsGeneralJS.php';
require_once 'functionsNames.php';

$globalAdmin=$_SESSION["globalAdmin"];


$dbh = new Conexion();

// Preparamos
$sqlList="SELECT codigo, nombre, abreviatura, (select f.nombre from $foreignTable f where f.codigo=$keyForeignTable) as campo_foraneo, nivel, cod_padre FROM $table where cod_estado=1 order by nivel";
$stmt = $dbh->prepare($sqlList);

//echo $sqlList;

// Ejecutamos
$stmt->execute();
// bindColumn
$stmt->bindColumn('codigo', $codigo);
$stmt->bindColumn('nombre', $nombre);
$stmt->bindColumn('abreviatura', $abreviatura);
$stmt->bindColumn('campo_foraneo', $campoForaneo);
$stmt->bindColumn('nivel', $nivel);
$stmt->bindColumn('cod_padre', $codPadre);


?>

<div class="content">
	<div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header <?=$colorCard;?> card-header-icon">
                  <h4 class="card-title"><?=$moduleNamePlural?></h4>
                </div>

                <div class="card-body">
                  <div class="table-responsive">
                  <table id="example" class="table table-striped table-bordered" style="width:100%">
                  <thead>
                        <tr>
                          <th class="text-center">#</th>
                          <th>Nombre</th>
                          <th>Abreviatura</th>
                          <th>Nivel</th>
                          <th>Dependencia</th>
                          <th><?= $nameForeignField; ?></th>
                          <th class="text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
<?php
						$index=1;
                      	while ($row = $stmt->fetch(PDO::FETCH_BOUND)) {
                          $nombrePadre=nombreNivelConfiguracion($codPadre);
?>
                        <tr>
                          <td align="center"><?=$index;?></td>
                          <td><?=$nombre;?></td>
                          <td><?=$abreviatura;?></td>
                          <td><?=$nivel;?></td>
                          <td><?=$nombrePadre;?></td>
                          <td><?=$campoForaneo;?></td>
                          <td class="td-actions text-right">
                            <?php
                            if($globalAdmin==1){
                            ?>
                            <a href='index.php?opcion=ListNivelDetallePEI&codigo_nivel_conf=<?=$codigo;?>&codigo_pei_padre=0' rel="tooltip" class="<?=$buttonDetailMin;?>">
                              <i class="bx bx-list-ol"></i>
                            </a>
                            <!--a href='index.php?opcion=registerNivelPEI&codigo=<?=$codigo;?>' rel="tooltip" class="<?=$buttonEdit;?>">
                              <i class="bx bx-list-plus"></i>
                            </a-->
                            <?php
                            }
                            ?>
                          </td>
                        </tr>
<?php
							$index++;
						}
?>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <?php
              if($globalAdmin==1){
              ?>
      				<!--div class="card-footer ml-auto mr-auto">
                    <button class="<?=$buttonVerde;?>" onClick="location.href='<?=$urlRegister;?>'"><i class='bx bxs-file-plus mr-1'></i>Registrar</button>
              </div-->
              <?php
              }
              ?>
		  
            </div>
          </div>  
        </div>
    </div>
