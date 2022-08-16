function number_format(amount, decimals) {
    amount += ''; // por si pasan un numero en vez de un string
    amount = parseFloat(amount.replace(/[^0-9\.-]/g, '')); // elimino cualquier cosa que no sea numero o punto
    decimals = decimals || 0; // por si la variable no fue fue pasada
    if (isNaN(amount) || amount === 0) 
        return parseFloat(0).toFixed(decimals);
    amount = '' + amount.toFixed(decimals);totalesSIS
    var amount_parts = amount.split('.'),
        regexp = /(\d+)(\d{3})/;
    while (regexp.test(amount_parts[0]))
        amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');
    return amount_parts.join('.');
}

function nuevoAjax()
{ var xmlhttp=false;
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
  var nombre, observaciones, fecha_limite, prioridad, estado_kanban;
  nombre=document.getElementById("nombre").value;
  observaciones=document.getElementById("observaciones").value;
  fecha_limite=document.getElementById("fecha_limite").value;
  prioridad=document.getElementById("prioridad").value;
  estado_kanban=document.getElementById("estado_activo").value;

  $.ajax({
    type:"POST",
    data:"nombre="+nombre+"&observaciones="+observaciones+"&fecha_limite="+fecha_limite+"&prioridad="+prioridad+"&estado_kanban="+estado_kanban,
    url:"actividades/ajaxSaveNewTask.php",
    success:function(r){
      if(r==1){        
          alerts.showSwal('success-message','kanban_board.php');
      }else{
          Swal.fire('ERROR!','El proceso tuvo un problema!. Contacte con el administrador!','error'); 
        }
    }
  });
}
