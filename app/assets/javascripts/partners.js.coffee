jQuery ->
  #### Selectores
  partners_container      = $('.fileuploads-container')
  file_selector           = $('#file_selector', partners_container)
  auto_save               = $('#auto_save', file_selector)
  auto_save_checkbox      = $(':checkbox', auto_save)
  fileupload_form         = $('#fileupload:first'     , partners_container)
  upload_container_ul     = $('#upload_container ul:first'  , partners_container)
  action                  = file_selector.prop('action') || file_selector.prop('href')
  #### end Selectores

  # Core Functions
  # renderFiles - Renderiza os itens
  renderFiles = (data = {}, container = $(), offset) ->
    template  = $(tmpl "template-download", files: data)

    if container.children().length
      template.each () ->
        _t = $(this)
        _r = container.find("##{this.id}")

        if _r.length
          _r.replaceWith _t
        else
          container.append _t
          _savePositions()
    else
      container.append template

    container.children().addClass('in')
    _sortable(container).data()

  # Renderiza o formulário de edição.
  _renderEdit = (ev) ->
    ev.preventDefault()
    currentTarget   = $(ev.currentTarget)
    delegateTarget  = $(ev.delegateTarget)
    viewPort        = _checkOrCreateViewPort()
    container       = $('.container:first', viewPort)
    overlayItem     = $('<div class="row overlay-item"></div>')

    overlayItem.load currentTarget.prop('href'), () ->
      _t = $(this)

      overlay_form = $('form', _t)
        .bind "submit", (ev) ->
          ev.preventDefault()
        .bind "ajax:complete", (ev, data) ->
          jData = eval("(#{data.responseText})")
          renderFiles [jData], upload_container_ul
          _checkAndDestroyViewPort($(this))

      cancel = $('.btn.cancel', overlay_form).bind "click", (ev) ->
        ev.preventDefault()
        _checkAndDestroyViewPort($(this))

    .appendTo(container)

  # caso a viewPort não exista cria
  _checkOrCreateViewPort = ->
    viewPort = $('body .page_edit_viewport')
    viewPort = if viewPort.length then viewPort else $("""
      <div class="page_edit_viewport fade in overlay-viewport">
        <div class="overlay-block overlay-white"></div>
        <div class="page_edit_container overlay-container"><div class="container"></div></div>
      </div>
""").appendTo($("body").css("overflow", "hidden"))
  _checkAndDestroyViewPort = (_4remove)->
    _4remove = $(_4remove)
    _4remove.closest('.overlay-item').remove() if _4remove.length

    viewPort = $('body .page_edit_viewport')
    containerItens = $('.overlay-item', viewPort)
    if viewPort.length and !containerItens.length
      viewPort.removeClass('in').remove()
      $('body').css("overflow", "")

  # _sortable - Jquery UI para ordenação de itens
  _sortable = (container) ->
    container.sortable('destroy') if container.data("sortable")

    container
      .sortable
        handle: ".det.header"
        # placeholder: "ui-state-highlight ui-sortable-placeholder template-download span3 fade in"
        opacity: 0.6
        revert: true
        stop: (ev, ui) ->
          _savePositions()
      .disableSelection()

  # Grava a ordenação no DB
  _savePositions = () ->
    $(".ids_order", file_selector).remove()
    ids_order = $(".ids_order", fileupload_form).clone().appendTo(file_selector)
    file_selector.submit()

  #### end Core Functions

  # Renderiza os itens carregados do Banco de dados
  selectedData = upload_container_ul.data('load')
  if selectedData && selectedData.length
    renderFiles selectedData, upload_container_ul, 0
  else
    _sortable upload_container_ul
  partners_itens = $('li', upload_container_ul)
  # Callbacks
  fileupload_form
    .bind "fileuploadcompleted", (e, data) ->
      _savePositions()

  partners_itens.on "click.edit_partner", ".edit .btn", _renderEdit
  # end Callbacks
