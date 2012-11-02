jQuery ->
  #### Selectores
  upload_selector       = $('#upload-selector')
  file_selector         = $("form#file_selector", upload_selector)
  auto_save             = $('#auto_save')
  auto_save_checkbox    = $(':checkbox', auto_save)
  form                  = $('#fileupload:first'     , upload_selector)
  upload_tab            = $('#upload_tab'           , upload_selector)
  selected_container_ul = $('#selected_container ul:first', upload_selector)
  upload_container_ul   = $('#upload_container ul:first'  , upload_selector)
  gallery_container_ul  = $('#gallery_container ul:first' , upload_selector)
  action                = form.prop('action') || form.prop('href')
  #### end Selectores
  
  #### Core Functions
  # getUploads - Puxa listagem de uploads
  getUploads = (options) ->
    options = $.extend
      limit: 20,
      offset: 0,
      order: "upload_file_name"
    , fileUploadsHashOptions, options, gallery_container_ul.data()
    
    $.getJSON action, options, (data) =>
      renderFiles data, gallery_container_ul, options.offset
  #end getUploads
  
  # renderFiles - Renderiza os itens
  renderFiles = (data = {}, container = $(), offset) ->
    itens     = container.append(tmpl "template-download", files: data).children()
    itens.each(() ->
      _li = $(this)
      _li.remove() if $("##{_li.prop 'id'}", selected_container_ul).length
    ) if container == gallery_container_ul
    itens.addClass('in')
    
    container.scrollTop(0) if offset == 0
    _sortable(container).data("offset", itens.length).data()

  _sortable = (container) ->
    container.sortable
      handle: ".det.header",
      connectWith: ".connectedSortable"
      # placeholder: "ui-state-highlight ui-sortable-placeholder template-download span3 fade in"
      opacity: 0.6
      revert: true
    .disableSelection()
  
  # end _sortable
  _saveSelected = (ev) ->
    ev.preventDefault()
    _t = $(this)
    console.debug selected_container_ul.sortable 'toArray'
    # console.debug $.param(_t)
    # console.debug _t.serializeArray()
  #end renderFiles
  
  #### end Core Functions
  
  # Renderiza os itens carregados do Banco de dados
  selectedData = selected_container_ul.data('load')
  renderFiles selectedData, selected_container_ul, 0  if selectedData && selectedData.length
  
  # Quando a aba de galeria for selecionada carrega a lista de uploads
  upload_tab.on "click.load_uploads", (ev) ->
    getUploads()
  $("#fileupload").bind 'fileuploaddone', (e, data) ->
    console.debug _sortable(upload_container_ul)
    console.debug e, data
  
  # Carregamento sobre demanda dos uploads
  gallery_container_ul.scroll (ev) ->
    $t = $(this)
    if $t.scrollTop() + $t.outerHeight() == $t.get(0).scrollHeight
      getUploads()
  
  # Ações de ordenação
  # file_selector.removeAttr('data-remote').submit (ev) ->
  file_selector.submit _saveSelected
  auto_save.checkbox()
  
  
  upload_selector
    .on 'click.upload_selector', '.add button', (ev) ->
      ev.preventDefault()
      _moveImage(this, selected_container_ul)
    .on 'click.upload_selector', '.remove button', (ev) ->
      ev.preventDefault()
      _moveImage(this, gallery_container_ul)

  _moveImage = (_ref, container) ->
    _ref = $(_ref).closest('.template-download')
    _ref.hide 'scale', () ->
      if !$("##{_ref.prop 'id'}", container).length
        _ref.appendTo(container).show 'scale'
        # console.debug auto_save_checkbox.prop('checked')
        file_selector.submit() if auto_save_checkbox.prop('checked')
      else
        _ref.remove()
      
      
  # end Ações de ordenação
  
  
  # $( "#selectable" ).selectable({
  #   stop: function() {
  #     var result = $( "#select-result" ).empty();
  #     $( ".ui-selected", this ).each(function() {
  #       var index = $( "#selectable li" ).index( this );
  #       result.append( " #" + ( index + 1 ) );
  #     });
  #   }
  # });  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # $(".sortable"   , upload_selector).sortable({ handle: ".det.header" }).disableSelection()
  # tabs.droppable {
  #   accept      : ".connectedSortable li",
  #   hoverClass  : "ui-state-hover",
  #   drop        : (event, ui) ->
  #     $item = $(this)
  #     $list = $(".connectedSortable", $($("a", $item).attr("href")))
  # 
  #     ui.draggable.hide "slow", ->
  #       # upload_selector.tabs "select", tabs.index($item)
  #       chk = $(":checkbox", $(this).appendTo($list).show("slow"))
  #       if $list.hasClass("selected_container")
  #         chk.attr("checked","checked")
  #       else
  #         chk.removeAttr("checked")
  #       
  # }
