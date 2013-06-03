jQuery ->
  # Configurações do formStyle
  $.formStyle = 
    defaults: 
      version: "0.1"
      
      # defaults para checkbox
      checkbox:
        wrap: '<div />'
        class:
          checked: ['', 'icon-checkmark']
          unchecked: ['', 'icon-close']
        class_rel:
          checked: ['btn-inverse', 'icon-checked']
          partial: ['btn-inverse', 'icon-partial']
          unchecked: ['btn-inverse', 'icon-unchecked']
        label: false
        collection: null
  
  # Personalização de checkbox
  $.fn.checkbox = (options, rel) ->
    $(this).each (args) ->
      _t = $ this
      rel = if rel then $(rel) else _t.data('rel')
      options = $.extend true, {}, $.formStyle.defaults.checkbox, options
      _class = if rel then options.class_rel else options.class
    
      wrap = _t.wrap($(options.wrap).addClass('fs-checkbox')).parent('.fs-checkbox')
      ipt = (if _t.attr('type') == 'checkbox' then _t else $(':checkbox', _t)).hide().addClass('fs-checkbox-input')
      stat = if ipt.attr('checked') and ipt.prop('checked') then 'checked' else 'unchecked'
      ico = $("<i class='#{_class[stat][1]}'></i>").prependTo(wrap)
      
      ipt.data('fs-checkbox', { rel: rel, options: options, class: _class, status: stat })
      
      wrap
        .addClass(_class[stat][0])
        .on 'click', (ev) ->
          ev.preventDefault()
          _this = $(this)
          ipt = $('.fs-checkbox-input', _this)
          ico = $('i:first', _this)
          iData = ipt.data('fs-checkbox')
          rel = iData.rel
          
          cs =
            addico : []
            addobj : []
            remico : []
            remobj : []
          
          $.each iData.class, (k,v) ->
            if iData.status != k
              cs.addobj.push v[0]
              cs.addico.push v[1]
            else
              cs.remobj.push v[0]
              cs.remico.push v[1]
          
          _this .removeClass(cs.remobj.join(' ')).addClass(cs.addobj.join(' '))
          ico   .removeClass(cs.remico.join(' ')).addClass(cs.addico.join(' '))
          
          if iData.status == 'checked'
            ipt.removeAttr('checked')
            iData.status = 'unchecked'
          else
            ipt.attr('checked', 'checked')
            iData.status = 'checked'
          
          ipt.data 'fs-checkbox', iData
  # End checkbox