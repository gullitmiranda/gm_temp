###
@File : rd.social.js
@version : 1.0.0
@description : Criar botões para compartilhamento em redes sociais
@language : PT-BR Charset: UTF-8
@date : Sáb 11 Ago 2012 12:14:16 AMT

@package : RD Library

@author : Gullit Miranda <gullitmiranda@requestdev.com.br>

@copyright © RequestDev Sistemas 2011, all right reserved.
http://www.requestdev.com.br
###
(($) ->
  social =
    defaults:
      gplusone:
        size: "medium"

      facebook:
        # send: true
        layout: "button_count"
        width: 450
        show_faces: true

      twitter:
        href: "https://twitter.com/share"
        class: "twitter-share-button"
        html: "Tweet"
        "data-via": "twitterapi"
        "data-lang": "en"

    init: (obj, options) ->
      self = this
      self.element = obj
      self.options = options = $.extend(true, {}, self.defaults, options)
      $(window).off(".social").on "load.social page:load.social", (ev) ->
        $("head").append "<script type=\"text/javascript\" src=\"https://apis.google.com/js/plusone.js\">\t\t\t\t\t{parsetags: \"explicit\"}\t\t\t\t</script>"  if $(".gplusone:first", self.element).length or options.twitter
        $.getScript "http://platform.twitter.com/widgets.js"  if $(".twitter:first", self.element).length or options.twitter
        if $(".facebook:first", self.element).length or options.facebook
          window.fbAsyncInit = ->
            FB.init
              status: true
              cookie: false
              xfbml: true


          $("body").append "<div id=\"fb-root\"></div>"
          $.getScript "//connect.facebook.net/pt_BR/all.js"
        self.element.each (i, el) ->
          $t = $(this)
          url = $t.data("url")
          $g1 = $(".gplusone", $t)
          $fc = $(".facebook", $t)
          $tt = $(".twitter", $t)
          if $g1.length or options.gplusone
            $el = $("<g:plusone />").attr($.extend(true, options.gplusone, $g1.data(),
              href: url
            ))
            (if $g1.length then $g1.replaceWith($el) else $t.append($el))
            window.gapi and gapi.plusone.go()
          if $tt.length or options.twitter
            $el = $("<a />").attr($.extend(true, options.twitter, $tt.data(),
              "data-url": url
            ))
            (if $tt.length then $tt.replaceWith($el) else $t.append($el))
          if $fc.length or options.facebook
            $el = $("<fb:like />").attr($.extend(true, options.facebook, $fc.data(),
              href: url
            ))
            (if $fc.length then $fc.replaceWith($el) else $t.append($el))
            window.FB and FB.XFBML.parse()


      self

  $.fn.social = (options) ->
    social.init this, options
) jQuery