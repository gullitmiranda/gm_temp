// jquery.royalslider v9.1.9b
(function(k) {
  function t(b, e) {
    var c = navigator.userAgent.toLowerCase(),
        g = k.browser,
        a = this,
        f = g.webkit;
    c.indexOf("android");
    a.isIPAD = c.match(/(ipad)/);
    for (var d = document.createElement("div").style, i = ["webkit", "Moz", "ms", "O"], h = "", j = 0, m, c = 0; c < i.length; c++) m = i[c], !h && m + "Transform" in d && (h = m), m = m.toLowerCase(), window.requestAnimationFrame || (window.requestAnimationFrame = window[m + "RequestAnimationFrame"], window.cancelAnimationFrame = window[m + "CancelAnimationFrame"] || window[m + "CancelRequestAnimationFrame"]);
    window.requestAnimationFrame || (window.requestAnimationFrame = function(a) {
      var b = (new Date).getTime(),
          c = Math.max(0, 16 - (b - j)),
          d = window.setTimeout(function() {
          a(b + c)
        }, c);
      j = b + c;
      return d
    });
    window.cancelAnimationFrame || (window.cancelAnimationFrame = function(a) {
      clearTimeout(a)
    });
    a.slider = k(b);
    a.ev = k({});
    a._a = k(document);
    a.st = k.extend({}, k.fn.royalSlider.defaults, e);
    a._b = a.st.transitionSpeed;
    if (a.st.allowCSS3 && (!f || a.st.allowCSS3OnWebkit)) c = h + (h ? "T" : "t"), a._c = c + "ransform" in d && c + "ransition" in d, a._c && (a._d = h + (h ? "P" : "p") + "erspective" in d);
    h = h.toLowerCase();
    a._e = "-" + h + "-";
    a._f = "vertical" === a.st.slidesOrientation ? !1 : !0;
    a._g = a._f ? "left" : "top";
    a._h = a._f ? "width" : "height";
    a._i = -1;
    a._j = "fade" === a.st.transitionType ? !1 : !0;
    a._j || (a.st.sliderDrag = !1, a._k = 10);
    a._l = 0;
    a._m = 0;
    k.each(k.rsModules, function(b, c) {
      c.call(a)
    });
    a.slides = [];
    a._n = 0;
    (a.st.slides ? k(a.st.slides) : a.slider.children().detach()).each(function() {
      a._o(this, true)
    });
    a.st.randomizeSlides && a.slides.sort(function() {
      return 0.5 - Math.random()
    });
    a.numSlides = a.slides.length;
    a._p();
    a.st.startSlideId > a.numSlides - 1 && (a.st.startSlideId = a.numSlides - 1);
    a.staticSlideId = a.currSlideId = a._q = a.st.startSlideId;
    a.currSlide = a.slides[a.currSlideId];
    a._r = 0;
    a.slider.addClass((a._f ? "rsHor" : "rsVer") + (a._j ? "" : " rsFade"));
    d = '<div class="rsOverflow"><div class="rsContainer">';
    a.slidesSpacing = a.st.slidesSpacing;
    a._s = (a._f ? a.slider.width() : a.slider.height()) + a.st.slidesSpacing;
    a._t = Boolean(0 < a._u);
    1 >= a.numSlides && (a._v = !1);
    a._w = a._v && a._j ? 2 === a.numSlides ? 1 : 2 : 0;
    a._x = 6 > a.numSlides ? a.numSlides : 6;
    a._y = 0;
    a._z = 0;
    a.slidesJQ = [];
    for (c = 0; c < a.numSlides; c++) a.slidesJQ.push(k('<div style="' + (a._j ? "" : c !== a.currSlideId ? "z-index: 0; display:none; opacity: 0; position: absolute;  left: 0; top: 0;" : "z-index: 0;  position: absolute; left: 0; top: 0;") + '" class="rsSlide "></div>'));
    a.slider.html(d + "</div></div>");
    a._a1 = a.slider.children(".rsOverflow");
    a._b1 = a._a1.children(".rsContainer");
    a._c1 = k('<div class="rsPreloader"></div>');
    c = a._b1.children(".rsSlide");
    a._d1 = a.slidesJQ[a.currSlideId];
    a._e1 = 0;
    "ontouchstart" in window || "createTouch" in document ? (a.hasTouch = !0, a._f1 = "touchstart.rs", a._g1 = "touchmove.rs", a._h1 = "touchend.rs", a._i1 = "touchcancel.rs", a._j1 = 0.5) : (a.hasTouch = !1, a._j1 = 0.2, a.st.sliderDrag && (g.msie || g.opera ? a._k1 = a._l1 = "move" : g.mozilla ? (a._k1 = "-moz-grab", a._l1 = "-moz-grabbing") : f && -1 != navigator.platform.indexOf("Mac") && (a._k1 = "-webkit-grab", a._l1 = "-webkit-grabbing"), a._m1()), a._f1 = "mousedown.rs", a._g1 = "mousemove.rs", a._h1 = "mouseup.rs", a._i1 = "mouseup.rs");
    a._c ? (a._n1 = "transition-property", a._o1 = "transition-duration", a._p1 = "transition-timing-function", a._q1 = a._r1 = a._e + "transform", a._d ? (f && a.slider.addClass("rsWebkit3d"), a._s1 = "translate3d(", a._t1 = "px, ", a._u1 = "px, 0px)") : (a._s1 = "translate(", a._t1 = "px, ", a._u1 = "px)"), a._j) ? a._b1[a._e + a._n1] = a._e + "transform" : (g = {}, g[a._e + a._n1] = "opacity", g[a._e + a._o1] = a.st.transitionSpeed + "ms", g[a._e + a._p1] = a.st.css3easeInOut, c.css(g)) : (a._r1 = "left", a._q1 = "top");
    var l;
    k(window).on("resize.rs", function() {
      l && clearTimeout(l);
      l = setTimeout(function() {
        a.updateSliderSize()
      }, 50)
    });
    a.ev.trigger("rsAfterPropsSetup");
    a.updateSliderSize();
    a.st.keyboardNavEnabled && a._v1();
    a.st.arrowsNavHideOnTouch && a.hasTouch && (a.st.arrowsNav = !1);
    a.st.arrowsNav && (g = a.st.controlsInside ? a._a1 : a.slider, k('<div class="rsArrow rsArrowLeft"><div class="rsArrowIcn"></div></div><div class="rsArrow rsArrowRight"><div class="rsArrowIcn"></div></div>').appendTo(g), a._w1 = g.children(".rsArrowLeft").click(function(b) {
      b.preventDefault();
      a.prev()
    }), a._x1 = g.children(".rsArrowRight").click(function(b) {
      b.preventDefault();
      a.next()
    }), a.st.arrowsNavAutoHide && !a.hasTouch && (a._w1.addClass("rsHidden"), a._x1.addClass("rsHidden"), g.one("mousemove.arrowshover", function() {
      a._w1.removeClass("rsHidden");
      a._x1.removeClass("rsHidden")
    }), g.hover(function() {
      if (!a._y1) {
        a._w1.removeClass("rsHidden");
        a._x1.removeClass("rsHidden")
      }
    }, function() {
      if (!a._y1) {
        a._w1.addClass("rsHidden");
        a._x1.addClass("rsHidden")
      }
    })), a.ev.on("rsOnUpdateNav", function() {
      a._z1()
    }), a._z1());
    a._a2 = !a.hasTouch && a.st.sliderDrag || a.hasTouch && a.st.sliderTouch;
    if (a._a2) a._b1.on(a._f1, function(b) {
      a._b2(b)
    });
    else a.dragSuccess = !1;
    var q = ["rsPlayBtnIcon", "rsPlayBtn", "rsCloseVideoBtn", "rsCloseVideoIcn"];
    a._b1.click(function(b) {
      if (!a.dragSuccess) {
        var c = k(b.target).attr("class");
        if (k.inArray(c, q) !== -1 && a.toggleVideo()) return false;
        if (a.st.navigateByClick && !a._c2) {
          if (k(b.target).closest(".rsNoDrag", a._d1).length) return true;
          a._d2(b)
        }
      }
    });
    a.ev.trigger("rsAfterInit")
  }
  k.rsModules || (k.rsModules = {});
  t.prototype = {
    _d2: function(b) {
      b[this._f ? "pageX" : "pageY"] - this._e2 > 0 ? this.next() : this.prev()
    },
    _p: function() {
      var b;
      b = this.st.numImagesToPreload;
      if (this._v = this.st.loop) if (this.numSlides === 2) {
        this._v = false;
        this.st.loopRewind = true
      } else if (this.numSlides < 2) this.st.loopRewind = this._v = false;
      this._v && b > 0 && (this.numSlides <= 4 ? b = 1 : this.st.numImagesToPreload > (this.numSlides - 1) / 2 && (b = Math.floor((this.numSlides - 1) / 2)));
      this._u = b
    },
    _o: function(b, e) {
      function c(b, c) {
        a.image = b.attr(!c ? "src" : c);
        a.caption = !c ? b.attr("alt") : b.contents();
        a.videoURL = b.attr("data-rsVideo")
      }
      var g, a = {};
      this._f2 = b = k(b);
      this.ev.trigger("rsBeforeParseNode", [b, a]);
      if (!a.stopParsing) {
        b = this._f2;
        a.id = this._n;
        a.contentAdded = false;
        this._n++;
        if (!a.hasCover) {
          if (b.hasClass("rsImg")) {
            tempEl = b;
            g = true
          } else {
            tempEl = b.find(".rsImg");
            tempEl.length && (g = true)
          }
          if (g) {
            a.bigImage = tempEl.attr("data-rsBigImg");
            tempEl.is("a") ? c(tempEl, "href") : tempEl.is("img") && c(tempEl)
          } else if (b.is("img")) {
            b.addClass("rsImg");
            c(b)
          }
        }
        tempEl = b.find(".rsCaption");
        if (tempEl.length) a.caption = tempEl.remove();
        if (!a.image) {
          a.isLoaded = true;
          a.isRendered = false;
          a.isLoading = false
        }
        a.content = b;
        this.ev.trigger("rsAfterParseNode", [b, a]);
        e && this.slides.push(a);
        return a
      }
    },
    _v1: function() {
      var b = this;
      b._a.on("keydown.rskb", function(e) {
        if (!b._g2 && !b._h2) if (e.keyCode === 37) {
          e.preventDefault();
          b.prev()
        } else if (e.keyCode === 39) {
          e.preventDefault();
          b.next()
        }
      })
    },
    goTo: function(b, e) {
      b !== this.currSlideId && this._i2(b, this.st.transitionSpeed, true, !e)
    },
    destroy: function(b) {
      var e = this;
      e.ev.trigger("rsBeforeDestroy");
      e._a.off("keydown.rskb " + e._g1 + " " + e._h1);
      e._b1.on(e._f1, function(b) {
        e._b2(b)
      });
      e.slider.data("royalSlider", "");
      b && e.slider.remove()
    },
    _j2: function(b, e) {
      function c(c, e, f) {
        if (c.isAdded) {
          g(e, c);
          a(e, c)
        } else {
          f || (f = d.slidesJQ[e]);
          if (c.holder) f = c.holder;
          else {
            f = d.slidesJQ[e] = k(f);
            c.holder = f
          }
          c.appendOnLoaded = false;
          a(e, c, f);
          g(e, c);
          d._l2(c, f, b);
          appended = c.isAdded = true
        }
      }
      function g(a, c) {
        if (!c.contentAdded) {
          d.setItemHtml(c, b);
          if (!b) c.contentAdded = true
        }
      }
      function a(a, b, c) {
        if (d._j) {
          c || (c = d.slidesJQ[a]);
          c.css(d._g, (a + d._z + q) * d._s)
        }
      }
      function f(a) {
        if (j) {
          if (a > m - 1) return f(a - m);
          if (a < 0) return f(m + a)
        }
        return a
      }
      var d = this,
          i, h, j = d._v,
          m = d.numSlides;
      if (!isNaN(e)) return f(e);
      var l = d.currSlideId,
          q, n = b ? Math.abs(d._k2 - d.currSlideId) >= d.numSlides - 1 ? 0 : 1 : d._u,
          o = Math.min(2, n),
          r = false,
          s = false,
          p;
      for (h = l; h < l + 1 + o; h++) {
        p = f(h);
        if ((i = d.slides[p]) && (!i.isAdded || !i.positionSet)) {
          r = true;
          break
        }
      }
      for (h = l - 1; h > l - 1 - o; h--) {
        p = f(h);
        if ((i = d.slides[p]) && (!i.isAdded || !i.positionSet)) {
          s = true;
          break
        }
      }
      if (r) for (h = l; h < l + n + 1; h++) {
        p = f(h);
        q = Math.floor((d._q - (l - h)) / d.numSlides) * d.numSlides;
        (i = d.slides[p]) && c(i, p)
      }
      if (s) for (h = l - 1; h > l - 1 - n; h--) {
        p = f(h);
        q = Math.floor((d._q - (l - h)) / m) * m;
        (i = d.slides[p]) && c(i, p)
      }
      if (!b) {
        o = f(l - n);
        l = f(l + n);
        n = o > l ? 0 : o;
        for (h = 0; h < m; h++) if (!(o > l && h > o - 1) && (h < n || h > l)) if ((i = d.slides[h]) && i.holder) {
          i.holder.detach();
          i.isAdded = false
        }
      }
    },
    setItemHtml: function(b, e) {
      function c() {
        a.isWaiting = true;
        b.holder.html(g._c1.clone());
        a.slideId = -99
      }
      var g = this,
          a = b.holder,
          f = function(a) {
          var b = a.sizeType;
          return function(d) {
            var f = a.content,
                h = a.holder;
            if (d) {
              var i = d.currentTarget;
              k(i).off("load error");
              if (d.type === "error") {
                a.isLoaded = true;
                a.image = "";
                a.isLoading = false;
                f.addClass("rsSlideError");
                h.html(f);
                a.holder.trigger("rsAfterContentSet");
                g.ev.trigger("rsAfterContentSet", a);
                return
              }
            }
            if (a.image) {
              if (a.bigImage && a.sizeType !== b) {
                b === "med" ? a.isMedLoading = false : b === "big" ? a.isBigLoading = false : a.isMedLoading = a.isLoading = false;
                return
              }
              if (a.isLoaded) {
                if (!a.isRendered && e) {
                  c();
                  return
                }
                g._m2(a)
              } else {
                var j;
                if (f.hasClass("rsImg")) {
                  j = true;
                  d = f
                } else {
                  j = false;
                  d = f.find(".rsImg")
                }
                if (d.length && d.is("a")) {
                  j ? f = k('<img class="rsImg" src="' + a.image + '" />') : f.find(".rsImg").replaceWith('<img class="rsImg" src="' + a.image + '" />');
                  a.content = f
                }
                a.iW = i.width;
                if (a.iW > 0) {
                  a.iH = i.height;
                  a.isLoaded = true;
                  a.isLoading = false;
                  g._m2(a)
                }
              }
            } else {
              if (!g._t && e && !a.isRendered) {
                a.isRendered = true;
                c();
                return
              }
              a.isLoaded = true;
              a.isLoading = false
            }
            i = a.id - g._l;
            if (!e && !a.appendOnLoaded && g.st.fadeinLoadedSlide && (i === 0 || (g._h2 || g._g2) && (i === -1 || i === 1))) {
              f.css(g._e + "transition", "opacity 400ms ease-in-out").css({
                visibility: "visible",
                opacity: 0
              });
              h.html(f);
              setTimeout(function() {
                f.css("opacity", 1)
              }, 6)
            } else h.html(f);
            a.isRendered = true;
            h.find("a").off("click.rs").on("click.rs", function() {
              if (g.dragSuccess) return false;
              g._c2 = true;
              g.ev.trigger("rsSlideClick");
              setTimeout(function() {
                g._c2 = false
              }, 3)
            });
            a.holder.trigger("rsAfterContentSet");
            g.ev.trigger("rsAfterContentSet", a);
            a.appendOnLoaded && g._l2(a, f, e)
          }
          };
      if (b.isLoaded) f(b)();
      else if (e) c();
      else if (b.image) if (b.isLoading) {
        var d = 1,
            i = function() {
            if (b.isLoading) if (b.isLoaded) f(b)();
            else {
              if (d % 50 === 0) {
                var a = b.imageLoader;
                if (a.complete && a.naturalWidth !== void 0 && a.naturalWidth !== 0 && a.naturalHeight !== 0) {
                  f(b)();
                  return
                }
              }
              if (!(d > 300)) {
                setTimeout(i, 400);
                d++
              }
            }
            };
        i(b.sizeType)
      } else {
        var h = k("<img/>"),
            j = b.image;
        if (e) c();
        else if (!b.isLoading) {
          if (!j) {
            j = h.attr("src");
            h = k("<img/>")
          }
          b.holder.html(g._c1.clone());
          b.isLoading = true;
          b.imageLoader = h;
          h.one("load error", f(b)).attr("src", j)
        }
      } else f(b)()
    },
    _l2: function(b, e, c) {
      var g = b.holder,
          a = b.id - this._l;
      if (this._j && !c && this.st.fadeinLoadedSlide && (a === 0 || (this._h2 || this._g2) && (a === -1 || a === 1))) {
        e = b.content;
        e.css(this._e + "transition", "opacity 400ms ease-in-out").css({
          visibility: "visible",
          opacity: 0
        });
        this._b1.append(g);
        setTimeout(function() {
          e.css("opacity", 1)
        }, 6)
      } else this._b1.append(g);
      b.appendOnLoaded = false
    },
    _b2: function(b, e) {
      var c = this,
          g;
      c.dragSuccess = false;
      if (k(b.target).closest(".rsNoDrag", c._d1).length) return true;
      e || c._h2 && c._n2();
      if (c._g2) {
        if (c.hasTouch) c._o2 = true
      } else {
        if (c.hasTouch) c._o2 = false;
        c._p2();
        if (c.hasTouch) {
          var a = b.originalEvent.touches;
          if (a && a.length > 0) {
            g = a[0];
            if (a.length > 1) c._o2 = true
          } else return
        } else {
          g = b;
          b.preventDefault()
        }
        c._g2 = true;
        c._a.on(c._g1, function(a) {
          c._q2(a, e)
        }).on(c._h1, function(a) {
          c._r2(a, e)
        });
        c._s2 = "";
        c._t2 = false;
        c._u2 = g.pageX;
        c._v2 = g.pageY;
        c._w2 = c._r = (!e ? c._f : c._x2) ? g.pageX : g.pageY;
        c._y2 = 0;
        c._z2 = 0;
        c._a3 = !e ? c._m : c._b3;
        c._c3 = (new Date).getTime();
        if (c.hasTouch) c._a1.on(c._i1, function(a) {
          c._r2(a, e)
        })
      }
    },
    _d3: function(b, e) {
      if (this._e3) {
        var c = this._f3,
            g = b.pageX - this._u2,
            a = b.pageY - this._v2,
            f = this._a3 + g,
            d = this._a3 + a,
            i = !e ? this._f : this._x2,
            f = i ? f : d,
            h = this._s2;
        this._t2 = true;
        this._u2 = b.pageX;
        this._v2 = b.pageY;
        d = i ? this._u2 : this._v2;
        if (h === "x" && g !== 0) this._y2 = g > 0 ? 1 : -1;
        else if (h === "y" && a !== 0) this._z2 = a > 0 ? 1 : -1;
        g = i ? g : a;
        if (e) f > this._g3 ? f = this._a3 + g * this._j1 : f < this._h3 && (f = this._a3 + g * this._j1);
        else if (!this._v) {
          this.currSlideId <= 0 && d - this._w2 > 0 && (f = this._a3 + g * this._j1);
          this.currSlideId >= this.numSlides - 1 && d - this._w2 < 0 && (f = this._a3 + g * this._j1)
        }
        this._a3 = f;
        if (c - this._c3 > 200) {
          this._c3 = c;
          this._r = d
        }
        e ? this._j3(this._a3) : this._j && this._i3(this._a3)
      }
    },
    _q2: function(b, e) {
      var c = this;
      if (c.hasTouch) {
        if (c._k3) return;
        var g = b.originalEvent.touches;
        if (g) {
          if (g.length > 1) return;
          point = g[0]
        } else return
      } else point = b;
      if (!c._t2) {
        c._c && (!e ? c._b1 : c._l3).css(c._e + c._o1, "0s");
        (function d() {
          if (c._g2) {
            c._m3 = requestAnimationFrame(d);
            c._n3 && c._d3(c._n3, e)
          }
        })()
      }
      if (c._e3) {
        b.preventDefault();
        c._f3 = (new Date).getTime();
        c._n3 = point
      } else {
        var g = !e ? c._f : c._x2,
            a = Math.abs(point.pageX - c._u2) - Math.abs(point.pageY - c._v2) - (g ? -7 : 7);
        if (a > 7) {
          if (g) {
            b.preventDefault();
            c._s2 = "x"
          } else if (c.hasTouch) {
            c._o3();
            return
          }
          c._e3 = true
        } else if (a < -7) {
          if (g) {
            if (c.hasTouch) {
              c._o3();
              return
            }
          } else {
            b.preventDefault();
            c._s2 = "y"
          }
          c._e3 = true
        }
      }
    },
    _o3: function() {
      this._k3 = true;
      this._t2 = this._g2 = false;
      this._r2()
    },
    _r2: function(b, e) {
      function c(a) {
        return a < 100 ? 100 : a > 500 ? 500 : a
      }
      function g(b, d) {
        if (a._j || e) {
          i = (-a._q - a._z) * a._s;
          h = Math.abs(a._m - i);
          a._b = h / d;
          if (b) a._b = a._b + 250;
          a._b = c(a._b);
          a._q3(i, false)
        }
      }
      var a = this,
          f, d, i, h;
      a.ev.trigger("rsDragRelease");
      a._n3 = null;
      a._g2 = false;
      a._k3 = false;
      a._e3 = false;
      a._f3 = 0;
      cancelAnimationFrame(a._m3);
      a._t2 && (e ? a._j3(a._a3) : a._j && a._i3(a._a3));
      a._a.off(a._g1).off(a._h1);
      a.hasTouch && a._a1.off(a._i1);
      a._m1();
      if (!a._t2 && !a._o2 && e && a._p3) {
        var j = k(b.target).closest(".rsNavItem");
        j.length && a.goTo(j.index())
      } else {
        d = !e ? a._f : a._x2;
        if (a._t2 && !(a._s2 === "y" && d || a._s2 === "x" && !d)) {
          a.dragSuccess = true;
          a._s2 = "";
          var m = a.st.minSlideOffset;
          f = a.hasTouch ? b.originalEvent.changedTouches[0] : b;
          var l = d ? f.pageX : f.pageY,
              q = a._w2;
          f = a._r;
          var n = a.currSlideId,
              o = a.numSlides,
              r = d ? a._y2 : a._z2,
              s = a._v;
          Math.abs(l - q);
          f = l - f;
          d = (new Date).getTime() - a._c3;
          d = Math.abs(f) / d;
          if (r === 0 || o <= 1) g(true, d);
          else {
            if (!s && !e) if (n <= 0) {
              if (r > 0) {
                g(true, d);
                return
              }
            } else if (n >= o - 1 && r < 0) {
              g(true, d);
              return
            }
            if (e) {
              i = a._b3;
              if (i > a._g3) i = a._g3;
              else if (i < a._h3) i = a._h3;
              else {
                m = d * d / 0.006;
                j = -a._b3;
                l = a._r3 - a._s3 + a._b3;
                if (f > 0 && m > j) {
                  j = j + a._s3 / (15 / (m / d * 0.003));
                  d = d * j / m;
                  m = j
                } else if (f < 0 && m > l) {
                  l = l + a._s3 / (15 / (m / d * 0.003));
                  d = d * l / m;
                  m = l
                }
                j = Math.max(Math.round(d / 0.003), 50);
                i = i + m * (f < 0 ? -1 : 1);
                if (i > a._g3) {
                  a._t3(i, j, true, a._g3, 200);
                  return
                }
                if (i < a._h3) {
                  a._t3(i, j, true, a._h3, 200);
                  return
                }
              }
              a._t3(i, j, true)
            } else q + m < l ? r < 0 ? g(false, d) : a._i2("prev", c(Math.abs(a._m - (-a._q - a._z + 1) * a._s) / d), false, true, true) : q - m > l ? r > 0 ? g(false, d) : a._i2("next", c(Math.abs(a._m - (-a._q - a._z - 1) * a._s) / d), false, true, true) : g(false, d)
          }
        }
      }
    },
    _i3: function(b) {
      b = this._m = b;
      this._c ? this._b1.css(this._r1, this._s1 + (this._f ? b + this._t1 + 0 : 0 + this._t1 + b) + this._u1) : this._b1.css(this._f ? this._r1 : this._q1, b)
    },
    updateSliderSize: function(b) {
      var e, c;
      this.st.beforeResize && this.st.beforeResize.call(this);
      if (this.st.autoScaleSlider) {
        var g = this.st.autoScaleSliderWidth,
            a = this.st.autoScaleSliderHeight;
        if (this.st.autoScaleHeight) {
          e = this.slider.width();
          if (e != this.width) {
            this.slider.css("height", e * (a / g));
            e = this.slider.width()
          }
          c = this.slider.height()
        } else {
          c = this.slider.height();
          if (c != this.height) {
            this.slider.css("width", c * (g / a));
            c = this.slider.height()
          }
          e = this.slider.width()
        }
      } else {
        e = this.slider.width();
        c = this.slider.height()
      }
      this._e2 = this.slider.offset();
      this._e2 = this._e2[this._g];
      if (b || e != this.width || c != this.height) {
        this.width = e;
        this.height = c;
        this._u3 = e;
        this._v3 = c;
        this.ev.trigger("rsBeforeSizeSet");
        this._a1.css({
          width: this._u3,
          height: this._v3
        });
        this._s = (this._f ? this._u3 : this._v3) + this.st.slidesSpacing;
        this._w3 = this.st.imageScalePadding;
        for (e = 0; e < this.slides.length; e++) {
          b = this.slides[e];
          b.positionSet = false;
          if (b && b.image && b.isLoaded) {
            b.isRendered = false;
            this._m2(b)
          }
        }
        if (this._x3) for (e = 0; e < this._x3.length; e++) {
          b = this._x3[e];
          b.holder.css(this._g, (b.id + this._z) * this._s)
        }
        this._j2();
        if (this._j) {
          this._c && this._b1.css(this._e + "transition-duration", "0s");
          this._i3((-this._q - this._z) * this._s)
        }
        this.ev.trigger("rsOnUpdateNav");
        this.st.afterResize && this.st.afterResize.call(this)
      }
    },
    setSlidesOrientation: function() {},
    appendSlide: function(b, e) {
      var c = this._o(b);
      if (isNaN(e) || e > this.numSlides) e = this.numSlides;
      this.slides.splice(e, 0, c);
      this.slidesJQ.splice(e, 0, '<div style="' + (this._j ? "position: absolute;" : "z-index: 0; display:none; opacity: 0; position: absolute;  left: 0; top: 0;") + '" class="rsSlide"></div>');
      e < this.currSlideId && this.currSlideId++;
      this.ev.trigger("rsOnAppendSlide", [c, e]);
      this._z3(e);
      e === this.currSlideId && this.ev.trigger("rsAfterSlideChange")
    },
    removeSlide: function(b) {
      var e = this.slides[b];
      if (e) {
        e.holder && e.holder.remove();
        b < this.currSlideId && this.currSlideId++;
        this.slides.splice(b, 1);
        this.slidesJQ.splice(b, 1);
        this.ev.trigger("rsOnRemoveSlide", [b]);
        this._z3(b);
        b === this.currSlideId && this.ev.trigger("rsAfterSlideChange")
      }
    },
    _z3: function() {
      var b = this,
          e = b.numSlides,
          e = b._q <= 0 ? 0 : Math.floor(b._q / e);
      b.numSlides = b.slides.length;
      if (b.numSlides === 0) {
        b.currSlideId = b._z = b._q = 0;
        b.currSlide = b._a4 = null
      } else b._q = e * b.numSlides + b.currSlideId;
      for (e = 0; e < b.numSlides; e++) b.slides[e].id = e;
      b.currSlide = b.slides[b.currSlideId];
      b._d1 = b.slidesJQ[b.currSlideId];
      b.currSlideId >= b.numSlides ? b.goTo(b.numSlides - 1) : b.currSlideId < 0 && b.goTo(0);
      b._p();
      b._j && b._v && b._b1.css(b._e + b._o1, "0ms");
      b._b4 && clearTimeout(b._b4);
      b._b4 = setTimeout(function() {
        b._i3((-b._q - b._z) * b._s);
        b._j2()
      }, 14);
      b.ev.trigger("rsOnUpdateNav")
    },
    _m1: function() {
      if (!this.hasTouch && this._j) if (this._k1) this._a1.css("cursor", this._k1);
      else {
        this._a1.removeClass("grabbing-cursor");
        this._a1.addClass("grab-cursor")
      }
    },
    _p2: function() {
      if (!this.hasTouch && this._j) if (this._l1) this._a1.css("cursor", this._l1);
      else {
        this._a1.removeClass("grab-cursor");
        this._a1.addClass("grabbing-cursor")
      }
    },
    next: function(b) {
      this._i2("next", this.st.transitionSpeed, true, !b)
    },
    prev: function(b) {
      this._i2("prev", this.st.transitionSpeed, true, !b)
    },
    _i2: function(b, e, c, g, a) {
      var f = this,
          d, i, h;
      f._d4 && f.stopVideo();
      f.ev.trigger("rsBeforeMove", [b, g]);
      newItemId = b === "next" ? f.currSlideId + 1 : b === "prev" ? f.currSlideId - 1 : b = parseInt(b, 10);
      if (!f._v) {
        if (newItemId < 0) {
          f._e4("left", !g);
          return
        }
        if (newItemId >= f.numSlides) {
          f._e4("right", !g);
          return
        }
      }
      if (f._h2) {
        f._n2();
        c = false
      }
      i = newItemId - f.currSlideId;
      h = f._k2 = f.currSlideId;
      var j = f.currSlideId + i,
          g = f._q,
          m;
      if (f._v) {
        j = f._j2(false, j);
        g = g + i
      } else g = j;
      f._l = j;
      f._a4 = f.slidesJQ[f.currSlideId];
      f._q = g;
      f.currSlideId = f._l;
      f.currSlide = f.slides[f.currSlideId];
      f._d1 = f.slidesJQ[f.currSlideId];
      j = Boolean(i > 0);
      i = Math.abs(i);
      var l = Math.floor(h / f._u),
          k = Math.floor((h + (j ? 2 : -2)) / f._u),
          l = (j ? Math.max(l, k) : Math.min(l, k)) * f._u + (j ? f._u - 1 : 0);
      l > f.numSlides - 1 ? l = f.numSlides - 1 : l < 0 && (l = 0);
      h = j ? l - h : h - l;
      if (h > f._u) h = f._u;
      if (i > h + 2) {
        f._z = f._z + (i - (h + 2)) * (j ? -1 : 1);
        e = e * 1.4;
        for (h = 0; h < f.numSlides; h++) f.slides[h].positionSet = false
      }
      f._b = e;
      f._j2(true);
      a || (m = true);
      d = (-g - f._z) * f._s;
      if (m) setTimeout(function() {
        f._c4 = false;
        f._q3(d, b, false, c);
        f.ev.trigger("rsOnUpdateNav")
      }, 0);
      else {
        f._q3(d, b, false, c);
        f.ev.trigger("rsOnUpdateNav")
      }
    },
    _z1: function() {
      if (this.st.arrowsNav) if (this.numSlides <= 1) {
        this._w1.css("display", "none");
        this._x1.css("display", "none")
      } else {
        this._w1.css("display", "block");
        this._x1.css("display", "block");
        if (!this._v && !this.st.loopRewind) {
          this.currSlideId === 0 ? this._w1.addClass("rsArrowDisabled") : this._w1.removeClass("rsArrowDisabled");
          this.currSlideId === this.numSlides - 1 ? this._x1.addClass("rsArrowDisabled") : this._x1.removeClass("rsArrowDisabled")
        }
      }
    },
    _q3: function(b, e, c, g, a) {
      function f() {
        var a = i.data("rsTimeout");
        if (a) {
          i !== h && i.css({
            opacity: 0,
            display: "none",
            zIndex: 0
          });
          clearTimeout(a);
          i.data("rsTimeout", "")
        }
        if (a = h.data("rsTimeout")) {
          clearTimeout(a);
          h.data("rsTimeout", "")
        }
      }
      var d = this,
          i, h, j = {};
      if (isNaN(d._b)) d._b = 400;
      d._m = d._a3 = b;
      d.ev.trigger("rsBeforeAnimStart");
      d.st.beforeSlideChange && d.st.beforeSlideChange.call(d);
      if (d._c) if (d._j) {
        j[d._e + d._o1] = d._b + "ms";
        j[d._e + d._p1] = g ? k.rsCSS3Easing[d.st.easeInOut] : k.rsCSS3Easing[d.st.easeOut];
        d._b1.css(j);
        setTimeout(function() {
          d._i3(b)
        }, d.hasTouch ? 5 : 0)
      } else {
        d._b = d.st.transitionSpeed;
        i = d._a4;
        h = d._d1;
        h.data("rsTimeout") && h.css("opacity", 0);
        f();
        i && i.data("rsTimeout", setTimeout(function() {
          j[d._e + d._o1] = "0ms";
          j.zIndex = 0;
          j.display = "none";
          i.data("rsTimeout", "");
          i.css(j);
          setTimeout(function() {
            i.css("opacity", 0)
          }, 16)
        }, d._b + 60));
        j.display = "block";
        j.zIndex = d._k;
        j.opacity = 0;
        j[d._e + d._o1] = "0ms";
        j[d._e + d._p1] = k.rsCSS3Easing[d.st.easeInOut];
        h.css(j);
        h.data("rsTimeout", setTimeout(function() {
          h.css(d._e + d._o1, d._b + "ms");
          h.data("rsTimeout", setTimeout(function() {
            h.css("opacity", 1);
            h.data("rsTimeout", "")
          }, 20))
        }, 20))
      } else if (d._j) {
        j[d._f ? d._r1 : d._q1] = b + "px";
        d._b1.animate(j, d._b, g ? d.st.easeInOut : d.st.easeOut)
      } else {
        i = d._a4;
        h = d._d1;
        h.stop(true, true).css({
          opacity: 0,
          display: "block",
          zIndex: d._k
        });
        d._b = d.st.transitionSpeed;
        h.animate({
          opacity: 1
        }, d._b, d.st.easeInOut);
        f();
        i && i.data("rsTimeout", setTimeout(function() {
          i.stop(true, true).css({
            opacity: 0,
            display: "none",
            zIndex: 0
          })
        }, d._b + 60))
      }
      d._h2 = true;
      d.loadingTimeout && clearTimeout(d.loadingTimeout);
      d.loadingTimeout = a ? setTimeout(function() {
        d.loadingTimeout = null;
        a.call()
      }, d._b + 60) : setTimeout(function() {
        d.loadingTimeout = null;
        d._f4(e)
      }, d._b + 60)
    },
    _n2: function() {
      this._h2 = false;
      clearTimeout(this.loadingTimeout);
      if (this._j) if (this._c) {
        var b = this._m,
            e = this._a3 = this._g4();
        this._b1.css(this._e + this._o1, "0ms");
        b !== e && this._i3(e)
      } else {
        this._b1.stop(true);
        this._m = parseInt(this._b1.css(this._r1), 10)
      } else this._k > 20 ? this._k = 10 : this._k++
    },
    _g4: function() {
      var b = window.getComputedStyle(this._b1.get(0), null).getPropertyValue(this._e + "transform").replace(/^matrix\(/i, "").split(/, |\)$/g);
      return parseInt(b[this._f ? 4 : 5], 10)
    },
    _h4: function(b, e) {
      return this._c ? this._s1 + (e ? b + this._t1 + 0 : 0 + this._t1 + b) + this._u1 : b
    },
    _f4: function() {
      if (!this._j) {
        this._d1.css("z-index", 0);
        this._k = 10
      }
      this._h2 = false;
      this.staticSlideId = this.currSlideId;
      this._j2();
      this._i4 = false;
      this.ev.trigger("rsAfterSlideChange");
      this.st.afterSlideChange && this.st.afterSlideChange.call(this)
    },
    _e4: function(b, e) {
      var c = this,
          g = (-c._q - c._z) * c._s;
      moveDist = 30;
      if (c.numSlides !== 0) if (c.st.loopRewind) b === "left" ? c.goTo(c.numSlides - 1, e) : c.goTo(0, e);
      else if (!c._h2 && c._j && moveDist !== 0) {
        c._b = 200;
        var a = function() {
            c._h2 = false
            };
        c._q3(g + (b === "left" ? moveDist : -moveDist), "", false, true, function() {
          c._h2 = false;
          c._q3(g, "", false, true, a)
        })
      }
    },
    _m2: function(b) {
      if (!b.isRendered) {
        var e = b.content,
            c = "rsImg",
            g, a = this.st.imageAlignCenter,
            f = this.st.imageScaleMode,
            d;
        if (b.videoURL) {
          c = "rsVideoContainer";
          if (f !== "fill") g = true;
          else {
            d = e;
            d.hasClass(c) || (d = d.find("." + c));
            d.css({
              width: "100%",
              height: "100%"
            });
            c = "rsImg"
          }
        }
        e.hasClass(c) || (e = e.find("." + c));
        var i = b.iW,
            c = b.iH;
        b.isRendered = true;
        if (f !== "none" || a) {
          bMargin = f !== "fill" ? this._w3 : 0;
          b = this._u3 - bMargin * 2;
          d = this._v3 - bMargin * 2;
          var h, j, k = {};
          if (f === "fit-if-smaller" && (i > b || c > d)) f = "fit";
          if (f === "fill" || f === "fit") {
            h = b / i;
            j = d / c;
            h = f == "fill" ? h > j ? h : j : f == "fit" ? h < j ? h : j : 1;
            i = Math.ceil(i * h, 10);
            c = Math.ceil(c * h, 10)
          }
          if (f !== "none") {
            k.width = i;
            k.height = c;
            g && e.find(".rsImg").css({
              width: "100%",
              height: "100%"
            })
          }
          if (a) {
            k.marginLeft = Math.floor((b - i) / 2) + bMargin;
            k.marginTop = Math.floor((d - c) / 2) + bMargin
          }
          e.css(k)
        }
      }
    }
  };
  k.rsProto = t.prototype;
  k.fn.royalSlider = function(b) {
    var e = arguments;
    return this.each(function() {
      var c = k(this);
      if (typeof b === "object" || !b) c.data("royalSlider") || c.data("royalSlider", new t(c, b));
      else if ((c = c.data("royalSlider")) && c[b]) return c[b].apply(c, Array.prototype.slice.call(e, 1))
    })
  };
  k.fn.royalSlider.defaults = {
    slidesSpacing: 8,
    startSlideId: 0,
    loop: !1,
    loopRewind: !1,
    numImagesToPreload: 4,
    fadeinLoadedSlide: !0,
    slidesOrientation: "horizontal",
    transitionType: "move",
    transitionSpeed: 600,
    controlNavigation: "bullets",
    controlsInside: !0,
    arrowsNav: !0,
    arrowsNavAutoHide: !0,
    navigateByClick: !0,
    randomizeSlides: !1,
    sliderDrag: !0,
    sliderTouch: !0,
    keyboardNavEnabled: !1,
    fadeInAfterLoaded: !0,
    allowCSS3: !0,
    allowCSS3OnWebkit: !0,
    addActiveClass: !1,
    autoHeight: !1,
    easeOut: "easeOutSine",
    easeInOut: "easeInOutSine",
    minSlideOffset: 10,
    imageScaleMode: "fit-if-smaller",
    imageAlignCenter: !0,
    imageScalePadding: 4,
    autoScaleSlider: !1,
    autoScaleSliderWidth: 800,
    autoScaleSliderHeight: 400,
    autoScaleHeight: !0,
    arrowsNavHideOnTouch: !1,
    globalCaption: !1,
    beforeSlideChange: null,
    afterSlideChange: null,
    beforeResize: null,
    afterResize: null
  };
  k.rsCSS3Easing = {
    easeOutSine: "cubic-bezier(0.390, 0.575, 0.565, 1.000)",
    easeInOutSine: "cubic-bezier(0.445, 0.050, 0.550, 0.950)"
  };
  k.extend(jQuery.easing, {
    easeInOutSine: function(b, e, c, g, a) {
      return -g / 2 * (Math.cos(Math.PI * e / a) - 1) + c
    },
    easeOutSine: function(b, e, c, g, a) {
      return g * Math.sin(e / a * (Math.PI / 2)) + c
    },
    easeOutCubic: function(b, e, c, g, a) {
      return g * ((e = e / a - 1) * e * e + 1) + c
    }
  })
})(jQuery);
// jquery.rs.active-class v1.0
(function(b) {
  b.rsProto._j4 = function() {
    var c, a = this;
    if (a.st.addActiveClass) {
      a.ev.on("rsBeforeMove", function() {
        b()
      });
      a.ev.on("rsAfterInit", function() {
        b()
      });
      var b = function() {
          c && clearTimeout(c);
          c = setTimeout(function() {
            a._a4 && a._a4.removeClass("rsActiveSlide");
            a._d1 && a._d1.addClass("rsActiveSlide");
            c = null
          }, 50)
          }
    }
  };
  b.rsModules.activeClass = b.rsProto._j4
})(jQuery);
// jquery.rs.animated-blocks v1.0.2
(function(i) {
  i.extend(i.rsProto, {
    _k4: function() {
      function j() {
        var e = a.currSlide;
        if (a.currSlide && a.currSlide.isLoaded && a._o4 !== e) {
          if (0 < a._n4.length) {
            for (b = 0; b < a._n4.length; b++) clearTimeout(a._n4[b]);
            a._n4 = []
          }
          if (0 < a._m4.length) {
            var g;
            for (b = 0; b < a._m4.length; b++) if (g = a._m4[b]) a._c ? (g.block.css(a._e + a._o1, "0s"), g.block.css(g.css)) : g.running ? g.block.stop(!0, !0) : g.block.css(g.css), a._o4 = null, e.animBlocksDisplayed = !1;
            a._m4 = []
          }
          e.animBlocks && (e.animBlocksDisplayed = !0, a._o4 = e, a._p4(e.animBlocks))
        }
      }
      var a = this,
          b;
      a._l4 = {
        fadeEffect: !0,
        moveEffect: "top",
        moveOffset: 20,
        speed: 400,
        easing: "easeOutSine",
        delay: 200
      };
      a.st.block = i.extend({}, a._l4, a.st.block);
      a._m4 = [];
      a._n4 = [];
      a.ev.on("rsAfterInit", function() {
        j()
      });
      a.ev.on("rsBeforeParseNode", function(a, b, c) {
        b = i(b);
        c.animBlocks = b.find(".rsABlock").css("display", "none");
        c.animBlocks.length || (c.animBlocks = b.hasClass("rsABlock") ? b.css("display", "none") : !1)
      });
      a.ev.on("rsAfterContentSet", function(b, g) {
        g.id === a.currSlideId && setTimeout(function() {
          j()
        }, a.st.fadeinLoadedSlide ? 300 : 0)
      });
      a.ev.on("rsAfterSlideChange", function() {
        j()
      })
    },
    _q4: function(i, a) {
      setTimeout(function() {
        i.css(a)
      }, 6)
    },
    _p4: function(j) {
      var a = this,
          b, e, g, c;
      a._n4 = [];
      j.each(function(j) {
        b = i(this);
        e = {};
        g = {};
        c = null;
        var f = b.data("move-offset");
        isNaN(f) && (f = a.st.block.moveOffset);
        if (0 < f) {
          var d = b.data("move-effect");
          d ? (d = d.toLowerCase(), "none" === d ? d = !1 : "left" !== d && ("top" !== d && "bottom" !== d && "right" !== d) && (d = a.st.block.moveEffect, "none" === d && (d = !1))) : d = a.st.block.moveEffect;
          if (d) {
            var l;
            l = "right" === d || "left" === d ? !0 : !1;
            var k, h;
            isOppositeProp = !1;
            a._c ? (k = 0, h = a._r1) : (l ? isNaN(parseInt(b.css("right"), 10)) ? h = "left" : (h = "right", isOppositeProp = !0) : isNaN(parseInt(b.css("bottom"), 10)) ? h = "top" : (h = "bottom", isOppositeProp = !0), h = "margin-" + h, isOppositeProp && (f = -f), k = parseInt(b.css(h), 10));
            g[h] = a._h4("top" === d || "left" === d ? k - f : k + f, l);
            e[h] = a._h4(k, l)
          }
        }
        if (f = b.attr("data-fade-effect")) {
          if ("none" === f.toLowerCase() || "false" === f.toLowerCase()) f = !1
        } else f = a.st.block.fadeEffect;
        f && (g.opacity = 0, e.opacity = 1);
        if (f || d) if (c = {}, c.hasFade = Boolean(f), Boolean(d) && (c.moveProp = h, c.hasMove = !0), c.speed = b.data("speed"), isNaN(c.speed) && (c.speed = a.st.block.speed), c.easing = b.data("easing"), c.easing || (c.easing = a.st.block.easing), c.css3Easing = i.rsCSS3Easing[c.easing], c.delay = b.data("delay"), isNaN(c.delay)) c.delay = a.st.block.delay * j;
        d = {};
        a._c && (d[a._e + a._o1] = "0ms");
        d.moveProp = e.moveProp;
        d.opacity = e.opacity;
        d.display = "none";
        a._m4.push({
          block: b,
          css: d
        });
        a._q4(b, g);
        a._n4.push(setTimeout(function(b, d, c, g) {
          return function() {
            b.css("display", "block");
            if (c) {
              var f = {};
              if (a._c) {
                var e = "";
                c.hasMove && (e = e + c.moveProp);
                if (c.hasFade) {
                  c.hasMove && (e = e + ", ");
                  e = e + "opacity"
                }
                f[a._e + a._n1] = e;
                f[a._e + a._o1] = c.speed + "ms";
                f[a._e + a._p1] = c.css3Easing;
                b.css(f);
                setTimeout(function() {
                  b.css(d)
                }, 24)
              } else setTimeout(function() {
                b.animate(d, c.speed, c.easing)
              }, 16)
            }
            delete a._n4[g]
          }
        }(b, e, c, j), 6 >= c.delay ? 12 : c.delay))
      })
    }
  });
  i.rsModules.animatedBlocks = i.rsProto._k4
})(jQuery);
// jquery.rs.auto-height v1.0.1
(function(b) {
  b.extend(b.rsProto, {
    _r4: function() {
      var a = this;
      if (a.st.autoHeight) {
        var b, c;
        a.slider.addClass("rsAutoHeight");
        a.ev.on("rsAfterInit", function() {
          setTimeout(function() {
            d(!1);
            setTimeout(function() {
              a.slider.append('<div id="clear" style="clear:both;"></div>');
              a._c && a._a1.css(a._e + "transition", "height " + a.st.transitionSpeed + "ms ease-in-out")
            }, 16)
          }, 16)
        });
        a.ev.on("rsBeforeAnimStart", function() {
          d(!0)
        });
        a.ev.on("rsBeforeSizeSet", function() {
          setTimeout(function() {
            d(!1)
          }, 16)
        });
        var d = function(f) {
            var e = a.slides[a.currSlideId];
            b = e.holder;
            if (e.isLoaded) b && (c = b.height(), 0 !== c && void 0 !== c && (a._v3 = c, a._c || !f ? a._a1.css("height", c) : a._a1.stop(!0, !0).animate({
              height: c
            }, a.st.transitionSpeed)));
            else a.ev.off("rsAfterContentSet.rsAutoHeight").on("rsAfterContentSet.rsAutoHeight", function(a, b) {
              e === b && d()
            })
            }
      }
    }
  });
  b.rsModules.autoHeight = b.rsProto._r4
})(jQuery);
// jquery.rs.autoplay v1.0.2
(function(b) {
  b.extend(b.rsProto, {
    _u4: function() {
      var a = this,
          d;
      a._v4 = {
        enabled: !1,
        stopAtAction: !0,
        pauseOnHover: !0,
        delay: 2E3
      };
      a.st.autoPlay = b.extend({}, a._v4, a.st.autoPlay);
      a.st.autoPlay.enabled && (a.ev.on("rsBeforeParseNode", function(a, c, e) {
        c = b(c);
        if (d = c.attr("data-rsDelay")) e.customDelay = parseInt(d, 10)
      }), a.ev.one("rsAfterInit", function() {
        a._w4()
      }), a.ev.on("rsBeforeDestroy", function() {
        a.stopAutoPlay()
      }))
    },
    _w4: function() {
      var a = this;
      a.startAutoPlay();
      a.ev.on("rsAfterContentSet", function(d, b) {
        !a._g2 && (!a._h2 && a._x4 && b === a.currSlide) && a._y4()
      });
      a.ev.on("rsDragRelease", function() {
        a._x4 && a._z4 && (a._z4 = !1, a._y4())
      });
      a.ev.on("rsAfterSlideChange", function() {
        a._x4 && a._z4 && (a._z4 = !1, a.currSlide.isLoaded && a._y4())
      });
      a.ev.on("rsDragStart", function() {
        a._x4 && (a.st.autoPlay.stopAtAction ? a.stopAutoPlay() : (a._z4 = !0, a._a5()))
      });
      a.ev.on("rsBeforeMove", function(b, f, c) {
        a._x4 && (c && a.st.autoPlay.stopAtAction ? a.stopAutoPlay() : (a._z4 = !0, a._a5()))
      });
      a._b5 = !1;
      a.ev.on("rsVideoStop", function() {
        a._x4 && (a._b5 = !1, a._y4())
      });
      a.ev.on("rsVideoPlay", function() {
        a._x4 && (a._z4 = !1, a._a5(), a._b5 = !0)
      });
      a.st.autoPlay.pauseOnHover && (a._c5 = !1, a.slider.hover(function() {
        a._x4 && (a._z4 = !1, a._a5(), a._c5 = !0)
      }, function() {
        a._x4 && (a._c5 = !1, a._y4())
      }))
    },
    toggleAutoplay: function() {
      this._x4 ? this.startAutoPlay() : this.stopAutoPlay()
    },
    startAutoPlay: function() {
      this._x4 = !0;
      this.currSlide.isLoaded && this._y4()
    },
    stopAutoPlay: function() {
      this._b5 = this._c5 = this._z4 = this._x4 = !1;
      this._a5()
    },
    _y4: function() {
      var a = this;
      !a._c5 && !a._b5 && (a._d5 = !0, a._e5 && clearTimeout(a._e5), a._e5 = setTimeout(function() {
        var b;
        !a._v && !a.st.loopRewind && (b = !0, a.st.loopRewind = !0);
        a.next(!0);
        b && (a.st.loopRewind = !1)
      }, !a.currSlide.customDelay ? a.st.autoPlay.delay : a.currSlide.customDelay))
    },
    _a5: function() {
      !this._c5 && !this._b5 && (this._d5 = !1, this._e5 && (clearTimeout(this._e5), this._e5 = null))
    }
  });
  b.rsModules.autoplay = b.rsProto._u4
})(jQuery);
// jquery.rs.bullets v1.0
(function(c) {
  c.extend(c.rsProto, {
    _f5: function() {
      var a = this;
      "bullets" === a.st.controlNavigation && (a.ev.one("rsAfterPropsSetup", function() {
        a._g5 = !0;
        a.slider.addClass("rsWithBullets");
        for (var b = '<div class="rsNav rsBullets">', e = 0; e < a.numSlides; e++) b += '<div class="rsNavItem rsBullet"><span class=""></span></div>';
        b = c(b + "</div>");
        a._t4 = b;
        a._h5 = b.children();
        a.slider.append(b);
        a._t4.click(function(b) {
          b = c(b.target).closest(".rsNavItem");
          b.length && a.goTo(b.index())
        })
      }), a.ev.on("rsOnAppendSlide", function(b, c, d) {
        d >= a.numSlides ? a._t4.append('<div class="rsNavItem rsBullet"><span class=""></span></div>') : a._h5.eq(d).before('<div class="rsNavItem rsBullet"><span class=""></span></div>');
        a._h5 = a._t4.children()
      }), a.ev.on("rsOnRemoveSlide", function(b, c) {
        var d = a._h5.eq(c);
        d && (d.remove(), a._h5 = a._t4.children())
      }), a.ev.on("rsOnUpdateNav", function() {
        var b = a.currSlideId;
        a._i5 && a._i5.removeClass("rsNavSelected");
        b = c(a._h5[b]);
        b.addClass("rsNavSelected");
        a._i5 = b
      }))
    }
  });
  c.rsModules.bullets = c.rsProto._f5
})(jQuery);
// jquery.rs.deeplinking v1.0 + jQuery hashchange plugin v1.3 Copyright (c) 2010 Ben Alman
(function(a) {
  a.extend(a.rsProto, {
    _j5: function() {
      var b = this,
          f, e;
      b._k5 = {
        enabled: !1,
        change: !1,
        prefix: ""
      };
      b.st.deeplinking = a.extend({}, b._k5, b.st.deeplinking);
      if (b.st.deeplinking.enabled) {
        var g = b.st.deeplinking.change,
            h = "#" + b.st.deeplinking.prefix,
            d = function() {
            var a = window.location.hash;
            return a && (a = parseInt(a.substring(h.length), 10), 0 <= a) ? a - 1 : -1
            },
            c = d(); - 1 !== c && (b.st.startSlideId = c);
        if (g) a(window).on("hashchange.rs", function() {
          if (!f) {
            var a = d();
            a < 0 ? a = 0 : a > b.numSlides - 1 && (a = b.numSlides - 1);
            b.goTo(a)
          }
        });
        b.ev.on("rsAfterSlideChange", function() {
          e && clearTimeout(e);
          f = true;
          window.location.hash = h + (b.currSlideId + 1);
          e = setTimeout(function() {
            f = false;
            e = 0
          }, 60)
        })
      }
    }
  });
  a.rsModules.deeplinking = a.rsProto._j5
})(jQuery);
(function(a, b, f) {
  function e(a) {
    a = a || location.href;
    return "#" + a.replace(/^[^#]*#?(.*)$/, "$1")
  }
  "$:nomunge";
  var g = document,
      h, d = a.event.special,
      c = g.documentMode,
      m = "onhashchange" in b && (c === f || 7 < c);
  a.fn.hashchange = function(a) {
    return a ? this.bind("hashchange", a) : this.trigger("hashchange")
  };
  a.fn.hashchange.delay = 50;
  d.hashchange = a.extend(d.hashchange, {
    setup: function() {
      if (m) return !1;
      a(h.start)
    },
    teardown: function() {
      if (m) return !1;
      a(h.stop)
    }
  });
  var o = function() {
      var d = e(),
          c = p(l);
      d !== l ? (n(l = d, c), a(b).trigger("hashchange")) : c !== l && (location.href = location.href.replace(/#.*/, "") + c);
      j = setTimeout(o, a.fn.hashchange.delay)
      },
      d = {},
      j, l = e(),
      n = c = function(a) {
      return a
      },
      p = c;
  d.start = function() {
    j || o()
  };
  d.stop = function() {
    j && clearTimeout(j);
    j = f
  };
  if (a.browser.msie && !m) {
    var i, k;
    d.start = function() {
      i || (k = (k = a.fn.hashchange.src) && k + e(), i = a('<iframe tabindex="-1" title="empty"/>').hide().one("load", function() {
        k || n(e());
        o()
      }).attr("src", k || "javascript:0").insertAfter("body")[0].contentWindow, g.onpropertychange = function() {
        try {
          "title" === event.propertyName && (i.document.title = g.title)
        } catch (a) {}
      })
    };
    d.stop = c;
    p = function() {
      return e(i.location.href)
    };
    n = function(b, d) {
      var c = i.document,
          e = a.fn.hashchange.domain;
      b !== d && (c.title = g.title, c.open(), e && c.write('<script>document.domain="' + e + '"<\/script>'), c.close(), i.location.hash = b)
    }
  }
  h = d
})(jQuery, this);
// jquery.rs.fullscreen v1.0
(function(c) {
  c.extend(c.rsProto, {
    _l5: function() {
      var a = this;
      a._m5 = {
        enabled: !1,
        keyboardNav: !0,
        buttonFS: !0,
        nativeFS: !1,
        doubleTap: !0
      };
      a.st.fullscreen = c.extend({}, a._m5, a.st.fullscreen);
      if (a.st.fullscreen.enabled) a.ev.one("rsBeforeSizeSet", function() {
        a._n5()
      })
    },
    _n5: function() {
      var a = this;
      a._o5 = !a.st.keyboardNavEnabled && a.st.fullscreen.keyboardNav;
      if (a.st.fullscreen.nativeFS) {
        a._p5 = {
          supportsFullScreen: !1,
          isFullScreen: function() {
            return !1
          },
          requestFullScreen: function() {},
          cancelFullScreen: function() {},
          fullScreenEventName: "",
          prefix: ""
        };
        var b = ["webkit", "moz", "o", "ms", "khtml"];
        if ("undefined" != typeof document.cancelFullScreen) a._p5.supportsFullScreen = !0;
        else for (var d = 0; d < b.length; d++) if (a._p5.prefix = b[d], "undefined" != typeof document[a._p5.prefix + "CancelFullScreen"]) {
          a._p5.supportsFullScreen = !0;
          break
        }
        a._p5.supportsFullScreen ? (a._p5.fullScreenEventName = a._p5.prefix + "fullscreenchange.rs", a._p5.isFullScreen = function() {
          switch (this.prefix) {
          case "":
            return document.fullScreen;
          case "webkit":
            return document.webkitIsFullScreen;
          default:
            return document[this.prefix + "FullScreen"]
          }
        }, a._p5.requestFullScreen = function(a) {
          return "" === this.prefix ? a.requestFullScreen() : a[this.prefix + "RequestFullScreen"]()
        }, a._p5.cancelFullScreen = function() {
          return "" === this.prefix ? document.cancelFullScreen() : document[this.prefix + "CancelFullScreen"]()
        }) : a._p5 = !1
      }
      a.st.fullscreen.buttonFS && (a._q5 = c('<div class="rsFullscreenBtn"><div class="rsFullscreenIcn"></div></div>').appendTo(a.st.controlsInside ? a._a1 : a.slider).on("click.rs", function() {
        a.isFullscreen ? a.exitFullscreen() : a.enterFullscreen()
      }))
    },
    enterFullscreen: function(a) {
      var b = this;
      if (b._p5) if (a) b._p5.requestFullScreen(c("html")[0]);
      else {
        b._a.on(b._p5.fullScreenEventName, function() {
          b._p5.isFullScreen() ? b.enterFullscreen(!0) : b.exitFullscreen(!0)
        });
        b._p5.requestFullScreen(c("html")[0]);
        return
      }
      if (!b._r5) {
        b._r5 = !0;
        b._a.on("keyup.rsfullscreen", function(a) {
          27 === a.keyCode && b.exitFullscreen()
        });
        b._o5 && b._v1();
        b._s5 = c("html").attr("style");
        b._t5 = c("body").attr("style");
        b._u5 = b.slider.attr("style");
        c("body, html").css({
          overflow: "hidden",
          height: "100%",
          width: "100%",
          margin: "0",
          padding: "0"
        });
        b.slider.addClass("rsFullscreen");
        var d;
        for (d = 0; d < b.numSlides; d++) if (a = b.slides[d], a.isRendered = !1, a.bigImage) {
          a.isMedLoaded = a.isLoaded;
          a.isMedLoading = a.isLoading;
          a.medImage = a.image;
          a.medIW = a.iW;
          a.medIH = a.iH;
          a.slideId = -99;
          a.bigImage !== a.medImage && (a.sizeType = "big");
          a.isLoaded = a.isBigLoaded;
          a.isLoading = a.isBigLoading;
          a.image = a.bigImage;
          a.iW = a.bigIW;
          a.iH = a.bigIH;
          a.contentAdded = !1;
          var e = !a.isLoaded ? '<a class="rsImg" href="' + a.image + '"></a>' : '<img class="rsImg" src="' + a.image + '"/>';
          a.content.hasClass("rsImg") ? a.content = c(e) : a.content.find(".rsImg").replaceWith(e)
        }
        b.isFullscreen = !0;
        setTimeout(function() {
          b._r5 = !1;
          b.updateSliderSize()
        }, 100)
      }
    },
    exitFullscreen: function(a) {
      var b = this;
      if (b._p5) {
        if (!a) {
          b._p5.cancelFullScreen(c("html")[0]);
          return
        }
        b._a.off(b._p5.fullScreenEventName)
      }
      if (!b._r5) {
        b._r5 = !0;
        b._a.off("keyup.rsfullscreen");
        b._o5 && b._a.off("keydown.rskb");
        c("html").attr("style", b._s5 || "");
        c("body").attr("style", b._t5 || "");
        b.slider.removeClass("rsFullscreen");
        var d;
        for (d = 0; d < b.numSlides; d++) if (a = b.slides[d], a.isRendered = !1, a.bigImage) {
          a.slideId = -99;
          a.isBigLoaded = a.isLoaded;
          a.isBigLoading = a.isLoading;
          a.bigImage = a.image;
          a.bigIW = a.iW;
          a.bigIH = a.iH;
          a.isLoaded = a.isMedLoaded;
          a.isLoading = a.isMedLoading;
          a.image = a.medImage;
          a.iW = a.medIW;
          a.iH = a.medIH;
          a.contentAdded = !1;
          var e = !a.isLoaded ? '<a class="rsImg" href="' + a.image + '"></a>' : '<img class="rsImg" src="' + a.image + '"/>';
          a.content.hasClass("rsImg") ? a.content = c(e) : a.content.find(".rsImg").replaceWith(e);
          a.holder && a.holder.html(a.content);
          a.bigImage !== a.medImage && (a.sizeType = "med")
        }
        b.isFullscreen = !1;
        setTimeout(function() {
          b._r5 = !1;
          b.updateSliderSize()
        }, 100)
      }
    }
  });
  c.rsModules.fullscreen = c.rsProto._l5
})(jQuery);
// jquery.rs.global-caption v1.0
(function(b) {
  b.extend(b.rsProto, {
    _v5: function() {
      var a = this;
      a.st.globalCaption && (a.ev.on("rsAfterInit", function() {
        a.globalCaption = b('<div class="rsGCaption"></div>').appendTo(a.slider);
        a.globalCaption.html(a.currSlide.caption)
      }), a.ev.on("rsBeforeAnimStart", function() {
        a.globalCaption.html(a.currSlide.caption)
      }))
    }
  });
  b.rsModules.globalCaption = b.rsProto._v5
})(jQuery);
// jquery.rs.nav-auto-hide v1.0
(function(b) {
  b.extend(b.rsProto, {
    _s4: function() {
      var a = this;
      if (a.st.navAutoHide && !a.hasTouch) a.ev.one("rsAfterInit", function() {
        if (a._t4) {
          a._t4.addClass("rsHidden");
          var b = a.slider;
          b.one("mousemove.controlnav", function() {
            a._t4.removeClass("rsHidden")
          });
          b.hover(function() {
            a._t4.removeClass("rsHidden")
          }, function() {
            a._t4.addClass("rsHidden")
          })
        }
      })
    }
  });
  b.rsModules.autoHideNav = b.rsProto._s4
})(jQuery);
// jquery.rs.tabs v1.0.1
(function(e) {
  e.extend(e.rsProto, {
    _w5: function() {
      var a = this;
      "tabs" === a.st.controlNavigation && (a.ev.on("rsBeforeParseNode", function(a, d, b) {
        d = e(d);
        b.thumbnail = d.find(".rsTmb").remove();
        b.thumbnail.length ? b.thumbnail = e(document.createElement("div")).append(b.thumbnail).html() : (b.thumbnail = d.attr("data-rsTmb"), b.thumbnail || (b.thumbnail = d.find(".rsImg").attr("data-rsTmb")), b.thumbnail = b.thumbnail ? '<img src="' + b.thumbnail + '"/>' : "")
      }), a.ev.one("rsAfterPropsSetup", function() {
        a._x5()
      }), a.ev.on("rsOnAppendSlide", function(c, d, b) {
        b >= a.numSlides ? a._t4.append('<div class="rsNavItem rsTab">' + d.thumbnail + "</div>") : a._h5.eq(b).before('<div class="rsNavItem rsTab">' + item.thumbnail + "</div>");
        a._h5 = a._t4.children()
      }), a.ev.on("rsOnRemoveSlide", function(c, d) {
        var b = a._h5.eq(d);
        b && (b.remove(), a._h5 = a._t4.children())
      }), a.ev.on("rsOnUpdateNav", function() {
        var c = a.currSlideId;
        a._i5 && a._i5.removeClass("rsNavSelected");
        c = e(a._h5[c]);
        c.addClass("rsNavSelected");
        a._i5 = c
      }))
    },
    _x5: function() {
      var a = this,
          c, d;
      a._g5 = !0;
      c = '<div class="rsNav rsTabs">';
      for (var b = 0; b < a.numSlides; b++) b === a.numSlides - 1 && (style = ""), d = a.slides[b], c += '<div class="rsNavItem rsTab">' + d.thumbnail + "</div>";
      c = e(c + "</div>");
      a._t4 = c;
      a._h5 = c.find(".rsNavItem");
      a.slider.append(c);
      a._t4.click(function(b) {
        b = e(b.target).closest(".rsNavItem");
        b.length && a.goTo(b.index())
      })
    }
  });
  e.rsModules.tabs = e.rsProto._w5
})(jQuery);
// jquery.rs.thumbnails v1.0.2
(function(f) {
  f.extend(f.rsProto, {
    _y5: function() {
      var a = this;
      "thumbnails" === a.st.controlNavigation && (a._z5 = {
        drag: !0,
        touch: !0,
        orientation: "horizontal",
        navigation: !0,
        arrows: !0,
        arrowLeft: null,
        arrowRight: null,
        spacing: 4,
        arrowsAutoHide: !1,
        appendSpan: !1,
        transitionSpeed: 600,
        autoCenter: !0,
        fitInViewport: !0,
        firstMargin: !0
      }, a.st.thumbs = f.extend({}, a._z5, a.st.thumbs), a.ev.on("rsBeforeParseNode", function(a, b, c) {
        b = f(b);
        c.thumbnail = b.find(".rsTmb").remove();
        c.thumbnail.length ? c.thumbnail = f(document.createElement("div")).append(c.thumbnail).html() : (c.thumbnail = b.attr("data-rsTmb"), c.thumbnail || (c.thumbnail = b.find(".rsImg").attr("data-rsTmb")), c.thumbnail = c.thumbnail ? '<img src="' + c.thumbnail + '"/>' : "")
      }), a.ev.one("rsAfterPropsSetup", function() {
        a._a6()
      }), a.ev.on("rsOnUpdateNav", function() {
        var e = a.currSlideId,
            b;
        a._i5 && a._i5.removeClass("rsNavSelected");
        b = f(a._h5[e]);
        b.addClass("rsNavSelected");
        a._b6 && a._c6(e);
        a._i5 = b
      }), a.ev.on("rsOnAppendSlide", function(e, b, c) {
        e = "<div" + a._d6 + ' class="rsNavItem rsThumb">' + a._e6 + b.thumbnail + "</div>";
        c >= a.numSlides ? a._l3.append(e) : a._h5.eq(c).before(e);
        a._h5 = a._l3.children();
        a.updateThumbsSize()
      }), a.ev.on("rsOnRemoveSlide", function(e, b) {
        var c = a._h5.eq(b);
        c && (c.remove(), a._h5 = a._l3.children(), a.updateThumbsSize())
      }))
    },
    _a6: function() {
      var a = this,
          e = "rsThumbs",
          b = "",
          c, g, d = a.st.thumbs.spacing;
      a._g5 = !0;
      0 < d ? (c = d + "px ", c = ' style="margin: 0 ' + c + c + '0;"') : c = "";
      a._d6 = c;
      a._x2 = "vertical" === a.st.thumbs.orientation ? !1 : !0;
      a._b3 = 0;
      a._f6 = !1;
      a._g6 = !1;
      a._b6 = !1;
      a._h6 = a.st.thumbs.arrows && a.st.thumbs.navigation;
      g = a._x2 ? "Hor" : "Ver";
      a.slider.addClass("rsWithThumbs rsWithThumbs" + g);
      b += '<div class="rsNav rsThumbs rsThumbs' + g + '"><div class="' + e + 'Container">';
      a._e6 = a.st.thumbs.appendSpan ? '<span class="thumbIco"></span>' : "";
      for (var h = 0; h < a.numSlides; h++) g = a.slides[h], b += "<div" + c + ' class="rsNavItem rsThumb">' + a._e6 + g.thumbnail + "</div>";
      b = f(b + "</div></div>");
      a._l3 = f(b).find("." + e + "Container");
      if (a._h6 && (e += "Arrow", a.st.thumbs.arrowLeft ? a._i6 = a.st.thumbs.arrowLeft : (a._i6 = f('<div class="' + e + " " + e + 'Left"><div class="' + e + 'Icn"></div></div>'), b.append(a._i6)), a.st.thumbs.arrowRight ? a._j6 = a.st.thumbs.arrowRight : (a._j6 = f('<div class="' + e + " " + e + 'Right"><div class="' + e + 'Icn"></div></div>'), b.append(a._j6)), a._i6.click(function() {
        var b = (Math.floor(a._b3 / a._k6) + a._l6) * a._k6;
        a._t3(b > a._g3 ? a._g3 : b)
      }), a._j6.click(function() {
        var b = (Math.floor(a._b3 / a._k6) - a._l6) * a._k6;
        a._t3(b < a._h3 ? a._h3 : b)
      }), a.st.thumbs.arrowsAutoHide && !a.hasTouch)) a._i6.css("opacity", 0), a._j6.css("opacity", 0), b.one("mousemove.rsarrowshover", function() {
        if (a._b6) {
          a._i6.css("opacity", 1);
          a._j6.css("opacity", 1)
        }
      }), b.hover(function() {
        if (a._b6) {
          a._i6.css("opacity", 1);
          a._j6.css("opacity", 1)
        }
      }, function() {
        if (a._b6) {
          a._i6.css("opacity", 0);
          a._j6.css("opacity", 0)
        }
      });
      a._t4 = b;
      a._h5 = a._l3.children();
      a.slider.append(b);
      a._p3 = !0;
      a._m6 = d;
      a.st.thumbs.navigation && a._c && a._l3.css(a._e + "transition-property", a._e + "transform");
      a._t4.click(function(b) {
        if (!a._g6) {
          b = f(b.target).closest(".rsNavItem");
          b.length && a.goTo(b.index())
        }
      });
      a.ev.off("rsBeforeSizeSet.thumbs").on("rsBeforeSizeSet.thumbs", function() {
        a._n6 = a._x2 ? a._v3 : a._u3;
        a.updateThumbsSize()
      })
    },
    updateThumbsSize: function() {
      var a = this,
          e = a._h5.first(),
          b = {},
          c = a._h5.length;
      a._k6 = (a._x2 ? e.outerWidth() : e.outerHeight()) + a._m6;
      a._r3 = c * a._k6 - a._m6;
      b[a._x2 ? "width" : "height"] = a._r3 + a._m6;
      a._s3 = a._x2 ? a._t4.width() : a._t4.height();
      a._h3 = -(a._r3 - a._s3) - (a.st.thumbs.firstMargin ? a._m6 : 0);
      a._g3 = a.st.thumbs.firstMargin ? a._m6 : 0;
      a._l6 = Math.floor(a._s3 / a._k6);
      if (a._r3 < a._s3) a.st.thumbs.autoCenter && a._j3((a._s3 - a._r3) / 2), a.st.thumbs.arrows && a._i6 && (a._i6.addClass("rsThumbsArrowDisabled"), a._j6.addClass("rsThumbsArrowDisabled")), a._b6 = !1, a._g6 = !1, a._t4.off(a._f1);
      else if (a.st.thumbs.navigation && !a._b6 && (a._b6 = !0, !a.hasTouch && a.st.thumbs.drag || a.hasTouch && a.st.thumbs.touch)) a._g6 = !0, a._t4.on(a._f1, function(b) {
        a._b2(b, !0)
      });
      a._l3.css(b);
      if (a._p3 && (a.isFullscreen || a.st.thumbs.fitInViewport)) a._x2 ? a._v3 = a._n6 - a._t4.outerHeight() : a._u3 = a._n6 - a._t4.outerWidth()
    },
    setThumbsOrientation: function(a, e) {
      this._p3 && (this.st.thumbs.orientation = a, this._t4.remove(), this.slider.removeClass("rsWithThumbsHor rsWithThumbsVer"), this._a6(), this._t4.off(this._f1), e || this.updateSliderSize(!0))
    },
    _j3: function(a) {
      this._b3 = a;
      this._c ? this._l3.css(this._r1, this._s1 + (this._x2 ? a + this._t1 + 0 : 0 + this._t1 + a) + this._u1) : this._l3.css(this._x2 ? this._r1 : this._q1, a)
    },
    _t3: function(a, e, b, c, g) {
      var d = this;
      if (d._b6) {
        e || (e = d.st.thumbs.transitionSpeed);
        d._b3 = a;
        d._o6 && clearTimeout(d._o6);
        d._f6 && (d._c || d._l3.stop(), b = !0);
        var h = {};
        d._f6 = !0;
        d._c ? (h[d._e + "transition-duration"] = e + "ms", h[d._e + "transition-timing-function"] = b ? f.rsCSS3Easing[d.st.easeOut] : f.rsCSS3Easing[d.st.easeInOut], d._l3.css(h), d._j3(a)) : (h[d._x2 ? d._r1 : d._q1] = a + "px", d._l3.animate(h, e, b ? "easeOutCubic" : d.st.easeInOut));
        c && (d._b3 = c);
        d._p6();
        d._o6 = setTimeout(function() {
          d._f6 = false;
          if (g) {
            d._t3(c, g, true);
            g = null
          }
        }, e)
      }
    },
    _p6: function() {
      this._h6 && (this._b3 === this._g3 ? this._i6.addClass("rsThumbsArrowDisabled") : this._i6.removeClass("rsThumbsArrowDisabled"), this._b3 === this._h3 ? this._j6.addClass("rsThumbsArrowDisabled") : this._j6.removeClass("rsThumbsArrowDisabled"))
    },
    _c6: function(a, e) {
      var b = 0,
          c, f = a * this._k6 + 2 * this._k6 - this._m6 + this._g3,
          d = Math.floor(this._b3 / this._k6);
      this._b6 && (f + this._b3 > this._s3 ? (a === this.numSlides - 1 && (b = 1), d = -a + this._l6 - 2 + b, c = d * this._k6 + this._s3 % this._k6 + this._m6 - this._g3) : 0 !== a ? (a - 1) * this._k6 <= -this._b3 + this._g3 && a - 1 <= this.numSlides - this._l6 && (c = (-a + 1) * this._k6 + this._g3) : c = this._g3, c !== this._b3 && (b = void 0 === c ? this._b3 : c, b > this._g3 ? this._j3(this._g3) : b < this._h3 ? this._j3(this._h3) : void 0 !== c && (e ? this._j3(c) : this._t3(c))), this._p6())
    }
  });
  f.rsModules.thumbnails = f.rsProto._y5
})(jQuery);
// jquery.rs.video v1.0.3
(function(e) {
  e.extend(e.rsProto, {
    _q6: function() {
      var a = this;
      a._r6 = {
        autoHideArrows: !0,
        autoHideControlNav: !1,
        autoHideBlocks: !1,
        youTubeCode: '<iframe src="http://www.youtube.com/embed/%id%?rel=1&autoplay=1&showinfo=0&autoplay=1" frameborder="no"></iframe>',
        vimeoCode: '<iframe src="http://player.vimeo.com/video/%id%?byline=0&amp;portrait=0&amp;autoplay=1" frameborder="no" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
      };
      a.st.video = e.extend({}, a._r6, a.st.video);
      a.ev.on("rsBeforeSizeSet", function() {
        a._d4 && setTimeout(function() {
          var b = a._d1,
              b = b.hasClass("rsVideoContainer") ? b : b.find(".rsVideoContainer");
          a._s6.css({
            width: b.width(),
            height: b.height()
          })
        }, 32)
      });
      var d = e.browser.mozilla;
      a.ev.on("rsAfterParseNode", function(b, f, c) {
        b = e(f);
        if (c.videoURL) {
          d && (a._c = a._d = !1);
          var f = e('<div class="rsVideoContainer"></div>'),
              g = e('<div class="rsBtnCenterer"><div class="rsPlayBtn"><div class="rsPlayBtnIcon"></div></div></div>');
          b.hasClass("rsImg") ? c.content = f.append(b).append(g) : c.content.find(".rsImg").wrap(f).after(g)
        }
      })
    },
    toggleVideo: function() {
      return this._d4 ? this.stopVideo() : this.playVideo()
    },
    playVideo: function() {
      var a = this;
      if (!a._d4) {
        var d = a.currSlide;
        if (!d.videoURL) return !1;
        var b = a._t6 = d.content,
            d = d.videoURL,
            f, c;
        d.match(/youtu\.be/i) || d.match(/youtube\.com\/watch/i) ? (c = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/, (c = d.match(c)) && 11 == c[7].length && (f = c[7]), void 0 !== f && (a._s6 = a.st.video.youTubeCode.replace("%id%", f))) : d.match(/vimeo\.com/i) && (c = /\/\/(www\.)?vimeo.com\/(\d+)($|\/)/, (c = d.match(c)) && (f = c[2]), void 0 !== f && (a._s6 = a.st.video.vimeoCode.replace("%id%", f)));
        a.videoObj = e(a._s6);
        a.ev.trigger("rsOnCreateVideoElement", [d]);
        a.videoObj.length && (a._s6 = e('<div class="rsVideoFrameHolder"><div class="rsPreloader"></div><div class="rsCloseVideoBtn"><div class="rsCloseVideoIcn"></div></div></div>'), a._s6.find(".rsPreloader").after(a.videoObj), b = b.hasClass("rsVideoContainer") ? b : b.find(".rsVideoContainer"), a._s6.css({
          width: b.width(),
          height: b.height()
        }).find(".rsCloseVideoBtn").off("click.rsv").on("click.rsv", function(b) {
          a.stopVideo();
          b.preventDefault();
          b.stopPropagation();
          return false
        }), b.append(a._s6), a.isIPAD && b.addClass("rsIOSVideo"), a._w1 && a.st.video.autoHideArrows && (a._w1.addClass("rsHidden"), a._x1.addClass("rsHidden"), a._y1 = !0), a._t4 && a.st.video.autoHideControlNav && a._t4.addClass("rsHidden"), a.st.video.autoHideBlocks && a.currSlide.animBlocks && a.currSlide.animBlocks.addClass("rsHidden"), setTimeout(function() {
          a._s6.addClass("rsVideoActive")
        }, 10), a.ev.trigger("rsVideoPlay"), a._d4 = !0);
        return !0
      }
      return !1
    },
    stopVideo: function() {
      var a = this;
      return a._d4 ? (a.isIPAD && a.slider.find(".rsCloseVideoBtn").remove(), a._w1 && a.st.video.autoHideArrows && (a._w1.removeClass("rsHidden"), a._x1.removeClass("rsHidden"), a._y1 = !1), a._t4 && a.st.video.autoHideControlNav && a._t4.removeClass("rsHidden"), a.st.video.autoHideBlocks && a.currSlide.animBlocks && a.currSlide.animBlocks.removeClass("rsHidden"), setTimeout(function() {
        a._s6.remove()
      }, 16), a.ev.trigger("rsVideoStop"), a._d4 = !1, !0) : !1
    }
  });
  e.rsModules.video = e.rsProto._q6
})(jQuery);
