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
//= require rdcms/jquery.tools.min.js
//= require jquery-fileupload
//= require turbolinks
//= require rdcms/moment

// Validações
//= require rails.validations
//= require_tree ./rails.validations/

// Aparência
//= require twitter/bootstrap

//= require_tree ./plugins/

// Evitar bug:
// NS_ERROR_XPC_BAD_CONVERT_JS: Could not convert JavaScript argument
jQuery.ajaxSettings.traditional = true;

$(document).ready(function(){

  moment.weekdaysMin = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"];

  // Trigger display of widgets. If widget has offline_times set show
  // alternative content instead.
  $('[data-offline-active=true]').each( function(index, element){
    var days = $(element).attr('data-time-day');
    var start_time = parseInt($(element).attr('data-time-start'));
    var end_time = parseInt($(element).attr('data-time-end'));

    var cur_day = moment().format('dd');
    var cur_time = parseInt(moment().format('Hmm'));

    if ((days.indexOf(cur_day) != -1) && ((start_time < cur_time) && (cur_time < end_time))) {
      // Widget muss ausgeblendet werden
      $(element).addClass("hidden");
      $(element).next("[data-id="+ $(element).attr('data-id') + "]").removeClass("hidden");
    }

  });

  console.log($('.rdcms_widget.hidden').length);
  $('.rdcms_widget.hidden').remove();
  console.log($('.rdcms_widget.hidden').length);

});