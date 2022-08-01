<?php

require_once 'conexion.php';
require_once 'configModule.php';
require_once 'styles.php';
require_once 'functions.php';
require_once 'functionsNames.php';

$dbh = new Conexion();

$sqlX="SET NAMES 'utf8'";
$stmtX = $dbh->prepare($sqlX);
$stmtX->execute();

$table="nivelesconf_camposdisponibles";
$moduleName="Configurar Campos por Niveles";

$codNivelConf=$codigo;


// Preparamos
$nombreNivel = nombreNivelConfiguracion($codNivelConf);


// Preparamos
$sql="SELECT c.codigo, c.nombre, (select t.nombre from tipos_campo t where t.codigo=c.cod_tipocampo)as tipo_campo
from campos_disponibles c
where cod_estado=1 order by 2";

//echo $sql;

$stmt = $dbh->prepare($sql);
$stmt->bindParam(':codigo',$codNivel);
// Ejecutamos
$stmt->execute(); 
// bindColumn
$stmt->bindColumn('codigo', $codigoCampo);
$stmt->bindColumn('nombre', $nombreCampo);

?>

<div class="content">
	<div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header card-header-primary card-header-icon">
                  <h4 class="card-title"><?=$moduleName?></h4>
                  <h6 class="card-title">Nivel: <?=$nombreNivel;?></h6>
                  <h3 class="card-title">Por favor active la casilla para registrar el Campo</h3>
                </div>
                <div class="card-body">
                  
                  <div class="table-responsive">
                    <form id="lñp" method="post" action="<?=$urlSaveAreas_organizacion;?>">
                      <input type="hidden" name="codUnidad" value="<?=$codUnidad?>">
                      <table class="table" id="data_cuentas" >
                        <thead>
                          <tr>
                            <th class="text-center">-</th>
                            <th>Codigo</th>
                            <th>Nombre</th>
                          </tr>
                        </thead>
                        <tbody>
                          <?php
                          $index=1;$nc=0;
                        	while ($row = $stmt->fetch(PDO::FETCH_BOUND)) {
                          ?>
                          <tr>
                            <td align="center">
                              <div class="form-check">
                                <label class="form-check-label">
                                  <input  class="form-check-input" type="checkbox" id="areas<?=$index?>" name="areas<?=$index;?>" >
                                  <span class="form-check-sign">
                                    <span class="check"></span>
                                  </span>
                                </label>
                              </div>
                            </td>
                            <td><?=$codigoCampo;?></td>
                            <td><?=$nombreCampo;?></td>
                          </tr>
                          <?php
                							$index++;
                						}
                          ?>
                        </tbody>
                      </table>
                      <input type="hidden" name="numero_filas" value="<?=$index;?>">
                  </div>
                </div>
              </div>
        				<div class="card-footer fixed-bottom">
                    <button class="<?=$buttonVerde;?>" type="submit"><i class='bx bxs-save mr-1'></i>Guardar</button>
                    <a href="<?=$urlList2;?>" class="<?=$buttonCancel;?>"><i class='bx bx-undo mr-1'></i>Cancelar</a>
                </div>
			     </form>
            </div>
          </div>  
        </div>
    </div>
<script>numFilasA=<?=$nc?>;</script> 



