!function (l) { "use strict"; function e() { 
    this.$body = l("body"), 
    this.$modal = l("#event-modal"), 
    this.$calendar = l("#calendar"), 
    this.$formEvent = l("#form-event"), 
    this.$newFormEvent = l("#new-form-event"), // Nuevo evento
    // this.$btnNewEvent = l("#btn-new-event"), 
    this.$btnDeleteEvent = l("#btn-delete-event"), 
    this.$btnSaveEvent = l("#btn-save-event"), 
    this.$modalTitle = l("#modal-title"), 
    this.$calendarObj = null, 
    this.$selectedEvent = null, 
    this.$newEventData = null 
} 
// Obtiene Detalle de Actividad Registrada
e.prototype.onEventClick = function (e) {
    this.$selectedEvent = e.event;
    if(this.$selectedEvent.extendedProps.type == 1){
        showModallistTaskDetail(this.$selectedEvent.extendedProps['code']);
    }else if(this.$selectedEvent.extendedProps.type == 3){
        $('.text-detail').html(this.$selectedEvent.title);
        $('.text-observation').html(this.$selectedEvent.extendedProps['description']);
        $('#detail-event-modal').modal('show');
    }
    // this.$formEvent[0].reset(), 
    // this.$formEvent.removeClass("was-validated"), 
    // this.$newEventData = null, 
    // this.$btnDeleteEvent.show(), 
    // this.$modalTitle.text("Edit Event"), 
    // this.$modal.show(), 
    // this.$selectedEvent = e.event, 
    // l("#event-title").val(this.$selectedEvent.title), 
    // l("#event-category").val(this.$selectedEvent.classNames[0])
}, 
// Click crea nuevo evento en Calendario
e.prototype.onSelect = function (e) { 
    this.$selectedEvent = e;
    let date = moment(this.$selectedEvent.dateStr).format('YYYY-MM-DD');
    let time = moment(this.$selectedEvent.dateStr).format('HH:mm');
    $('#fecha').val(date);
    $('#inicio').val(time);
    $('#new-event-modal').modal('show');
    
    // this.$formEvent[0].reset(), 
    // this.$formEvent.removeClass("was-validated"), 
    // this.$selectedEvent = null, 
    // this.$newEventData = e, 
    // this.$btnDeleteEvent.hide(), 
    // this.$modalTitle.text("Add New Event"), 
    // this.$modal.show(), 
    // this.$calendarObj.unselect() 
}, 
e.prototype.init = function () { 
    this.$modal = new bootstrap.Modal(
        document.getElementById("event-modal"), 
        { keyboard: !1 }
    ); 
var e = new Date(l.now()); 

// Evento Drag and Drop
// new FullCalendar.Draggable(document.getElementById("external-events"), { 
//     itemSelector: ".external-event", 
//     eventData: function (e) { 
//         return { title: e.innerText, className: l(e).data("class") } 
//     }}); 
var t = [
    { 
        title: "Meeting with Mr. Shreyu", 
        start: new Date(l.now() + 158e6), 
        end: new Date(l.now() + 338e6), 
        className: "bg-warning" 
    },
    { 
        title: "Interview - Backend Engineer",
        start: e, 
        end: e, 
        className: "bg-success" 
    }, 
    { 
        title: "Phone Screen - Frontend Engineer", 
        start: new Date(l.now() + 168e6), 
        className: "bg-info" 
    }, 
    { 
        title: "Phone Screen - Frontend Engineer", 
        start: new Date(l.now() + 168e6), 
        className: "bg-info" 
    }, 
    { 
        title: "Buy Design Assets", 
        start: new Date(l.now() + 338e6), 
        end: new Date(l.now() + 4056e5), 
        className: "bg-primary" 
    }
], 
a = this; 
a.$calendarObj = new FullCalendar.Calendar(a.$calendar[0], {
    locale: 'es',
    // slotDuration: "00:15:00", 
    // slotMinTime: "08:00:00", 
    // slotMaxTime: "19:00:00", 
    themeSystem: "bootstrap", 
    bootstrapFontAwesome: !1, 
    buttonText: { 
        today: "Hoy", 
        month: "Mes", 
        week: "Semana", 
        day: "Día", 
        list: "Lista", 
        prev: "<", 
        next: ">" 
    }, 
    initialView: "dayGridMonth", 
    handleWindowResize: !0, 
    height: l(window).height() - 300, 
    headerToolbar: { 
        left: "prev,next today", 
        center: "title", 
        // right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth" 
        right: "dayGridMonth,timeGridWeek" 
    }, 
    // initialEvents: t,
    events:  'calendario/ajaxActivity.php',
    editable: !0, 
    droppable: !0, 
    selectable: !0, 
    dateClick: function (e) { 
        a.onSelect(e) 
    }, 
    eventClick: function (e) { 
        a.onEventClick(e) 
    } 
}), 
a.$calendarObj.render(), 

// a.$btnNewEvent.on("click", function (e) { 
//     a.onSelect({ 
//         date: new Date, 
//         allDay: !0 
//     }) 
// }), 

// Nuevo Evento Añadito al Calendario
a.$newFormEvent.on("submit", function (e) { 
    e.preventDefault(); 
    a.$newFormEvent[0]; 
    var t;
    t = { 
        title: $("#detalle").val(), 
        start: $("#fecha").val() + ' ' + $("#inicio").val(), 
        end: $("#fecha").val() + ' ' + $("#fin").val(),
        className: 'bg-warning' 
    }, 
    
    a.$calendarObj.addEvent(t)
}), 
a.$formEvent.on("submit", function (e) { 
    e.preventDefault(); 
    var t, n = a.$formEvent[0]; 
    n.checkValidity() ? (a.$selectedEvent ? (a.$selectedEvent.setProp("title", l("#event-title").val()), 
    a.$selectedEvent.setProp(
        "classNames", [
            l("#event-category").val()
        ]
    )) : (
        t = { 
            title: l("#event-title").val(), 
            start: a.$newEventData.date, 
            allDay: a.$newEventData.allDay, 
            className: l("#event-category").val() 
        }, 
        a.$calendarObj.addEvent(t)
    ), 
    a.$modal.hide()) : (e.stopPropagation(), n.classList.add("was-validated")) 
}), 
l(a.$btnDeleteEvent.on("click", function (e) { 
    a.$selectedEvent && (a.$selectedEvent.remove(), a.$selectedEvent = null, a.$modal.hide()) 
})) 
}, 
l.CalendarApp = new e, 
l.CalendarApp.Constructor = e 
}(window.jQuery), function () { 
    "use strict"; 
    window.jQuery.CalendarApp.init() 
}();