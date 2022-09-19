
let label = '> .simplebar-wrapper > .simplebar-mask > .simplebar-offset > .simplebar-content-wrapper > .simplebar-content';
/**
 * Función para enviar y guardar archivos a "methods.php"
 **/
$('body').on('change','#src-file1-input',function(){
    // Cambia texto de input de tioo Archivo
    // var filename = "'" + $(this).val().replace(/^.*[\\\/]/, '') + "'";
    // $(this).parent().css('--fn', filename);
    let sizeByte = $(this)[0].files[0].size;
    let sizekiloBytes = parseInt(sizeByte / 1024);
    let sizeFile = sizekiloBytes > 1024 ? (parseInt(sizekiloBytes / 1024) + ' MB') : (sizekiloBytes + ' KB');
    let formData = new FormData();
    let files    = $(this)[0].files[0];
    let code_act = $('body #codeActivity').val();
    formData.append('type', 1);         // Tipo 1 : Guardar Archivos
    formData.append('code_activity', code_act);
    formData.append('file', files);
    formData.append('size', sizeFile);
    $.ajax({
        url:"actividades/methods.php",
        type:"POST",
        contentType: false,
        processData: false,
        data: formData,
        success:function(response){
            let resp = JSON.parse(response);
            responseAlert(resp.status);
            if(resp.status){
                showModallistTaskDetail(resp.code_activity);
            }
        }
    });
});
/**
 * Función para enviar y guardar Nota a "methods.php"
 **/
$('body').on('click','#save-annotation',function(){
    let annotation = $('body #annotation').val();
    let code_act   = $('body #codeActivity').val();
    let formData   = new FormData();
    formData.append('type', 2);         // Tipo 2 : Guardar Notas
    formData.append('code_activity', code_act);
    formData.append('annotation', annotation);
    if(annotation.length > 5){
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);
                responseAlert(resp.status);
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            '¡La nota debe tener al menos 5 caracteres!',
            'warning'
        );
    }
});
/* Abrir modal de asignación de colaborador */
$('body').on('click', '.addCollaborator', function(){
    $("#cod_personal").val($("#cod_personal option:first").val());
    $('body #modal_task_detail').modal('hide');
    $('#modalCollaborator').modal('show');
});
/* Cerrar modal Colaborador */
$('.close-collaborator').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalCollaborator').modal('hide');
});
/* Abrir modal de asignación de presupuesto */
$('body').on('click', '.addBudget', function(){
    $("#cod_account").val($("#cod_account option:first").val());
    $("#amount").val('');
    $('body #modal_task_detail').modal('hide');
    $('#modalBudget').modal('show');
}); 
/* Cerrar modal Presupuesto */
$('.close-budget').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalBudget').modal('hide');
});
/* Abrir modal de subactividad */
$('body').on('click', '.addSubActivity', function(){
    $("#sub_nombre").val('');
    $('#sub_fecha_inicial').attr('min', $(this).data('start'))
                            .attr('max', $(this).data('end'))
                            .val($(this).data('val'));
    $('#sub_fecha').attr('min', $(this).data('start'))
                            .attr('max', $(this).data('end'))
                            .val($(this).data('val'));
    $("#sub_prioridad").val($("#sub_prioridad option:first").val());
    $('body #modal_task_detail').modal('hide');
    $('#modalNewSubActivity').modal('show');
}); 
/* Abrir modal de hito */
$('body').on('click', '.addHito', function(){
    $("#nombre_hito").val('');
    $('#date_hito').attr('min', $(this).data('start'))
                            .attr('max', $(this).data('end'))
                            .val('');
    $('body #modal_task_detail').modal('hide');
    $('#modalNewHito').modal('show');
}); 
/* Cerrar modal Presupuesto */
$('.close-subActivity').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalNewSubActivity').modal('hide');
});
/* Cerrar modal Hito */
$('.close-hito').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalNewHito').modal('hide');
});
/* Abrir modal de asignacion de Funciones */
$('body').on('click', '.addPosition', function(){
    $("#cod_funcion").val($("#cod_personal option:first").val());
    $('body #modal_task_detail').modal('hide');
    $('#modalPosition').modal('show');
});
/* Cerrar modal Funcion */
$('.close-position').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalPosition').modal('hide');
});
/**
 * Función para enviar y guardar la asignación del colaborador
 **/
$('.save-collaborator').click(function(){
    let cod_personal = $('#cod_personal').val();
    let code_act     = $('body #codeActivity').val();
    let formData     = new FormData();
    formData.append('type', 3);         // Tipo 3 : Guardar Asignación
    formData.append('cod_personal', cod_personal);
    formData.append('code_activity', code_act);
    if(cod_personal > 0){
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);
                if(resp.status == 3){
                    Swal.fire(
                        'Oops...',
                        'El colaborador ya se cuentra asignado a la actividad',
                        'warning'
                    );
                }else{
                    responseAlert(resp.status);
                }
                $('#modalCollaborator').modal('hide');
                console.log(resp)
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            '¡La nota debe tener al menos 5 caracteres!',
            'warning'
        );
    }
});
/**
 * Remover registro
 **/
$('body').on('click', '.remove-note', function(){
    let cod_anotacion = $(this).data('codigo');
    let code_act   = $('body #codeActivity').val();
    let formData     = new FormData();
    formData.append('type', 4);         // Tipo 4 : Eliminar Nota 
    formData.append('codigo', cod_anotacion);         // Tipo 4 : Eliminar Nota
    formData.append('code_activity', code_act);
    $.ajax({
        url:"actividades/methods.php",
        type:"POST",
        contentType: false,
        processData: false,
        data: formData,
        success:function(response){
            let resp = JSON.parse(response);
            responseAlert(resp.status);
            if(resp.status){
                showModallistTaskDetail(resp.code_activity);
            }
        }
    });
});
/**
 * Función para enviar y guardar el presupuesto asignado a la actividad
 **/
$('.save-budget').click(function(){
    let cod_account = $('#cod_account').val();
    let amount      = $('#amount').val();
    let dateBudget  = $('#dateBudget').val();
    let code_act    = $('body #codeActivity').val();
    let formData    = new FormData();
    formData.append('type', 5);         // Tipo 5 : Guardar Asignación
    formData.append('cod_account', cod_account);
    formData.append('amount', amount);
    formData.append('dateBudget', dateBudget);
    formData.append('code_activity', code_act);
    if(cod_account > 0 && amount != '' && dateBudget != ''){
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);            
                $('#modalBudget').modal('hide');
                responseAlert(resp.status);
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            'Debe llenar los campos del formulario',
            'warning'
        );
    }
});
/**
 * Función para enviar y guardar la sub actividad
 **/
$('.save-subActivity').click(function(){
    let sub_nombre      = $('#sub_nombre').val();
    let sub_fecha       = $('#sub_fecha').val();
    let sub_fecha_inicial = $('#sub_fecha_inicial').val();
    let sub_prioridad   = $('#sub_prioridad').val();
    let code_act = $('body #codeActivity').val();
    let formData = new FormData();
    formData.append('type', 6);         // Tipo 6 : Guardar Sub Actividad
    formData.append('sub_nombre', sub_nombre);
    formData.append('sub_fecha', sub_fecha);
    formData.append('sub_fecha_inicial', sub_fecha_inicial);
    formData.append('sub_prioridad', sub_prioridad);
    formData.append('code_activity', code_act);
    if(sub_nombre != '' && sub_fecha_inicial != '' && sub_fecha != '' && sub_prioridad > 0){
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);
                $('body #modal_task_detail').modal('show');
                $('#modalNewSubActivity').modal('hide');
                responseAlert(resp.status);
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            'Debe llenar los campos del formulario',
            'warning'
        );
    }
});
/** 
 * Registrar Nuevo Hito 
**/
$('.save-hito').click(function(){
    let nombre_hito = $('#nombre_hito').val();
    let date_hito   = $('#date_hito').val();
    let code_act = $('body #codeActivity').val();
    let formData = new FormData();
    formData.append('type', 10);         // Tipo 10 : Registro de Hito
    formData.append('nombre_hito', nombre_hito);
    formData.append('date_hito', date_hito);
    formData.append('code_activity', code_act);
    if(nombre_hito != '' && date_hito != ''){
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);
                $('#modalNewHito').modal('hide');
                responseAlert(resp.status);
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            'Debe llenar los campos del formulario',
            'warning'
        );
    }
})
/**
 * Visualización de nueva actividad
 **/
$('body').on('click', '.show-activity', function(){
    showModallistTaskDetail($(this).data('cod_actividad'));
});

/**
 * Visualización de Detalle general de Acitividad
 **/
$('.showActivity').click(function(){
    let code_act = $(this).data('cod_activity');
    let formData = new FormData();
    formData.append('type', 0);         // Tipo 0 : mostrar Detalle de Actividad
    formData.append('code_activity', code_act);
    $.ajax({
        url:"actividades/methods.php",
        type:"POST",
        contentType: false,
        processData: false,
        data: formData,
        success:function(response){
            let resp = JSON.parse(response);
            console.log(resp);
            let files = `<div class="card mb-1 shadow-none border">
                            <div class="p-2">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <div class="avatar-sm">
                                            <span class="avatar-title badge-soft-danger text-danger rounded">
                                                X
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col ps-0">
                                        <h5 class="mt-0 mb-0 text-muted">No hay archivos adjuntos</h5>
                                    </div>
                                </div>
                            </div>
                        </div>`;
            let notes = `<div class="card shadow-none border">
                            <div class="p-2">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <div class="avatar-sm">
                                            <span class="avatar-title badge-soft-danger text-danger rounded">
                                                <i class="fe-message-circle"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col ps-0">
                                        <h5 class="mt-0 mb-0 text-muted">No hay notas registradas.</h5>
                                    </div>
                                </div>
                            </div>
                        </div>`;
            let subActivities = `<div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-folder-minus"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted">No se encontró subactividades...</h5>
                                </div>
                            </div>
                        </div> `;
            $('.component-subActivity-show ' + label).html(resp.subAcitividades.length > 0 ? resp.subAcitividades : subActivities);
            $('.component-file-show ' + label).html(resp.archivos.length > 0 ? resp.archivos : files);
            $('.component-annotation-show ' + label).html(resp.anotacion.length > 0 ? resp.anotacion : notes);
            $('.user_manager').html(resp.data.nombre_responsable);
            $('.date_limit').html(resp.data.fecha_limite);
            $('.description_activity').html(resp.data.observaciones);
            $('.initial-activity').hide();
            $('.detail-activity').show();
        }
    });
});
/**
 * Mensaje de alerta despues de recibir respuesta del BACKEND
 **/
function responseAlert(status){
    if(status){
        Swal.fire(
            'Correcto!',
            'El proceso se completo correctamente',
            'success'
        );
    }else{
        Swal.fire(
            'Oops...',
            '¡Algo salió mal!',
            'error'
        );
    }
}
/*****************************************************|
 * Selección de variables de Actividad a Actualizarse *
|*****************************************************/
let select_data = 0;
$('body').on('click', '.data_select',function(){
    $(this).hide();
    $('#'+$(this).data('inp')).show()
                .focus()
                .select();
    select_data = $(this).data('select');
});
// Actualización Evento ENTER
$('body').on('keypress', '.data_update', function(e){
    let code_act = $('body #codeActivity').val();
    if(e.which == 13){
        updateData($(this).val(), code_act);
    }
});
// Actualización Evento Click SELECT
$('body').on('change', '.data_update', function(){
    let code_act = $('body #codeActivity').val();
    updateData($(this).val(), code_act);
});
// Actualización Evento Click - Cambio de estado PARADO
$('body').on('click', '.data_update_state', function(){
    let code_act = $('body #codeActivity').val();
    select_data  = $(this).data('select');
    updateData($(this).data('state'), code_act);
});
// Actualzación de DATOS de Actividad
function updateData(data, code_act){
    let formData = new FormData();
    formData.append('type', 7);         // Tipo 7 : Actualización de Datos
    formData.append('data', data);
    formData.append('select_data', select_data);
    formData.append('code_activity', code_act);
    $.ajax({
        url:"actividades/methods.php",
        type:"POST",
        contentType: false,
        processData: false,
        data: formData,
        success:function(response){
            let resp = JSON.parse(response);
            $('#modalNewSubActivity').modal('hide');
            responseAlert(resp.status);
            if(resp.status){
                showModallistTaskDetail(resp.code_activity);
            }
        }
        
    });
}
/**
 * Eliminar presupuesto que aun se encuentra en estado PENDIENTE
 **/
$('body').on('click','.selectBudget', function(){
    swal({
        title: '¿Está seguro de Eliminar el presupuesto?',
        text: "No podrá revertir el borrado!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        confirmButtonText: 'Si, Borrar!',
        cancelButtonText: 'No, Cancelar!',
        buttonsStyling: false
    }).then((result) => {
        if (result.value) {
            let cod_presupuesto = $(this).data('codigo');
            let code_act        = $('body #codeActivity').val();
            let formData        = new FormData();
            formData.append('type', 8);         // Tipo 8 : Eliminar Presupuesto 
            formData.append('codigo', cod_presupuesto);
            formData.append('code_activity', code_act);
            $.ajax({
                url:"actividades/methods.php",
                type:"POST",
                contentType: false,
                processData: false,
                data: formData,
                success:function(response){
                    let resp = JSON.parse(response);
                    responseAlert(resp.status);
                    if(resp.status){
                        showModallistTaskDetail(resp.code_activity);
                    }
                }
            });
        }
    });
});
/**
 * Quitar Colaborador asignado a la Actividad
 **/
$('body').on('click','.selectCollaborator', function(){
    swal({
        title: '¿Está seguro?',
        text: "No podrá revertir el borrado!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        confirmButtonText: 'Si, Borrar!',
        cancelButtonText: 'No, Cancelar!',
        buttonsStyling: false
    }).then((result) => {
        if (result.value) {
            let cod_personal = $(this).data('codigo_personal');
            let code_act     = $('body #codeActivity').val();
            let formData     = new FormData();
            formData.append('type', 9);         // Tipo 9 : Eliminar Colaborador 
            formData.append('codigo', cod_personal);
            formData.append('code_activity', code_act);
            $.ajax({
                url:"actividades/methods.php",
                type:"POST",
                contentType: false,
                processData: false,
                data: formData,
                success:function(response){
                    let resp = JSON.parse(response);
                    responseAlert(resp.status);
                    if(resp.status){
                        showModallistTaskDetail(resp.code_activity);
                    }
                }
            });
        }
    });
});
/**
 * Función para almacenar Funciones de Cargo
 **/
$('.save-position').click(function(){
    let cod_funcion_cargo = $('#cod_funcion').val();
    let code_act          = $('body #codeActivity').val();
    let formData          = new FormData();
    formData.append('type', 11);         // Tipo 11 : Guardar Función de Cargo
    formData.append('cod_funcion_cargo', cod_funcion_cargo);
    formData.append('code_activity', code_act);
    if($('#cod_funcion').val() > 0){        
        $.ajax({
            url:"actividades/methods.php",
            type:"POST",
            contentType: false,
            processData: false,
            data: formData,
            success:function(response){
                let resp = JSON.parse(response);
                if(resp.status == 3){
                    Swal.fire(
                        'Oops...',
                        'La Función de Cargo ya se cuentra asignado a la actividad',
                        'warning'
                    );
                }else{
                    responseAlert(resp.status);
                }
                $('#modalPosition').modal('hide');
                console.log(resp)
                if(resp.status){
                    showModallistTaskDetail(resp.code_activity);
                }
            }
        });
    }else{
        Swal.fire(
            'Oops...',
            'Debe llenar los campos del formulario',
            'warning'
        );
    }
});
/**
 * Quitar Cargo de Función
 **/
$('body').on('click','.selectFunction', function(){
    swal({
        title: '¿Está seguro de Eliminar?',
        text: "No podrá revertir el borrado!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        confirmButtonText: 'Si, Borrar!',
        cancelButtonText: 'No, Cancelar!',
        buttonsStyling: false
    }).then((result) => {
        if (result.value) {
            let cod_funcion = $(this).data('codigo');
            let code_act    = $('body #codeActivity').val();
            let formData    = new FormData();
            formData.append('type', 12);         // Tipo 12 : Quitar Función de Cargo 
            formData.append('codigo', cod_funcion);
            formData.append('code_activity', code_act);
            $.ajax({
                url:"actividades/methods.php",
                type:"POST",
                contentType: false,
                processData: false,
                data: formData,
                success:function(response){
                    let resp = JSON.parse(response);
                    responseAlert(resp.status);
                    if(resp.status){
                        showModallistTaskDetail(resp.code_activity);
                    }
                }
            });
        }
    });
});