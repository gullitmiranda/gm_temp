//= require active_admin/base
//= require jquery
//= require jquery_ujs
//= require rdcms/keymaster

// Edição de formulários na sua visualização
//= require best_in_place
//= require jquery-fileupload
//= require jquery.meio.mask

//= require twitter/bootstrap

//= require formstyle
//= require rdcms/chosen.jquery.min

// Color Picker
//= require ./farbtastic

// Slider
//= require slider


// Evitar bug:
// NS_ERROR_XPC_BAD_CONVERT_JS: Could not convert JavaScript argument
jQuery.ajaxSettings.traditional = true;

$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  
  // call setMask function on the document.ready event
  if (!$.browser.chrome)
    $('input[type=text], input[type=password], input[type=email], input[type=number], input[type=url], input[type=tel]')
      .setMask();
});

$(document).ready(function() {
  //Foldable overview in sidebar
  $("div.overview-sidebar div.folder").bind("click", function(){
    $(this).closest('li').find("ul:first").slideToggle();
  });
  $("div.overview-sidebar div.folder").trigger("click");

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


  //die sidebar_section bekommen einen button zum auf und zu klappen
  $('div#sidebar div.sidebar_section h3').prepend("<div class='foldable_icon_wrapper'><div class='foldable_icon'></div></div>")
  $('div#sidebar div.sidebar_section h3').bind("click", function(){
    $(this).closest(".sidebar_section").find(".foldable_icon").toggleClass("open");
    $(this).closest(".sidebar_section").find('.panel_contents').slideToggle();
  });
  $('div#sidebar div.sidebar_section:not(#overview_sidebar_section) h3').trigger("click");
  $('div#sidebar div.sidebar_section .warning').closest("div.sidebar_section").addClass("warning").find("h3").trigger("click");

  $(".chzn-select").chosen();
  $(".chzn-select-deselect").chosen({allow_single_deselect:true});

  //Menuepunkte bekommen eine funktion zum auf und zu klappen
  $('div#overview_sidebar div.title a').bind("click", function(){
    $(this).children("ul").hide();

  });
  $('div#overview_sidebar div.title a').trigger("click");

  // Atalhos de formulários Formulários
  $("#main_content form input:submit").attr("value", $("#main_content form input:submit").attr("value") + " (⌘-S)");
  key('⌘+s, ctrl+s', function(){
    $("#main_content form input:submit").trigger("click");
    return false;
  });
  $("form .form-actions .btn.cancel").append(" (ESC)");
  key('esc', function(){
    target = $("form .form-actions .btn.cancel").attr("href");
    window.location = target;
    return false;
  });

  // Action Items
  $("#title_bar .action_items a[href$='new']").append(" (⌘-N)")
  key('⌘+n, ctrl+n', function(){
    target = $("#title_bar .action_items a[href$='new']").attr("href");
    window.location = target;
    return false;
  });

  $("#title_bar .action_items a[href$='edit']").append(" (⌘-E)")
  key('⌘+e, ctrl+e', function(){
    target = $("#title_bar .action_items a[href$='edit']").attr("href");
    window.location = target;
    return false;
  });

  $("#title_bar .action_items a[href$='revert']").append(" (⌘-Z)")
  key('⌘+z, ctrl+z', function(){
    target = $("#title_bar .action_items a[href$='revert']").attr("href");
    window.location = target;
    return false;
  });
});

