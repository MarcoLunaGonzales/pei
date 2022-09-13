
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
            $('body .component-file ' + label).html(resp.content);
            responseAlert(resp.status);
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
                $('body .component-annotation ' + label).html(resp.content);
                responseAlert(resp.status);
                $('body #annotation').val('')
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
    $('#sub_fecha').val('');
    $("#sub_prioridad").val($("#sub_prioridad option:first").val());
    $('body #modal_task_detail').modal('hide');
    $('#modalNewSubActivity').modal('show');
}); 
/* Cerrar modal Presupuesto */
$('.close-subActivity').click(function(){
    $('body #modal_task_detail').modal('show');
    $('#modalNewSubActivity').modal('hide');
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
            $('body .component-collaborator ' + label).html(resp.content);
            $('body #modal_task_detail').modal('show');
            $('#modalCollaborator').modal('hide');
        }
    });
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
            $('.item-note-'+cod_anotacion).remove()
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
    $.ajax({
        url:"actividades/methods.php",
        type:"POST",
        contentType: false,
        processData: false,
        data: formData,
        success:function(response){
            let resp = JSON.parse(response);
            responseAlert(resp.status);
            $('body .component-budget ' + label).html(resp.content);
            $('body #modal_task_detail').modal('show');
            $('#modalBudget').modal('hide');
        }
    });
});
/**
 * Función para enviar y guardar la sub actividad
 **/
$('.save-subActivity').click(function(){
    let sub_nombre      = $('#sub_nombre').val();
    let sub_fecha       = $('#sub_fecha').val();
    let sub_prioridad   = $('#sub_prioridad').val();
    let code_act = $('body #codeActivity').val();
    let formData = new FormData();
    formData.append('type', 6);         // Tipo 6 : Guardar Sub Actividad
    formData.append('sub_nombre', sub_nombre);
    formData.append('sub_fecha', sub_fecha);
    formData.append('sub_prioridad', sub_prioridad);
    formData.append('code_activity', code_act);
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
});
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
            let badget = `<div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-thumbs-down"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted">Actividad sin presupuesto...</h5>
                                </div>
                            </div>
                        </div> `;
            let collaborator = `<div class="inbox-item">
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <div class="avatar-sm">
                                        <span class="avatar-title badge-soft-danger text-danger rounded">
                                            <i class="fe-user-x"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="col ps-0">
                                    <h5 class="mt-0 mb-0 text-muted">Actividad sin colaboradores...</h5>
                                </div>
                            </div>
                        </div>`;
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