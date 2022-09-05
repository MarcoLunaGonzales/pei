<?php

require_once '../conexion.php';
$dbh = new Conexion();
$codigoActividad=$_GET["codigo_actividad"];

$sqlActividad="SELECT a.codigo, a.nombre, a.observaciones, DATE_FORMAT(a.fecha_limite,'%b %d, %Y')as fecha_limite, a.cod_prioridad, ap.nombre as nombre_prioridad, ap.color,
(select np.nombre from niveles_pei np where np.codigo=a.cod_componentepei)as nombrecomponentepei, np.nombre as nombreproyecto from actividades a, actividades_prioridades ap, niveles_pei np where a.cod_prioridad=ap.codigo and a.cod_componentepei=np.codigo and a.codigo='$codigoActividad'";

$stmtActividad= $dbh->prepare($sqlActividad);
$stmtActividad->execute();
$nombreActividad="";
$nombreProyecto="";
while ($rowActividad = $stmtActividad->fetch(PDO::FETCH_ASSOC)) {
    $codigoActividad=$rowActividad['codigo'];
	$nombreActividad=$rowActividad['nombre'];
	$nombreProyecto=$rowActividad['nombreproyecto'];
}

?>
<div id="bodyTaskComplete">    
    <div class="modal-header">
        <h5 class="modal-title" id="scrollableModalTitle">Actividad <?=$nombreActividad;?>  Proyecto: <?=$nombreProyecto;?></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
    	<div class="row">
    		<div class="col-lg-8">
                <!-NOTAS->
                <div class="card border-primary border mb-3">
	                <div class="card-header">
	                    <h5 class="card-title">Aqui van las Notas</h5>
	                </div>
	                <div class="card-body">
	                </div>
	                <div class="button-list">
	                	<button type="button" class="btn btn-soft-primary btn-xs rounded-pill waves-effect waves-light">
	                		<i class="bx bxs-file-plus mr-1"></i>
   	             		</button>
   	             	</div>
                </div>
                <!-FIN NOTAS->

                    <!-- Add note input-->
                    <div class="mt-3">
                        <label for="example-textarea" class="form-label">Add a Note:</label>
                        <textarea class="form-control" id="example-textarea" rows="3" placeholder="Write some note.."></textarea>
                    </div>

                    <!-- action buttons-->
                    <div class="row mt-4">
                        <div class="col-sm-6">
                            <a href="ecommerce-products.html" class="btn text-muted d-none d-sm-inline-block btn-link fw-semibold">
                                <i class="mdi mdi-arrow-left"></i> Continue Shopping </a>
                        </div> <!-- end col -->
                        <div class="col-sm-6">
                            <div class="text-sm-end">
                                <a href="ecommerce-checkout.html" class="btn btn-danger"><i class="mdi mdi-cart-plus me-1"></i> Checkout </a>
                            </div>
                        </div> <!-- end col -->
                    </div> <!-- end row-->
                </div>
                <!-- end col -->
                <div class="col-lg-4">hola</div>
    	</div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
    </div>
</div>
    