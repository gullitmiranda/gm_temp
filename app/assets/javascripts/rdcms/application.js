//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require rdcms/plugins/jquery.mb.browser
//= require rdcms/plugins/jquery.chosen.min
//= require rdcms/plugins/jquery.chosen.init
//= require rdcms/plugins/jquery.tools.min
//= require rdcms/plugins/rails.validations
//= require rdcms/plugins/rails.validations.action_view

//= require rdcms/admin/moment

//= require jquery-fileupload

//= require twitter/bootstrap
//= require rdcms/init/bootstrap
//= require rdcms/init/social

//= require rdcms/sliders

// avoid bug:
// NS_ERROR_XPC_BAD_CONVERT_JS: Could not convert JavaScript argument
jQuery.ajaxSettings.traditional = true;

$(document).ready(function(){

  moment.weekdaysMin = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"];

  // Trigger display of widgets. If widget has offline_times set show
  // alternative content instead.
  $('[data-offline-active=true]').each( function(index, element){
    var currentDay = moment().format("dd");
    var isCurrentDay = $(element).attr("data-time-day-" + currentDay) && $(element).attr("data-time-day-" + currentDay).length > 0 ? true : false;

    // wenn aktueller Wochentag gesetzt ist
    if (isCurrentDay) {
      // Zeitdaten
      var currentTime = parseInt(moment().format("Hmm"));
      var offTimeInterval = $(element).attr("data-time-day-" + currentDay).split("-");
      var startTime = parseInt(offTimeInterval[0]);
      var endTime = parseInt(offTimeInterval[1]);
      // Zeitboolean
      var isInTime = startTime <= currentTime && currentTime <= endTime ? true : false;

      // wenn aktuelle Zeit im Intervall liegt
      if (isInTime) {
        // check, ob Start- und Endattribute vorhanden sind
        var isDataDateStart = $(element).attr("data-date-start") && $(element).attr("data-date-start").length > 0 ? true : false;
        var isDataDateEnd = $(element).attr("data-date-end") && $(element).attr("data-date-end").length > 0 ? true : false;

        /* wenn Start- und Enddatum nicht gesetzt sind,
           dann muss der Offlineinhalt angezeigt werden */
        if (!isDataDateStart && !isDataDateEnd) {
          // Widget muss ausgeblendet werden
          $(element).addClass("hidden");
          $(element).next("[data-id=" + $(element).attr("data-id") + "]").removeClass("hidden");
        }
        /* Wenn Start- und Enddatum gesetzt sind,
           muss geprüft werden, ob der aktuelle Tag
           im Intervall liegt und wenn ja,
           muss der Offlineinhalt angezeigt werden */
        else if (isDataDateStart && isDataDateEnd) {
          // Datumsdaten
          var currentDate = parseInt(moment().format("YYYYMMDD"));
          var startDate = parseInt($(element).attr("data-date-start"));
          var endDate = parseInt($(element).attr("data-date-end"));
          // Datumsboolean
          var isCurrentDate = startDate <= currentDate && endDate >= currentDate ? true : false;
          if (isCurrentDate) {
            // Widget muss ausgeblendet werden
            $(element).addClass("hidden");
            $(element).next("[data-id=" + $(element).attr("data-id") + "]").removeClass("hidden");
          }
        }
      }
    }
  });

  $('.rdcms_widget.hidden').remove();
});
