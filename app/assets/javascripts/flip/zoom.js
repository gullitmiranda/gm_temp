/* turn.js 4.1.0 | Copyright (c) 2012 Emmanuel Garcia | turnjs.com | turnjs.com/license.txt */
(function (f) {
  function q(a, b) {
    return a[0] == b[0] ? !1 : a.attr("page") ? !0 : a.parent()[0] ? q(a.parent(), b) : !1
  }
  function t(a) {
    function b(a) {
      this.name = "TurnJsError";
      this.message = a
    }
    b.prototype = Error();
    b.prototype.constructor = b;
    return new b(a)
  }
  function s(a, b, d) {
    return p && d ? " translate3d(" + a + "px," + b + "px, 0px) " : " translate(" + a + "px, " + b + "px) "
  }
  function u(a, b) {
    return p && b ? " scale3d(" + a + ", " + a + ", 1) " : " scale(" + a + ") "
  }
  function h(a, b) {
    return {
      x: a,
      y: b
    }
  }
  function m(a, b) {
    return function () {
      return a.apply(b, arguments)
    }
  }
  var p,
  v = {
    max: 2,
    flipbook: null,
    easeFunction: "ease-in-out",
    duration: 500,
    when: {}
  }, j = {
    init: function (a) {
      var b = this,
        d = this.data(),
        a = f.extend({}, v, a);
      if (!a.flipbook || !a.flipbook.turn("is")) throw t("options.flipbook is required");
      p = "WebKitCSSMatrix" in window || "MozPerspective" in document.body.style;
      if ("function" != typeof a.max) {
        var e = a.max;
        a.max = function () {
          return e
        }
      }
      d.zoom = {
        opts: a,
        axis: h(0, 0),
        scrollPos: h(0, 0),
        eventQueue: [],
        mouseupEvent: function () {
          return j._eMouseUp.apply(b, arguments)
        },
        eventTouchStart: m(j._eTouchStart,
        b),
        eventTouchMove: m(j._eTouchMove, b),
        eventTouchEnd: m(j._eTouchEnd, b),
        flipbookEvents: {
          zooming: m(j._eZoom, b),
          pressed: m(j._ePressed, b),
          released: m(j._eReleased, b),
          start: m(j._eStart, b),
          turning: m(j._eTurning, b),
          turned: m(j._eTurned, b),
          destroying: m(j._eDestroying, b)
        }
      };
      for (var c in a.when) Object.prototype.hasOwnProperty.call(a.when, c) && this.bind("zoom." + c, a.when[c]);
      for (c in d.zoom.flipbookEvents) Object.prototype.hasOwnProperty.call(d.zoom.flipbookEvents, c) && a.flipbook.bind(c, d.zoom.flipbookEvents[c]);
      this.css({
        position: "relative",
        overflow: "hidden"
      });
      f.isTouch ? (a.flipbook.bind("touchstart", d.zoom.eventTouchStart).bind("touchmove", d.zoom.eventTouchMove).bind("touchend", d.zoom.eventTouchEnd), this.bind("touchstart", j._tap)) : this.mousedown(j._mousedown).click(j._tap)
    },
    _tap: function (a) {
      var b = f(this),
        d = b.data().zoom;
      !d.draggingCorner && !d.dragging && q(f(a.target), b) && (j._addEvent.call(b, "tap", a), (a = j._eventSeq.call(b)) && b.trigger(a))
    },
    _addEvent: function (a, b) {
      var d = this.data().zoom,
        e = (new Date).getTime();
      d.eventQueue.push({
        name: a,
        timestamp: e,
        event: b
      });
      10 < d.eventQueue.length && d.eventQueue.splice(0, 1)
    },
    _eventSeq: function () {
      var a = this.data().zoom.eventQueue,
        b = a.length - 1;
      if (0 < b && "tap" == a[b].name && "tap" == a[b - 1].name && a[b].event.pageX == a[b - 1].event.pageX && a[b].event.pageY == a[b - 1].event.pageY && 200 > a[b].timestamp - a[b - 1].timestamp && 50 < a[b].timestamp - a[b - 1].timestamp) return f.extend(a[b].event, {
        type: "zoom.doubleTap"
      });
      if ("tap" == a[b].name) return f.extend(a[b].event, {
        type: "zoom.tap"
      })
    },
    _prepareZoom: function () {
      var a, b = 0,
        d = this.data().zoom,
        e = 1 / this.zoom("value");
      a = d.opts.flipbook;
      var c = a.turn("direction"),
        j = a.data(),
        l = a.offset(),
        i = this.offset(),
        g = {
          height: a.height()
        }, k = a.turn("view");
      "double" == a.turn("display") && a.data().opts.autoCenter ? k[0] ? k[1] ? (g.width = a.width(), a = h(l.left - i.left, l.top - i.top)) : (g.width = a.width() / 2, b = "ltr" == c ? 0 : g.width, a = h("ltr" == c ? l.left - i.left : l.left - i.left + g.width, l.top - i.top)) : (g.width = a.width() / 2, b = "ltr" == c ? g.width : 0, a = h("ltr" == c ? l.left - i.left + g.width : l.left - i.left, l.top - i.top)) : (g.width = a.width(), a = h(l.left - i.left, l.top - i.top));
      d.zoomer || (d.zoomer = f("<div />", {
        "class": "zoomer",
        css: {
          overflow: "hidden",
          position: "absolute",
          zIndex: "1000000"
        }
      }).mousedown(function () {
        return false
      }).appendTo(this));
      d.zoomer.css({
        top: a.y,
        left: a.x,
        width: g.width,
        height: g.height
      });
      c = k.join(",");
      if (c != d.zoomerView) {
        d.zoomerView = c;
        d.zoomer.find("*").remove();
        for (c = 0; c < k.length; c++) if (k[c]) {
          var i = j.pageObjs[k[c]].offset(),
            m = f(j.pageObjs[k[c]]);
          m.clone().transform("").css({
            width: m.width() * e,
            height: m.height() * e,
            position: "absolute",
            display: "",
            top: (i.top - l.top) * e,
            left: (i.left - l.left - b) * e
          }).appendTo(d.zoomer)
        }
      }
      return {
        pos: a,
        size: g
      }
    },
    value: function () {
      return this.data().zoom.opts.flipbook.turn("zoom")
    },
    zoomIn: function (a) {
      var b = this,
        d = this.data().zoom,
        e = d.opts.flipbook,
        c = d.opts.max();
      e.offset();
      var r = this.offset();
      if (d.zoomIn) return this;
      e.turn("stop");
      var l = f.Event("zoom.change");
      this.trigger(l, [c]);
      if (l.isDefaultPrevented()) return this;
      var i = j._prepareZoom.call(this),
        g = i.pos,
        k = h(i.size.width / 2, i.size.height / 2),
        l = f.cssPrefix(),
        m = f.cssTransitionEnd(),
        p = e.data().opts.autoCenter;
      d.scale = c;
      e.data().noCenter = !0;
      a = "undefined" != typeof a ? "x" in a && "y" in a ? h(a.x - g.x, a.y - g.y) : f.isTouch ? h(a.originalEvent.touches[0].pageX - g.x - r.left, a.originalEvent.touches[0].pageY - g.y - r.top) : h(a.pageX - g.x - r.left, a.pageY - g.y - r.top) : h(k.x, k.y);
      if (0 > a.x || 0 > a.y || a.x > i.width || a.y > i.height) a.x = k.x, a.y = k.y;
      var n = h((a.x - k.x) * c + k.x, (a.y - k.y) * c + k.y),
        a = h(i.size.width * c > this.width() ? a.x - n.x : 0, i.size.height * c > this.height() ? a.y - n.y : 0),
        n = h(Math.abs(i.size.width * c - this.width()), Math.abs(i.size.height * c - this.height())),
        i = h(Math.min(0, i.size.width * c - this.width()), Math.min(0, i.size.height * c - this.height())),
        o = h(k.x * c - k.x - g.x - a.x, k.y * c - k.y - g.y - a.y);
      o.y > n.y ? a.y = o.y - n.y + a.y : o.y < i.y && (a.y = o.y - i.y + a.y);
      o.x > n.x ? a.x = o.x - n.x + a.x : o.x < i.x && (a.x = o.x - i.x + a.x);
      o = h(k.x * c - k.x - g.x - a.x, k.y * c - k.y - g.y - a.y);
      g = {};
      g[l + "transition"] = l + "transform " + d.opts.easeFunction + " " + d.opts.duration + "ms";
      var q = function () {
        b.trigger("zoom.zoomIn");
        d.zoomIn = true;
        d.flipPosition = h(e.css("left"), e.css("top"));
        e.turn("zoom", c).css({
          position: "absolute",
          margin: "",
          top: 0,
          left: 0
        });
        var a = e.offset();
        d.axis = h(a.left - r.left, a.top - r.top);
        if (p && e.turn("display") == "double" && (e.turn("direction") == "ltr" && !e.turn("view")[0] || e.turn("direction") == "rtl" && !e.turn("view")[1])) d.axis.x = d.axis.x + e.width() / 2;
        b.zoom("scroll", o);
        b.bind(f.mouseEvents.down, j._eMouseDown);
        b.bind(f.mouseEvents.move, j._eMouseMove);
        f(document).bind(f.mouseEvents.up, d.mouseupEvent);
        b.bind("mousewheel", j._eMouseWheel);
        setTimeout(function () {
          d.zoomer.hide();
          d.zoomer.remove();
          d.zoomer = null;
          d.zoomerView = null
        },
        50)
      };
      d.zoomer.css(g).show();
      m ? d.zoomer.bind(m, function () {
        f(this).unbind(m);
        q()
      }) : setTimeout(q, d.opts.duration);
      d.zoomer.transform(s(a.x, a.y, !0) + u(c, !0));
      return this
    },
    zoomOut: function (a) {
      var b, d = this,
        e = this.data().zoom,
        c = e.opts.flipbook,
        m = 1 / e.scale,
        l = f.cssPrefix(),
        i = f.cssTransitionEnd();
      b = this.offset();
      a = "undefined" != typeof a ? a : e.opts.duration;
      if (e.zoomIn) {
        var g = f.Event("zoom.change");
        this.trigger(g, [1]);
        if (g.isDefaultPrevented()) return this;
        e.zoomIn = !1;
        e.scale = 1;
        c.data().noCenter = !1;
        d.unbind(f.mouseEvents.down,
        j._eMouseDown);
        d.unbind(f.mouseEvents.move, j._eMouseMove);
        f(document).unbind(f.mouseEvents.up, e.mouseupEvent);
        d.unbind("mousewheel", j._eMouseWheel);
        g = {};
        g[l + "transition"] = l + "transform " + e.opts.easeFunction + " " + a + "ms";
        c.css(g);
        var k = f("<div />", {
          css: {
            position: "relative",
            top: e.flipPosition.y,
            left: e.flipPosition.x,
            width: c.width() * m,
            height: c.height() * m,
            background: "blue"
          }
        }).appendTo(c.parent()),
          g = h(k.offset().left - b.left, k.offset().top - b.top);
        k.remove();
        var p = c.data().opts.autoCenter;
        p && "double" == c.turn("display") && (c.turn("view")[0] ? c.turn("view")[1] || (g.x = "ltr" == c.turn("direction") ? g.x + k.width() / 4 : g.x - k.width() / 4) : g.x = "ltr" == c.turn("direction") ? g.x - k.width() / 4 : g.x + k.width() / 4);
        var q = f.findPos(c[0]);
        b = h(-c.width() / 2 - q.left + k.width() / 2 + g.x + b.left, -c.height() / 2 - q.top + k.height() / 2 + g.y + b.top);
        var n = function () {
          if (c[0].style.removeProperty) {
            c[0].style.removeProperty(l + "transition");
            c.transform(c.turn("options").acceleration ? s(0, 0, true) : "").turn("zoom", 1);
            c[0].style.removeProperty("margin");
            c.css({
              position: "relative",
              top: e.flipPosition.y,
              left: e.flipPosition.x
            })
          } else c.transform("none").turn("zoom", 1).css({
            margin: "",
            top: e.flipPosition.y,
            left: e.flipPosition.x,
            position: "relative"
          });
          p && c.turn("center");
          d.trigger("zoom.zoomOut")
        };
        0 === a ? n() : (i ? c.bind(i, function () {
          f(this).unbind(i);
          n()
        }) : setTimeout(n, a), c.transform(s(b.x, b.y, !0) + u(m, !0)));
        return this
      }
    },
    flipbookWidth: function () {
      var a = this.data().zoom.opts.flipbook,
        b = a.turn("view");
      return "double" == a.turn("display") && (!b[0] || !b[1]) ? a.width() / 2 : a.width()
    },
    scroll: function (a,
    b, d) {
      var e = this.data().zoom,
        c = e.opts.flipbook,
        j = this.zoom("flipbookWidth"),
        l = f.cssPrefix();
      if (p) {
        var i = {};
        i[l + "transition"] = d ? l + "transform 200ms" : "none";
        c.css(i);
        c.transform(s(-e.axis.x - a.x, -e.axis.y - a.y, !0))
      } else c.css({
        top: -e.axis.y - a.y,
        left: -e.axis.x - a.x
      });
      if (!b) {
        var g, b = h(Math.min(0, (j - this.width()) / 2), Math.min(0, (c.height() - this.height()) / 2)),
          c = h(j > this.width() ? j - this.width() : (j - this.width()) / 2, c.height() > this.height() ? c.height() - this.height() : (c.height() - this.height()) / 2);
        a.y < b.y ? (a.y = b.y, g = !0) : a.y > c.y && (a.y = c.y, g = !0);
        a.x < b.x ? (a.x = b.x, g = !0) : a.x > c.x && (a.x = c.x, g = !0);
        g && this.zoom("scroll", a, !0, !0)
      }
      e.scrollPos = h(a.x, a.y)
    },
    resize: function () {
      var a = this.data().zoom,
        b = a.opts.flipbook;
      if (1 < this.zoom("value")) {
        var d = b.offset(),
          e = this.offset();
        a.axis = h(d.left - e.left + (a.axis.x + a.scrollPos.x), d.top - e.top + (a.axis.y + a.scrollPos.y));
        "double" == b.turn("display") && ("ltr" == b.turn("direction") && !b.turn("view")[0]) && (a.axis.x += b.width() / 2);
        this.zoom("scroll", a.scrollPos)
      }
    },
    _eZoom: function () {
      for (var a = this.data().zoom,
      b = a.opts.flipbook, d = b.turn("view"), e = 0; e < d.length; e++) d[e] && this.trigger("zoom.resize", [a.scale, d[e], b.data().pageObjs[d[e]]])
    },
    _eStart: function (a) {
      1 != this.zoom("value") && a.preventDefault()
    },
    _eTurning: function (a, b, d) {
      var e = this,
        a = this.zoom("value"),
        c = this.data().zoom,
        b = c.opts.flipbook;
      c.page = b.turn("page");
      if (1 != a) {
        for (c = 0; c < d.length; c++) d[c] && this.trigger("zoom.resize", [a, d[c], b.data().pageObjs[d[c]]]);
        setTimeout(function () {
          e.zoom("resize")
        }, 0)
      }
    },
    _eTurned: function (a, b) {
      if (1 != this.zoom("value")) {
        var d = this.data().zoom,
          e = d.opts.flipbook;
        b > d.page ? this.zoom("scroll", h(0, d.scrollPos.y), !1, !0) : b < d.page && this.zoom("scroll", h(e.width(), d.scrollPos.y), !1, !0)
      }
    },
    _ePressed: function () {
      f(this).data().zoom.draggingCorner = !0
    },
    _eReleased: function () {
      var a = f(this).data().zoom;
      setTimeout(function () {
        a.draggingCorner = !1
      }, 1)
    },
    _eMouseDown: function (a) {
      f(this).data().zoom.draggingCur = f.isTouch ? h(a.originalEvent.touches[0].pageX, a.originalEvent.touches[0].pageY) : h(a.pageX, a.pageY);
      return !1
    },
    _eMouseMove: function (a) {
      var b = f(this).data().zoom;
      if (b.draggingCur) {
        b.dragging = !0;
        var a = f.isTouch ? h(a.originalEvent.touches[0].pageX, a.originalEvent.touches[0].pageY) : h(a.pageX, a.pageY),
          d = h(a.x - b.draggingCur.x, a.y - b.draggingCur.y);
        f(this).zoom("scroll", h(b.scrollPos.x - d.x, b.scrollPos.y - d.y), !0);
        b.draggingCur = a;
        return !1
      }
    },
    _eMouseUp: function () {
      var a = f(this).data().zoom;
      a.dragging && f(this).zoom("scroll", a.scrollPos);
      a.draggingCur = null;
      setTimeout(function () {
        a.dragging = !1
      }, 1)
    },
    _eMouseWheel: function (a, b, d, e) {
      a = f(this).data().zoom;
      d = h(a.scrollPos.x + 10 * d, a.scrollPos.y - 10 * e);
      f(this).zoom("scroll", d, !1, !0)
    },
    _eTouchStart: function (a) {
      var b = f(this).data().zoom,
        a = h(a.originalEvent.touches[0].pageX, a.originalEvent.touches[0].pageY);
      b.touch = {};
      b.touch.initial = a;
      b.touch.last = a;
      b.touch.timestamp = (new Date).getTime();
      b.touch.speed = h(0, 0)
    },
    _eTouchMove: function (a) {
      var b = f(this).data().zoom,
        d = f(this).zoom("value"),
        e = b.opts.flipbook,
        c = (new Date).getTime(),
        a = h(a.originalEvent.touches[0].pageX, a.originalEvent.touches[0].pageY);
      b.touch && (1 == d && !e.data().mouseAction) && (b.touch.motion = h(a.x - b.touch.last.x, a.y - b.touch.last.y), b.touch.speed.x = 0 === b.touch.speed.x ? b.touch.motion.x / (c - b.touch.timestamp) : (b.touch.speed.x + b.touch.motion.x / (c - b.touch.timestamp)) / 2, b.touch.last = a, b.touch.timestamp = c)
    },
    _eTouchEnd: function () {
      var a = f(this).data().zoom;
      if (a.touch && 1 == f(this).zoom("value")) {
        var b = Math.abs(a.touch.initial.y - a.touch.last.y);
        50 > b && (-1 > a.touch.speed.x || -100 > a.touch.last.x - a.touch.initial.x) ? this.trigger("zoom.swipeLeft") : 50 > b && (1 < a.touch.speed.x || 100 < a.touch.last.x - a.touch.initial.x) && this.trigger("zoom.swipeRight")
      }
    },
    _eDestroying: function () {
      var a = this,
        b = this.data().zoom,
        d = b.opts.flipbook;
      this.zoom("zoomOut", 0);
      f.each("tap doubleTap resize zoomIn zoomOut swipeLeft swipeRight".split(" "), function (b, d) {
        a.unbind("zoom." + d)
      });
      for (var e in b.flipbookEvents) Object.prototype.hasOwnProperty.call(b.flipbookEvents, e) && d.unbind(e, b.flipbookEvents[e]);
      d.unbind("touchstart", b.eventTouchStart).unbind("touchmove", b.eventTouchMove).unbind("touchend", b.eventTouchEnd);
      this.unbind("touchstart", j._tap).unbind("click", j._tap);
      b = null;
      this.data().zoom = null
    }
  };
  f.extend(f.fn, {
    zoom: function () {
      var a = arguments;
      if (!a[0] || "object" == typeof a[0]) return j.init.apply(f(this[0]), a);
      if (j[a[0]]) return j[a[0]].apply(f(this[0]), Array.prototype.slice.call(a, 1));
      throw t(a[0] + " is not a method");
    }
  })
})(jQuery);