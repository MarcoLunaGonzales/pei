function number_format(amount, decimals) {
    amount += ''; // por si pasan un numero en vez de un string
    amount = parseFloat(amount.replace(/[^0-9\.-]/g, '')); // elimino cualquier cosa que no sea numero o punto
    decimals = decimals || 0; // por si la variable no fue fue pasada
    if (isNaN(amount) || amount === 0) 
        return parseFloat(0).toFixed(decimals);
    amount = '' + amount.toFixed(decimals);
    var amount_parts = amount.split('.'),
        regexp = /(\d+)(\d{3})/;
    while (regexp.test(amount_parts[0]))
        amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');
    return amount_parts.join('.');
}

function nuevoAjax(){ 
  var xmlhttp=false;
  try {
      xmlhttp = new ActiveXObject('Msxml2.XMLHTTP');
  } catch (e) {
  try {
    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
  } catch (E) {
    xmlhttp = false;
  }
  }
  if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
  xmlhttp = new XMLHttpRequest();
  }
  return xmlhttp;
}

function showModalNewTask(estado){
  document.getElementById("estado_activo").value=estado;
  console.log("estado EK: "+estado);
  $("#modalNewTask").modal("show");  
}

function saveNewTask(){
  var nombre, observaciones, fecha_limite, prioridad, estado_kanban, cod_componentepei;
  nombre=document.getElementById("nombre").value;
  observaciones=document.getElementById("observaciones").value;
  fecha_inicio=document.getElementById("fecha_inicio").value;
  fecha_limite=document.getElementById("fecha_limite").value;
  prioridad=document.getElementById("prioridad").value;
  estado_kanban=document.getElementById("estado_activo").value;
  cod_componentepei=document.getElementById("componente_pei").value;

  $.ajax({
    type:"POST",
    data:"nombre="+nombre+"&observaciones="+observaciones+"&fecha_limite="+fecha_limite+"&fecha_inicio="+fecha_inicio+"&prioridad="+prioridad+"&estado_kanban="+estado_kanban+"&componente_pei="+cod_componentepei,
    url:"actividades/ajaxSaveNewTask.php",
    success:function(r){
      if(r==1){        
          alerts.showSwal('success-message','index.php?opcion=listTasks&cod_proyecto='+cod_componentepei+'');
      }else{
          Swal.fire('ERROR!','El proceso tuvo un problema!. Contacte con el administrador!','error'); 
        }
    }
  });
}

function validarFormCamposNiveles(form){
  alert("ingreso");
  return (false);
}

function showModalConfiguracionPropiedadComponente(codigoNivelPEI){
  $("#modalShowConfiguracionPropiedad").modal("show");  
  var contenedor=document.getElementById("modalShowConfiguracionPropiedad");
  $.ajax({
    type:"POST",
    data:"codigoNivelPEI="+codigoNivelPEI,
    url:"t_niveles_pei/ajaxConfiguracionPropiedadComponentePEI.php",
    success:function(r){
      var respuesta=r;
      contenedor.innerHTML = respuesta;
      console.log("entrando show conf propiedad Comp");
    }
  });  
}

function showModallistTaskDetail(codigo_actividad){
  console.log("actividad: "+codigo_actividad);
  $("#modal_task_detail").modal("show"); 
  var contenedor=document.getElementById("div_task_detail");
  $.ajax({
    type:"GET",
    data:"codigo_actividad="+codigo_actividad,
    url:"actividades/ajaxTaskDetail.php",
    success:function(r){
      var respuesta=r;
      contenedor.innerHTML = respuesta;
      console.log("entrando al detalle Tarea");
    }
  });
}