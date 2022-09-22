<!-- Modal Nuevo Archivo -->
<div class="modal fade" id="modalNewFile" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir Archivo</h5>
                <button type="button" class="btn-close bg-white close-file" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="form-file">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-12 col-form-label">Detalle</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <textarea rows="3" class="form-control" name="detail_file" id="detail_file" placeholder="Ingrese detalle de Archivo.." autocomplete="off"></textarea>
                                    </div>
                                </div>
                                <label class="col-sm-12 col-form-label">Archivo</label>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                    <input class="form-control" type="file" name="file" id="file"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-file" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-file">Guardar</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Colaborador -->
<div class="modal fade" id="modalCollaborator" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir colaborador</h5>
                <button type="button" class="btn-close bg-white close-collaborator" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-form-label">Colaborador:</label>
                            <select name="cod_personal" id="cod_personal" class="form-control single-select" data-style="btn btn-warning" required>
                                <?php             
                                    $sqlColl   = "SELECT codigo, CONCAT(primer_nombre, ' ', paterno, ' ',materno) as nombre_personal FROM personal 
                                    WHERE cod_estadopersonal = 1
                                    ORDER BY nombre_personal ASC";
                                    $stmtColl  = $dbh->prepare($sqlColl);
                                    $stmtColl->execute();
                                    $rows_collaborators = $stmtColl->fetchAll();
                                    foreach ($rows_collaborators as $collabolator){       
                                ?>
                                <option value="<?= $collabolator['codigo']; ?>"  ><?= $collabolator['nombre_personal']; ?></option>
                                <?php 
                                    }   
                                ?>
                            </select>                     
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-collaborator" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-collaborator">Guardar</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Presupuesto -->
<div class="modal fade" id="modalBudget" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir Presupuesto</h5>
                <button type="button" class="btn-close bg-white close-budget" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-form-label">Cuenta:</label>
                            <select name="cod_account" id="cod_account" class="form-control" data-style="btn btn-warning" required>
                                <?php             
                                    $sqlAccount   = "SELECT p.codigo, p.numero, p.nombre 
                                        FROM plan_cuentas p 
                                        WHERE p.numero like '5%' 
                                        AND p.nivel = 5 
                                        AND p.cod_estadoreferencial = 1";
                                    $stmtAccount  = $dbh->prepare($sqlAccount);
                                    $stmtAccount->execute();
                                    $rows_accounts = $stmtAccount->fetchAll();
                                    foreach ($rows_accounts as $account){       
                                ?>
                                <option value="<?= $account['codigo']; ?>"  ><?= $account['numero']; ?> - <?= $account['nombre']; ?></option>
                                <?php 
                                    }   
                                ?>
                            </select>
                            <label class="col-form-label">Financiamiento:</label>
                            <select name="financier" id="financier" class="form-control" data-style="btn btn-warning" required>
                                <?php             
                                    $sqlFinancing   = "SELECT pf.codigo, pf.abreviatura, pf.nombre 
                                        FROM proyectos_financiacionexterna pf";
                                    $stmtFinancing  = $dbh->prepare($sqlFinancing);
                                    $stmtFinancing->execute();
                                    $rows_financing = $stmtFinancing->fetchAll();
                                    foreach ($rows_financing as $financing){       
                                ?>
                                <option value="<?= $financing['codigo']; ?>"  ><?= $financing['nombre']; ?></option>
                                <?php 
                                    }   
                                ?>
                            </select>
                            <label class="col-form-label">Monto:</label>
                            <input type="number" step="0.1" autocomplete="off" id="amount" class="form-control" placeholder="Ingresar presupuesto"> 
                            <label class="col-form-label">Fecha Ejecucion:</label>
                            <input type="date" id="dateBudget" class="form-control">               
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-budget" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-budget">Guardar</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal Funciones Cargos -->
<div class="modal fade" id="modalPosition" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir Funciones</h5>
                <button type="button" class="btn-close bg-white close-position" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-form-label">Funciones:</label>
                            <select name="cod_funcion" id="cod_funcion" class="form-control" data-style="btn btn-warning" required>
                                <option value="" selected>-</option>
                                <?php
                                    $sqlPosition   = "SELECT af.cod_funcion as codigo, af.nombre_funcion as nombre  FROM cargos_funciones af
                                        WHERE af.cod_estado = 1
                                        AND af.cod_funcion = '$codCargoP'
                                        ORDER BY codigo DESC";
                                    $stmtPosition  = $dbh->prepare($sqlPosition);
                                    $stmtPosition->execute();
                                    $rowsPositions = $stmtPosition->fetchAll();
                                    foreach ($rowsPositions as $position){       
                                ?>
                                <option value="<?= $position['codigo']; ?>"  ><?= $position['nombre']; ?></option>
                                <?php
                                    }
                                ?>
                            </select>             
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-position" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-position">Guardar</button>
            </div>
        </div>
    </div>
</div> 

<!-- Modal Nuevo Hito -->
<div class="modal fade" id="modalNewHito" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir Hito</h5>
                <button type="button" class="btn-close bg-white close-hito" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-sm-12 col-form-label">Nombre</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                <input class="form-control" type="text" name="nombre_hito" id="nombre_hito" required="true" autocomplete="off"/>
                                </div>
                            </div>
                            <label class="col-sm-12 col-form-label">Fecha Hito</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                <input class="form-control" type="date" name="date_hito" id="date_hito" required="true"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-hito" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-hito">Guardar</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Nueva Sub Actividad -->
<div class="modal fade" id="modalNewSubActivity" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-top">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-white">Añadir Sub Actividad</h5>
                <button type="button" class="btn-close bg-white close-subActivity" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="col-sm-12 col-form-label">Nombre</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                <input class="form-control" type="text" name="sub_nombre" id="sub_nombre" required="true" autocomplete="off" onkeyup="javascript:this.value=this.value.toUpperCase();"/>
                                </div>
                            </div>
                            <label class="col-sm-12 col-form-label">Fecha Inicial</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                <input class="form-control" type="date" name="sub_fecha_inicial" id="sub_fecha_inicial" required="true"/>
                                </div>
                            </div>
                            <label class="col-sm-12 col-form-label">Fecha Limite</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                <input class="form-control" type="date" name="sub_fecha" id="sub_fecha" required="true"/>
                                </div>
                            </div>
                            <label class="col-sm-12 col-form-label">Prioridad</label>
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <select name="sub_prioridad" id="sub_prioridad" class="single-select form-control" data-style="btn btn-warning" required>
                                        <option value="" disabled selected="selected">-</option>
                                        <?php             
                                            $sqlForaneo="SELECT codigo,nombre FROM actividades_prioridades where cod_estado=1";
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
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-subActivity" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary save-subActivity">Guardar</button>
            </div>
        </div>
    </div>
</div>  
