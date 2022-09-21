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
$sql="SELECT c.codigo, c.nombre, (select t.nombre from tipos_campo t where t.codigo=c.cod_tipocampo)as tipo_campo,
(select count(*) from nivelesconf_camposdisponibles ncc where ncc.cod_campodisponible=c.codigo and ncc.cod_nivelconfiguracion in ($codNivelConf)) as bandera,
(select ncc.orden from nivelesconf_camposdisponibles ncc where ncc.cod_campodisponible=c.codigo and ncc.cod_nivelconfiguracion in ($codNivelConf)) as ordenguardado
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
$stmt->bindColumn('bandera', $bandera);
$stmt->bindColumn('ordenguardado', $ordenGuardado);


?>

<div class="content">
	<div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
              <div class="card">
                <div class="card-header card-header-primary card-header-icon">
                  <h4 class="card-title"><?=$moduleName?></h4>
                  <h6 class="card-title">Nivel: <?=$nombreNivel;?></h6>
                  <!--h3 class="card-title">Por favor active la casilla para registrar el Campo</h3-->
                </div>
                <div class="card-body">
                  
                  <div class="table-responsive">
                    <form id="lp" method="post" action="<?=$urlSaveDetail;?>">
                      <input type="hidden" name="codNivel" id="codNivel" value="<?=$codNivelConf?>">
                      <table class="table" id="data_cuentas" >
                        <thead>
                          <tr>
                            <th class="text-center">-</th>
                            <th>Codigo</th>
                            <th>Nombre</th>
                            <th>Orden</th>
                          </tr>
                        </thead>
                        <tbody>
                          <?php
                          $index=1;$nc=0;
                        	while ($row = $stmt->fetch(PDO::FETCH_BOUND)) {
                          ?>
                          <tr>
                            <td align="center">
                              <div class="custom-control custom-checkbox mb-3">
                                  <input  class="custom-control-input" onclick="check(this.value, this.checked)" type="checkbox" id="campo<?=$index?>" name="campo<?=$index;?>" value="<?=$codigoCampo;?>"  <?=($bandera>0)?"checked":"";?>  >
                                  <label class="custom-control-label" for="campo<?=$index?>"><?= $nombreCampo;?></label>
                              </div>
                            </td>
                            <td><?=$codigoCampo;?></td>
                            <td><?=$nombreCampo;?></td>
                            <td>
                            <div class="col-sm-7">
                              <div class="form-group">
                                <input class="form-control campo<?=$codigoCampo;?>" type="number"   name="orden<?=$index;?>" id="orden<?=$index;?>" value="<?=$ordenGuardado;?>" />
                              </div>
                            </div>
                            </td>

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
                    <!--button class="<?=$buttonVerde;?>" type="submit" onClick="return validarFormCamposNiveles(this.form)"><i class='bx bxs-save mr-1'></i>Guardar</button-->
                    <button class="<?=$buttonVerde;?>" type="button" onclick="enviarForm()"><i class='bx bxs-save mr-1'></i>Guardar</button>

                    <a href="<?=$urlList2;?>" class="<?=$buttonCancel;?>"><i class='bx bx-undo mr-1'></i>Cancelar</a>
                </div>
			     </form>
            </div>
          </div>  
        </div>
    </div>
<script>numFilasA=<?=$nc?>;</script> 
<script>
  let array_select = [];
  // Verificación de Checks realizados
  function check(data, checked) {
    let position = array_select.indexOf(data);
    if(checked){
      if(position > -1){
        array_select.splice(array_select.indexOf(data), 1);
      }else{
        array_select.push(data);
      }
    }
    
  }
  // En caso de tener todos los campos completados se envia formulario
  function enviarForm(){
    let validate = true;
    array_select.forEach(element => {
      let values = document.getElementsByClassName("campo" + element)[0].value;
      if(values == ''){
        validate = false;
      }
    });
    if(validate){
      document.getElementById("lp").submit();
    }else{
      alert('Llenar campos')
    }
  }
</script>


