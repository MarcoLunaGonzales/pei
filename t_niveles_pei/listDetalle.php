<?php

require_once 'conexion.php';
require_once 'configModule.php';
require_once 'styles.php';
require_once 'functionsGeneralJS.php';
require_once 'functionsNames.php';
require_once 'functionsNivelesPEI.php';

$dbh = new Conexion();

$globalAdmin=$_SESSION["globalAdmin"];

$codigoNivelConf=$_GET['codigo_nivel_conf'];
$codigoPEIPadre=$_GET['codigo_pei_padre'];

$codigoNivelHijo=obtenerNivelHijo($codigoNivelConf);

$nombreNivel=nombreNivelConfiguracion($codigoNivelConf);
$nombreNivelPEI=nombreNivelPEI($codigoPEIPadre);

// Preparamos
$sqlList="SELECT codigo, nombre, abreviatura, cod_padre, bandera_actividades FROM niveles_pei where cod_estado=1 and cod_nivelconfiguracion='$codigoNivelConf' and cod_padre='$codigoPEIPadre' order by 1";
//echo $sqlList;
$stmt = $dbh->prepare($sqlList);

//echo $sqlList;

// Ejecutamos
$stmt->execute();
// bindColumn
$stmt->bindColumn('codigo', $codigo);
$stmt->bindColumn('nombre', $nombre);
$stmt->bindColumn('abreviatura', $abreviatura);
$stmt->bindColumn('bandera_actividades', $banderaActividades);

?>

<div class="content">
	<div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header <?=$colorCard;?> card-header-icon">
                  <h4 class="card-title"><?=$nombreNivel?> -> <?=$nombreNivelPEI;?></h4>
                </div>

                <div class="card-body">
                  <div class="table-responsive">
                  <table id="example" class="table table-striped table-bordered" style="width:100%">
                  <thead>
                        <tr>
                          <th class="text-center">#</th>
                          <th>Nombre</th>
                          <th>Abreviatura</th>
                          <!--th>Dependencia</th-->
                          <?php
                          listarCabecerasNiveles($codigoNivelConf);
                          ?>
                          <th class="text-right">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
<?php
						$index=1;
                      	while ($row = $stmt->fetch(PDO::FETCH_BOUND)) {
                          //$nombrePadre=nombreNivelConfiguracion($codPadre);
                          $nombrePadre="";
?>  
                        <tr>
                          <td align="center"><?=$index;?></td>
                          <td><?=$nombre;?></td>
                          <td><?=$abreviatura;?></td>
                          <!--td><?=$nombrePadre;?></td-->
                          <?php
                          listarDatosNiveles($codigoNivelConf, $codigo);
                          ?>
                          <td class="td-actions text-right">
                            <?php
                            if($globalAdmin==1){
                            ?>
                            <a href='index.php?opcion=ListNivelDetallePEI&codigo_nivel_conf=<?=$codigoNivelHijo;?>&codigo_pei_padre=<?=$codigo;?>' rel="tooltip" class="<?=$buttonDetailMin;?>">
                              <i class="bx bx-list-ol"></i>
                            </a>
                            <a href='index.php?opcion=actualizarNivelPEI&codigo_nivel_conf=<?=$codigoNivelConf;?>&codigo_pei_padre=<?=$codigoPEIPadre;?>' rel="tooltip" class="btn btn-primary">
                              <i class="bx bx-pencil"></i>
                            </a>
                            <?php
                              if($banderaActividades==1){
                            ?>
                              <a href='javascript:showModalConfiguracionPropiedadComponente(<?=$codigo;?>)' rel="tooltip" class="<?=$buttonPrincipal;?>">
                                <i class="bx bx-show"></i>
                              </a>
                              <a href='index.php?opcion=configuracionPropiedadesNiveles&codigo_nivel_conf=<?=$codigoNivelConf;?>&codigo_pei=<?=$codigo;?>&codigo_pei_padre=<?=$codigoPEIPadre;?>' rel="tooltip" class="<?=$buttonEdit;?>">
                                <i class="bx bx-wrench"></i>
                              </a>
                            <?php
                              }
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
      				<div class="card-footer ml-auto mr-auto">
                    <button class="<?=$buttonVerde;?>" onClick="location.href='index.php?opcion=registerNivelPEI&codigo_nivel_conf=<?=$codigoNivelConf;?>&codigo_pei_padre=<?=$codigoPEIPadre;?>'"><i class='bx bxs-file-plus mr-1'></i>Registrar</button>
              </div>
              <?php
              }
              ?>
		  
            </div>
          </div>  
        </div>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="modalShowConfiguracionPropiedad" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Configuracion de Propiedad de Componente</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                  <div id="divConfiguracionPropiedadComponente">
                  </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
    <!--END MODAL-->
