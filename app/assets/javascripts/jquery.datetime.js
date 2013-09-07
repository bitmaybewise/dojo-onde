//= require jquery-ui-bootstrap
//= require jquery-ui-timepicker

$(function(){
  $.datepicker.regional['pt'] = {
	closeText: 'Fechar',
	prevText: '<Anterior',
        nextText: 'Seguinte',
        currentText: 'Hoje',
        monthNames: ['Janeiro', 'Fevereiro', 'Mar&ccedil;o', 'Abril', 'Maio', 'Junho',
                     'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
        monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
                          'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
        dayNames: ['Domingo', 'Segunda-feira', 'Ter&ccedil;a-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'S&aacute;bado'],
        dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'S&aacute;b'],
        dayNamesMin: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'S&aacute;b'],
        weekHeader: 'Sem',
        dateFormat: 'dd/mm/yy',
        firstDay: 0,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
  $.datepicker.setDefaults($.datepicker.regional['pt']);

  $.timepicker.regional['pt'] = {
    currentText: "Agora",
    closeText: "Fechar",
    timeText: "Horário",
    hourText: "Hora",
    minuteText: "Minuto"
  };
  $.timepicker.setDefaults($.timepicker.regional['pt']);

  $(".datetime").datetimepicker({
    dateFormat: "dd/mm/yy",
    inline: true
  });
});
