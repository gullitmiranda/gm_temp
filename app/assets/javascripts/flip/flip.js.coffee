#
# Make Flip
#
jQuery ->
  makeFlip =
    _id: 0
    labels:
      index: "Índice"
      zoom: "Ampliar/Reduzir"
      back_page: "Página anterior"
      next_page: "Próxima página"
      save: "Salvar"
    defaults:
      # Container das páginas
      flipbook: ".flipbook-container"

      # Controles de navegação (avançar e voltar)
      controls: true

      # Container dos botões da navegação
      navBarContainer: ".navbar:first > .navbar-inner > .container"

      # Placemment dos tooltips
      data_placement: "bottom"

      # URL para download
      download_url: null

      # Turn.js opções
      turn:
        # Magazine width
        width: 1920*2
        # Magazine height
        height: 1200
        # Elevation will move the peeling corner this number of pixels by default
        elevation: 50
        # Hardware acceleration
        acceleration: not $.browser.chrome
        # Enables gradients
        gradients: true
        # Auto center this flipbook
        autoCenter: true
        # Sets the duration of the transition in milliseconds [Default: 600]
        duration: 1500
        # Sets event listeners
        when:
          turning: (e, page, view) ->
            book        = $(this)
            currentPage = book.turn("page")
            pages       = book.turn("pages")

            # Update the current URI
            Hash.go("page/" + page).update()

            # Atualizar Depth
            makeFlip.updateDepth book
            # Exibe e oculta controladores
            makeFlip.disableControls book, page
          turned: (e, page, view) ->
            book = $(this)
            pages = book.turn("pages")

            # Atualizar Depth
            makeFlip.updateDepth book
            # Exibe e oculta controladores
            makeFlip.disableControls book, page
            # Barra de Rolagem
            # $("#slider", book).slider "value", makeFlip.getViewNumber(book, page)
            # Centraliza slider
            book.turn "center"
          start: (e, pageObj, corner) ->
            makeFlip.moveBar true
          end: (e, pageObj) ->
            book = $(this)
            # Atualizar Depth
            makeFlip.updateDepth book
            # Barra de Rolagem
            # setTimeout (->
            #   $("#slider", book).slider "value", makeFlip.getViewNumber(book)
            # ), 1
            makeFlip.moveBar false

      # Zoom opções
      zoom: {}

    # Atualiza Depth
    updateDepth: (book, newPage) ->
      page        = book.turn("page")
      pages       = book.turn("pages")
      depthWidth  = 16 * Math.min(1, page * 2 / pages)
      depth_start = $(".depth_start .depth", book)
      depth_end   = $(".depth_end .depth", book)

      newPage = newPage or page
      if newPage > 3
        depth_start.css
          width: depthWidth
          left: 20 - depthWidth

      else
        depth_start.css width: 0
      depthWidth = 16 * Math.min(1, (pages - page) * 2 / pages)
      if newPage < pages - 3
        depth_end.css
          width: depthWidth
          right: 20 - depthWidth

      else
        depth_end.css width: 0

    # Set the width and height for the viewport
    resizeViewport: ->
      self = this

      $(".flipbook-container").each ->
        _t = $(this)
        _v = _t.closest(".flipbook-viewport")
        _p = _v.parent()
        options = _t.turn("options")
        options.controls = _t.hasClass("controls-appended")

        _t.removeClass "animated"

        width = _p.innerWidth() or _p.width()
        height = _p.innerHeight() or _p.height()
        _v.css(
          width: width
          height: height
        )
        # ).zoom "resize"
        # Lagura dos botões de next e previous
        cWidth = if options.controls then 38*2 else 0

        if _t.turn("zoom") is 1
          bound = self.calculateBound(
            width: options.width
            height: options.height
            boundWidth: Math.min(options.width, width)
            boundHeight: Math.min(options.height, height)
          )

          bound.width -= 1  if bound.width % 2 isnt 0

          if bound.width isnt _t.width() or bound.height isnt _t.height()
            _t.turn "size", bound.width, bound.height
            _t.turn "peel", "br"  if _t.turn("page") is 1
            $(".next-button").css
              height: bound.height
              backgroundPosition: "-38px " + (bound.height / 2 - 32 / 2) + "px"

            $(".previous-button").css
              height: bound.height
              backgroundPosition: "-4px " + (bound.height / 2 - 32 / 2) + "px"

          _t.css
            top: -bound.height / 2
            left: -bound.width / 2

        _t.addClass "animated"

      return self

      magazineOffset = _t.offset()
      boundH = height - magazineOffset.top - _t.height()
      marginTop = (boundH - $(".thumbnails > div").height()) / 2
      if marginTop < 0
        $(".thumbnails").css height: 1
      else
        $(".thumbnails").css height: boundH
        $(".thumbnails > div").css marginTop: marginTop
      if magazineOffset.top < $(".made").height()
        $(".made").hide()
      else
        $(".made").show()

    # Calculate the width and height of a square within another square
    calculateBound: (d) ->
      bound =
        width: d.width
        height: d.height

      if bound.width > d.boundWidth or bound.height > d.boundHeight
        rel = bound.width / bound.height
        if d.boundWidth / rel > d.boundHeight and d.boundHeight * rel <= d.boundWidth
          bound.width = Math.round(d.boundHeight * rel)
          bound.height = d.boundHeight
        else
          bound.width = d.boundWidth
          bound.height = Math.round(d.boundWidth / rel)
      bound

    # Exibe e oculta controles
    disableControls: (book, page) ->
      _t = this.element
      btn_next      = $(".rtArrowRight", book)
      btn_previous  = $(".rtArrowLeft", book)

      if _t.data("zoom") and _t.zoom("value") isnt 1
        btn_previous.hide()
        btn_next.hide()
      else if page
        if page is 1
          btn_previous.hide()
        else
          btn_previous.show()
        if page is book.turn("pages")
          btn_next.hide()
        else
          btn_next.show()

    # Puxa número da visualização
    getViewNumber: (book, page) ->
      parseInt((page || book.turn('page'))/2 + 1, 10);

    # Esta função está aqui apenas por um motivo.
    # Corrige o bug do cursor de posição z-index resultado da combinação de posição relativa / absoluta, z-index e transformações
    moveBar: (yes_) ->
      $("#slider .ui-slider-handle").css zIndex: (if yes_ then -1 else 0)  if Modernizr.csstransforms

    _createNavBar: ->
      self = this
      options = self.options

      _t = self.element
      _f = $(options.flipbook, _t)

      navBar = $(".BtnNavContainer", options.navBarContainer)
      navBar = $("""<div class="BtnNavContainer"></div>""").appendTo(options.navBarContainer) unless navBar.length

      index_ul = ""

      navControllers = """
          <div class="dropdown fade dpIndex">
            <a class="BigButton btnIndex dropdown-toggle" data-toggle="dropdown" href="#" rel="tooltip" title="#{self.labels.index}" data-placement="#{options.data_placement}" ><span class="icon-list-4" aria-hidden="true"></span></a>
          </div>

          <div class="BigButton fade btnZoom" rel="tooltip" title="#{self.labels.zoom}" data-placement="#{options.data_placement}" ><span class="icon-zoom-in" aria-hidden="true"></span></div>

          <div class="barControls fade zoomedControllers">
            <div class="BigButton btnPrevious " rel="tooltip" title="#{self.labels.back_page}" data-placement="#{options.data_placement}" ><span class="icon-arrow-left-3" aria-hidden="true"></span></div>
            <div class="BigButton btnNext"      rel="tooltip" title="#{self.labels.next_page}" data-placement="#{options.data_placement}" ><span class="icon-arrow-right-3" aria-hidden="true"></span></div>
          </div>

          <a class="BigButton fade btnDownload" rel="tooltip" title="#{self.labels.save}" target="_blank" data-placement="#{options.data_placement}" ><span class="icon-download" aria-hidden="true"></span></a>
        """

      navBigButtons = navBar.append(navControllers).find(".BigButton")
      dpIndex = $(".dpIndex", navBar).addClass("in")
      index_ul = $(".flipbook-index", _t).appendTo(dpIndex)
      btnIndex = $(".btnIndex", dpIndex)

      # Recarrega as core functions do twitter bootstrap
      $.loadBootstrap()
      # Recarrega os tooltips do indice
      $("a[rel=tooltip], .tooltip", index_ul).tooltip("destroy").tooltip placement: options.data_placement


      # Caso exista a back_url define o endereço e exibe o botão
      btDownload = $(".btnDownload", navBar).attr("href", options.download_url).addClass("in") if options.download_url

      if options.zoom
        btZoom = $(".btnZoom", navBar)
          .addClass("in")
          .click ->
            if _t.zoom("value") is 1
              _t.zoom("zoomIn")
            else
              _t.zoom("zoomOut")

      if options.controls
        btControls = $(".barControls", navBar)
          # .addClass("in")
          .find(".btnPrevious")
            .click ->
              _f.turn "previous"
          .end()
          .find(".btnNext")
            .click ->
              _f.turn "next"
          .end()

    # inicializa plugin
    init: (obj, options) ->
      self = this
      self.element = obj
      self.options = options = $.extend(true, {}, self.defaults, options)
      self.labels  = $.extend(true, self.labels, makeFlip_labels) if makeFlip_labels

      self.element.each ->
        _t = $(this).addClass("flipbook-viewport")
        _f = $(options.flipbook, _t).addClass("flipbook-#{self._id++} flipbook-container")

        if options.controls
          _f.addClass("controls-appended").prepend("""
            <div class="rtArrow rtArrowLeft"  ignore="1" ><div class="rtArrowIcn"></div></div>
            <div class="rtArrow rtArrowRight" ignore="1" ><div class="rtArrowIcn"></div></div>
          """)

          # Events for the next button
          btn_next  = $(".rtArrowRight", _f).bind($.mouseEvents.over, ->
            $(this).addClass "hover"
          ).bind($.mouseEvents.out, ->
            $(this).removeClass "hover"
          ).bind($.mouseEvents.down, ->
            $(this).addClass "down"
          ).bind($.mouseEvents.up, ->
            $(this).removeClass "down"
          ).click ->
            _f.turn "next"

          # Events for the previous button
          btn_previous = $(".rtArrowLeft", _f).bind($.mouseEvents.over, ->
            $(this).addClass "hover"
          ).bind($.mouseEvents.out, ->
            $(this).removeClass "hover"
          ).bind($.mouseEvents.down, ->
            $(this).addClass "down"
          ).bind($.mouseEvents.up, ->
            $(this).removeClass "down"
          ).click ->
            _f.turn "previous"

        # Inicializa flip
        _f.turn options.turn
        _t.addClass('in')

        # Add gradiente e loading
        if options.turn.gradients
          $(".page", _f).append "<div class=\"gradient\"></div>"

        # Zoom
        if self.options.zoom
          self.options.zoom =
            when:
              tap: (event) ->
                zT = $(this)

                if zT.zoom("value") is 1
                  $(".flipbook-container", zT).removeClass("animated").addClass "zoom-in"
                  zT.zoom "zoomIn", event
                else
                  zT.zoom "zoomOut"

              zoomIn: ->
                zT = $(this)
                book = $(".flipbook-container", zT).addClass "zoom-in"
                btnNav = $(".BtnNavContainer")

                $(".zoomedControllers", btnNav).addClass("in")
                $('.btnZoom span', btnNav).removeClass("icon-zoom-in").addClass("icon-zoom-out")

                $('.rtArrow', zT).hide() if self.options.controls

                if not window.escTip and not $.isTouch
                  escTip = true
                  $("<div />",
                    class: "esc"
                  ).html("<div>Press ESC to exit</div>").appendTo($("body")).delay(2000).animate
                    opacity: 0
                  , 500, ->
                    $(this).remove()

              zoomOut: ->
                zT = $(this)
                book = $(".flipbook-container", zT)
                btnNav = $(".BtnNavContainer")

                $(".esc").hide()
                setTimeout (->
                  book.addClass("animated").removeClass "zoom-in"

                  $(".zoomedControllers", btnNav).removeClass("in")
                  $('.btnZoom span', btnNav).removeClass("icon-zoom-out").addClass("icon-zoom-in")

                  $('.rtArrow', zT).show() if self.options.controls

                  self.resizeViewport()
                ), 0

              swipeLeft: ->
                $(".flipbook-container", $(this)).turn "next"

              swipeRight: ->
                $(".flipbook-container", $(this)).turn "previous"

          self.options.zoom = zoom = $.extend(true, {}, self.options.zoom, { flipbook: _f } )

          _t.zoom options.zoom

          # Using arrow key to close zoom
          $(document).keydown (e) ->
            esc = 27
            switch e.keyCode
              # zoom out
              when esc
                _t.zoom "zoomOut"
                e.preventDefault()

        # big fix: botão sobreposto nas bortas laterais
        _t.css "overflow", "inherit"

        # Using arrows keys to close next or previous page
        $(document).keydown (e) ->
          previous = 37
          next = 39
          switch e.keyCode
            # left arrow
            when previous
              _f.turn "previous"
              e.preventDefault()
            #right arrow
            when next
              _f.turn "next"
              e.preventDefault()

        # URIs - Format #/page/1
        Hash.on "^page/([0-9]*)$",
          yep: (path, parts) ->
            page = parts[1]
            _f.turn "page", page  if _f.turn("is")  if page isnt `undefined`

          nop: (path) ->
            _f.turn "page", 1  if _f.turn("is")

        # Redimensionar Viewport quando janela for redimensionada
        $(window).resize(->
          if _t.zoom("value") is 1
            _t.zoom "zoomOut"
          self.resizeViewport()
        ).bind "orientationchange", ->
          if _t.zoom("value") is 1
            _t.zoom "zoomOut"
          self.resizeViewport()
        options.zoom
        self._createNavBar()

        # Redimensiona a Viewport
        self.resizeViewport();

        _f.addClass('animated');

      # Retorna objeto
      self

  $.fn.makeFlip = (options) ->
    makeFlip.init this, options
