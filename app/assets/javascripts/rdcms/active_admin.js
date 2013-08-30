//= require active_admin/base
//= require jquery
//= require jquery_ujs

//= require rdcms/plugins/modernizr.2.5.3.min
//= require rdcms/plugins/jquery.mb.browser
//= require rdcms/plugins/jquery.easing.1.3
//= require rdcms/plugins/jquery.mousewheel.min
//= require rdcms/plugins/jquery.chosen.min
//= require rdcms/plugins/jquery.chosen.init
//= require rdcms/plugins/jquery.meio.mask
//= require rdcms/plugins/rails.validations
//= require rdcms/plugins/rails.validations.action_view

//= require rdcms/admin/keymaster
//= require rdcms/admin/formstyle
//= require rdcms/admin/farbtastic

//= require best_in_place
//= require jquery-fileupload
//= require twitter/bootstrap
//= require rdcms/init/bootstrap
//= require bootstrap-editable

//= require rdcms/init/social

//= require rdcms/sliders

// Evitar bug:
// NS_ERROR_XPC_BAD_CONVERT_JS: Could not convert JavaScript argument
// jQuery.ajaxSettings.traditional = true;
/* Configurações default do x-editable */
$.fn.editable.defaults = $.extend({}, $.fn.editable.defaults, {
  ajaxOptions: {
    type: 'put',
    dataType: 'json'
  },
  disabled: true,
  mode: "inline"
});

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place()
    .bind("best_in_place:activate", function() { $(this).addClass("focus"); })
    .bind("best_in_place:abort", function() { $(this).removeClass("focus"); });

  // call setMask function on the document.ready event
  if (!$.browser.webkit)
    $('input[type=text], input[type=password], input[type=email], input[type=number], input[type=url], input[type=tel]')
      .setMask();

  //Add Button Background Jobs zu Settings
  $('#einstellungen ul').append("<li><a href='/admin/background'>Background Jobs</a></li>")

  //Image Manager
  $("a#open_rdcms_image_maganger").bind("click", function(){
    $("#rdcms_image_maganger").fadeToggle();
    return false;
  });

  $("#rdcms_image_maganger").draggable({
    handle: ".header"
  });

  $("#rdcms_image_maganger div.header div.close").bind("click", function(){
    $("#rdcms_image_maganger").fadeOut();
  });

  $('#footer').html("<p>Rdcms - Copyright© 2012 <a href=\"htttp://www.requestdev.com.br\">Requestdev</a></p>")

  //die fieldsets bekommen einen button zum auf und zu klappen
  $('div#main_content fieldset.foldable legend').prepend("<div class='foldable_icon_wrapper'><div class='foldable_icon'></div></div>")
  $('div#main_content fieldset.foldable legend').bind("click", function(){
    $(this).closest("fieldset").find(".foldable_icon").toggleClass("open");
    $(this).closest("fieldset").find('ol').slideToggle();
  });
  $('div#main_content fieldset.foldable.closed legend').trigger("click");


  // Atalhos de formulários Formulários
  // $("#main_content form input:submit").attr("value", $("#main_content form input:submit").attr("value") + " (⌘-S)");
  // key('⌘+s, ctrl+s', function() {
  //   $("#main_content form input:submit").trigger("click");
  //   return false;
  // });
  // $("form .form-actions .btn.cancel").append(" (ESC)");
  // key('esc', function(){
  //   $("form .form-actions .btn.cancel").trigger("click");
  //   return false;
  // });

  // Action Items
  // $("#title_bar .action_items a[href$='new']").append(" (⌘-N)")
  // key('⌘+n, ctrl+n', function(){
  //   $("#title_bar .action_items a[href$='new']").trigger("click");
  //   return false;
  // });

  // $("#title_bar .action_items a[href$='edit']").append(" (⌘-E)")
  // key('⌘+e, ctrl+e', function(){
  //   $("#title_bar .action_items a[href$='edit']").trigger("click");
  //   return false;
  // });

  // $("#title_bar .action_items a[href$='revert']").append(" (⌘-Z)");
  // key('⌘+z, ctrl+z', function(){
  //   target = $("#title_bar .action_items a[href$='revert']").attr("href");
  //   window.location = target;
  //   return false;
  // });

  $('.expert').hide();

  /**** DOM Manipulation Zeitsteuerung ****/
  /* text input felder für den jeweiligen
     tag in dom gruppieren */

  // hilfsarray tage englisch kurz
  var engDaysShort = ["mo", "tu", "we", "th", "fr", "sa", "su"];
  // tages checkboxen elemente (mo, di, ..., so)
  var checkBoxesDays = $(".choice");
  // für jede checkbox die dazugehörigen input felder holen und anhängen
  checkBoxesDays.each(function(i, el) {
    // checkbox muss neue css styles erhalten
    var addCssBox = {"float" : "left", "width" : "50px", "margin-top" : "8px"};
    $(el).height(50).find("label").css(addCssBox);
    // selektoren für start und end inputs eines tages
    var startInput = $("#widget_offline_time_start_" + engDaysShort[i] + "_input");
    var endInput = $("#widget_offline_time_end_" + engDaysShort[i] + "_input");
    // label der inputs entfernen und benötigten css style ergänzen
    var addCssInput = {"float" : "left", "width" : "180px"};
    $(startInput).css(addCssInput).find("label").remove();
    $(endInput).css(addCssInput).find("label").remove();
    // inputs zur checkbox gruppieren
    $(startInput).appendTo(el);
    $(endInput).appendTo(el);
  });
  /**** END DOM Manipulation *****/
});


//Notifications
function notify(title,body,token) {
    // check for notification compatibility
    if(!window.Notification) {
        // if browser version is unsupported, be silent
        return;
    }
    // log current permission level
    console.log(Notification.permissionLevel());
    // if the user has not been asked to grant or deny notifications from this domain
    if(Notification.permissionLevel() === 'default') {
        Notification.requestPermission(function() {
            // callback this function once a permission level has been set
            notify();
        });
    }
    // if the user has granted permission for this domain to send notifications
    else if(Notification.permissionLevel() === 'granted') {
        var n = new Notification(
                    title,
                    { 'body': body,
                      // prevent duplicate notifications
                      'tag' : token,
                      'onclick': function(){
                        console.log("notification clicked");
                      },
                      // callback function when the notification is closed
                      'onclose': function() {
                           console.log('notification closed');
                       }
                    }
                );
    }
    // if the user does not want notifications to come from this domain
    else if(Notification.permissionLevel() === 'denied') {
      // be silent
      return;
    }
}

/* Protototypes */
String.prototype.truncate = function (limit, dots) {
  var dots = (dots && typeof dots == "boolean") ? "..." : (typeof dots == "string") ? dots : "";
  return this.length > limit ? this.substring(0,limit) + dots : this;
}
