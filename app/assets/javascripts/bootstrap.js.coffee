$.loadBootstrap = ->
  tooltip_options =
    placement: "bottom"

  $("*[rel=popover]").popover(tooltip_options)
  $("*[rel=tooltip], .tooltip").tooltip(tooltip_options)

  return true

jQuery ->
  $.loadBootstrap()
