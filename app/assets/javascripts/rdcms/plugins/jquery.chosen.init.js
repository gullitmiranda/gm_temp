$(document).ready(function() {
  if ($.fn.chosen) {
    $(".chzn-select").chosen();
    $(".chzn-select-deselect").chosen({allow_single_deselect:true});
  }
});
