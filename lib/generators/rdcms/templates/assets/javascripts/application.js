//= require jquery
//= require jquery_ujs
//= require jquery.mb.browser

// Validações
//= require rails.validations
//= require_tree ./rails.validations/

// Aparência
//= require twitter/bootstrap
//= require bootstrap

//= require_tree ./plugins/

// Slider
//= require slider

// Evitar bug:
// NS_ERROR_XPC_BAD_CONVERT_JS: Could not convert JavaScript argument
jQuery.ajaxSettings.traditional = true;
