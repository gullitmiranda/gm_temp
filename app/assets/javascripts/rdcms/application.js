// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.mb.browser
//= require rdcms/jquery.tools.min
//= require jquery-fileupload
//= require rdcms/moment

// Validações
//= require rails.validations
//= require_tree ./rails.validations/

// Aparência
//= require twitter/bootstrap
//= require bootstrap

// Evitar bug:
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
