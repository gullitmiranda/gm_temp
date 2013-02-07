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
  item_type             = $("#upload_item_type", form).val()
  #### end Selectores

  #### Core Functions
  # getUploads - Puxa listagem de uploads
  getUploads = (options) ->
    options = $.extend
      limit: 20
      offset: 0
      order: "upload_file_name"
      item_type: item_type
    , fileUploadsHashOptions, options, gallery_container_ul.data()

    $.getJSON action, options, (data) =>
      renderFiles data, gallery_container_ul, options.offset
  #end getUploads

  # renderFiles - Renderiza os itens
  renderFiles = (data = {}, container = $(), offset) ->
    template  = tmpl "template-download", files: data

    if container == gallery_container_ul
      $("<div />").append(template).children().each(() ->
        _li = $(this)
        _li.appendTo(container).addClass('in') unless $("##{_li.prop 'id'}", upload_selector).length
      )
    else
      itens = container.append(template).children().addClass('in')

    container.scrollTop(0) if offset == 0
    _sortable(container).data("offset", $(".template-download", gallery_container_ul).length).data()


  _sortable = (container) ->

    container.sortable('destroy') if container.data("sortable")
    container
      .sortable
        handle: ".det.header"
        connectWith: ".connectedSortable"
        # placeholder: "ui-state-highlight ui-sortable-placeholder template-download span3 fade in"
        opacity: 0.6
        revert: true
        stop: ->
          file_selector.submit() if auto_save_checkbox.prop('checked')
      .disableSelection()

  # end _sortable
  #### end Core Functions

  # Renderiza os itens carregados do Banco de dados
  selectedData = selected_container_ul.data('load')
  if selectedData && selectedData.length
    renderFiles selectedData, selected_container_ul, 0
  else
    _sortable selected_container_ul

  # Quando a aba de galeria for selecionada carrega a lista de uploads
  upload_tab.on "click.load_uploads", (ev) ->
    getUploads()

  # Carregamento sobre demanda dos uploads
  gallery_container_ul.scroll (ev) ->
    $t = $(this)
    if $t.scrollTop() + $t.outerHeight() == $t.get(0).scrollHeight
      getUploads()

  # Ações de ordenação
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
        file_selector.submit() if auto_save_checkbox.prop('checked')
      else
        _ref.remove()

  # end Ações de ordenação
