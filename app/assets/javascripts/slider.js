// jquery.royalslider v9.3.73
(function (l) {
  function v(b, f) {
    var c = navigator.userAgent.toLowerCase(),
      g = l.browser,
      a = this,
      e = g.webkit || g.chrome;
    a.isIPAD = c.match(/(ipad)/);
    for (var d = document.createElement("div").style, j = ["webkit", "Moz", "ms", "O"], h = "", k = 0, m, c = 0; c < j.length; c++) m = j[c], !h && m + "Transform" in d && (h = m), m = m.toLowerCase(), window.requestAnimationFrame || (window.requestAnimationFrame = window[m + "RequestAnimationFrame"], window.cancelAnimationFrame = window[m + "CancelAnimationFrame"] || window[m + "CancelRequestAnimationFrame"]);
    window.requestAnimationFrame || (window.requestAnimationFrame = function (a) {
      var b = (new Date).getTime(),
        c = Math.max(0, 16 - (b - k)),
        d = window.setTimeout(function () {
          a(b + c)
        }, c);
      k = b + c;
      return d
    });
    window.cancelAnimationFrame || (window.cancelAnimationFrame = function (a) {
      clearTimeout(a)
    });
    a.slider = l(b);
    a.ev = l(a);
    a._a = l(document);
    a.st = l.extend({}, l.fn.royalSlider.defaults, f);
    a._b = a.st.transitionSpeed;
    a._c = 0;
    if (a.st.allowCSS3 && (!e || a.st.allowCSS3OnWebkit)) c = h + (h ? "T" : "t"), a._d = c + "ransform" in d && c + "ransition" in d, a._d && (a._e = h + (h ? "P" : "p") + "erspective" in d);
    h = h.toLowerCase();
    a._f = "-" + h + "-";
    a._g = "vertical" === a.st.slidesOrientation ? !1 : !0;
    a._h = a._g ? "left" : "top";
    a._i = a._g ? "width" : "height";
    a._j = -1;
    a._k = "fade" === a.st.transitionType ? !1 : !0;
    a._k || (a.st.sliderDrag = !1, a._l = 10);
    a._m = "z-index:0; display:none; opacity:0;";
    a._n = 0;
    a._o = 0;
    a._p = 0;
    l.each(l.rsModules, function (b, c) {
      c.call(a)
    });
    a.slides = [];
    a._q = 0;
    (a.st.slides ? l(a.st.slides) : a.slider.children().detach()).each(function () {
      a._r(this, !0)
    });
    a.st.randomizeSlides && a.slides.sort(function () {
      return 0.5 - Math.random()
    });
    a.numSlides = a.slides.length;
    a._s();
    a.st.startSlideId ? a.st.startSlideId > a.numSlides - 1 && (a.st.startSlideId = a.numSlides - 1) : a.st.startSlideId = 0;
    a.staticSlideId = a.currSlideId = a._t = a.st.startSlideId;
    a.currSlide = a.slides[a.currSlideId];
    a._u = 0;
    a.msTouch = !1;
    a.slider.addClass((a._g ? "rsHor" : "rsVer") + (a._k ? "" : " rsFade"));
    d = '<div class="rsOverflow"><div class="rsContainer">';
    a.slidesSpacing = a.st.slidesSpacing;
    a._v = (a._g ? a.slider.width() : a.slider.height()) + a.st.slidesSpacing;
    a._w = Boolean(0 < a._x);
    1 >= a.numSlides && (a._y = !1);
    a._z = a._y && a._k ? 2 === a.numSlides ? 1 : 2 : 0;
    a._a1 = 6 > a.numSlides ? a.numSlides : 6;
    a._b1 = 0;
    a._c1 = 0;
    a.slidesJQ = [];
    for (c = 0; c < a.numSlides; c++) a.slidesJQ.push(l('<div style="' + (a._k ? "" : c !== a.currSlideId ? a._m : "z-index:0;") + '" class="rsSlide "></div>'));
    a._d1 = d = l(d + "</div></div>");
    c = function () {
      a.st.sliderDrag && (a._e1 = !0, g.msie || g.opera ? a._f1 = a._g1 = "move" : g.mozilla ? (a._f1 = "-moz-grab", a._g1 = "-moz-grabbing") : e && -1 != navigator.platform.indexOf("Mac") && (a._f1 = "-webkit-grab", a._g1 = "-webkit-grabbing"), a._h1())
    };
    h = function (b, c, d, e, f) {
      a._i1 = b + c + ".rs";
      a._j1 = b + d + ".rs";
      a._k1 = b + e + ".rs";
      f && (a._l1 = b + f + ".rs")
    };
    a.msEnabled = window.navigator.msPointerEnabled;
    a.msEnabled ? (a.msTouch = Boolean(1 < window.navigator.msMaxTouchPoints), a.hasTouch = !1, a._m1 = 0.2, h("MSPointer", "Down", "Move", "Up", "Cancel"), c()) : "ontouchstart" in window || "createTouch" in document ? (a.hasTouch = !0, h("touch", "start", "move", "end", "cancel"), a._m1 = 0.5, a.st.sliderTouch && (a._e1 = !0)) : (a.hasTouch = !1, a._m1 = 0.2, c(), h("mouse", "down", "move", "up", "up"));
    a.slider.html(d);
    a._n1 = a.st.controlsInside ? a._d1 : a.slider;
    a._o1 = a._d1.children(".rsContainer");
    a.msEnabled && a._o1.css("-ms-touch-action", a._g ? "pan-y" : "pan-x");
    a._p1 = l('<div class="rsPreloader"></div>');
    c = a._o1.children(".rsSlide");
    a._q1 = a.slidesJQ[a.currSlideId];
    a._r1 = 0;
    a._d ? (a._s1 = "transition-property", a._t1 = "transition-duration", a._u1 = "transition-timing-function", a._v1 = a._w1 = a._f + "transform", a._e ? (e && a.slider.addClass("rsWebkit3d"), a._x1 = "translate3d(", a._y1 = "px, ", a._z1 = "px, 0px)") : (a._x1 = "translate(", a._y1 = "px, ",
    a._z1 = "px)"), a._k ? a._o1[a._f + a._s1] = a._f + "transform" : (d = {}, d[a._f + a._s1] = "opacity", d[a._f + a._t1] = a.st.transitionSpeed + "ms", d[a._f + a._u1] = a.st.css3easeInOut, c.css(d))) : (a._w1 = "left", a._v1 = "top");
    var n;
    l(window).on("resize.rs", function () {
      n && clearTimeout(n);
      n = setTimeout(function () {
        a.updateSliderSize()
      }, 50)
    });
    a.ev.trigger("rsAfterPropsSetup");
    a.updateSliderSize();
    a.st.keyboardNavEnabled && a._a2();
    if (a.st.arrowsNavHideOnTouch && (a.hasTouch || a.msTouch)) a.st.arrowsNav = !1;
    a.st.arrowsNav && (c = a._n1, l('<div class="rsArrow rsArrowLeft"><div class="rsArrowIcn"></div></div><div class="rsArrow rsArrowRight"><div class="rsArrowIcn"></div></div>').appendTo(c),
    a._b2 = c.children(".rsArrowLeft").click(function (b) {
      b.preventDefault();
      a.prev()
    }), a._c2 = c.children(".rsArrowRight").click(function (b) {
      b.preventDefault();
      a.next()
    }), a.st.arrowsNavAutoHide && !a.hasTouch && (a._b2.addClass("rsHidden"), a._c2.addClass("rsHidden"), c.one("mousemove.arrowshover", function () {
      a._b2.removeClass("rsHidden");
      a._c2.removeClass("rsHidden")
    }), c.hover(function () {
      a._d2 || (a._b2.removeClass("rsHidden"), a._c2.removeClass("rsHidden"))
    }, function () {
      a._d2 || (a._b2.addClass("rsHidden"), a._c2.addClass("rsHidden"))
    })),
    a.ev.on("rsOnUpdateNav", function () {
      a._e2()
    }), a._e2());
    if (a._e1) a._o1.on(a._i1, function (b) {
      a._f2(b)
    });
    else a.dragSuccess = !1;
    var p = ["rsPlayBtnIcon", "rsPlayBtn", "rsCloseVideoBtn", "rsCloseVideoIcn"];
    a._o1.click(function (b) {
      if (!a.dragSuccess) {
        var c = l(b.target).attr("class");
        if (-1 !== l.inArray(c, p) && a.toggleVideo()) return !1;
        if (a.st.navigateByClick && !a._g2) {
          if (l(b.target).closest(".rsNoDrag", a._q1).length) return !0;
          a._h2(b)
        }
        a.ev.trigger("rsSlideClick")
      }
    }).on("click.rs", "a", function () {
      if (a.dragSuccess) return !1;
      a._g2 = !0;
      setTimeout(function () {
        a._g2 = !1
      }, 3)
    });
    a.ev.trigger("rsAfterInit")
  }
  l.rsModules || (l.rsModules = {});
  v.prototype = {
    _h2: function (b) {
      b = b[this._g ? "pageX" : "pageY"] - this._i2;
      b >= this._p ? this.next() : 0 > b && this.prev()
    },
    _s: function () {
      var b;
      b = this.st.numImagesToPreload;
      if (this._y = this.st.loop) 2 === this.numSlides ? (this._y = !1, this.st.loopRewind = !0) : 2 > this.numSlides && (this.st.loopRewind = this._y = !1);
      this._y && 0 < b && (4 >= this.numSlides ? b = 1 : this.st.numImagesToPreload > (this.numSlides - 1) / 2 && (b = Math.floor((this.numSlides - 1) / 2)));
      this._x = b
    },
    _r: function (b, f) {
      function c(a, b) {
        b ? e.images.push(a.attr(b)) : e.images.push(a.text());
        if (j) {
          j = !1;
          e.caption = "src" === b ? a.attr("alt") : a.contents();
          e.image = e.images[0];
          e.videoURL = a.attr("data-rsVideo");
          var c = a.attr("data-rsw"),
            d = a.attr("data-rsh");
          "undefined" !== typeof c && !1 !== c && "undefined" !== typeof d && !1 !== d ? (e.iW = parseInt(c), e.iH = parseInt(d)) : g.st.imgWidth && g.st.imgHeight && (e.iW = g.st.imgWidth, e.iH = g.st.imgHeight)
        }
      }
      var g = this,
        a, e = {}, d, j = !0;
      b = l(b);
      g._j2 = b;
      g.ev.trigger("rsBeforeParseNode", [b, e]);
      if (!e.stopParsing) return b = g._j2, e.id = g._q, e.contentAdded = !1, g._q++, e.images = [], e.isBig = !1, e.hasCover || (b.hasClass("rsImg") ? (d = b, a = !0) : (d = b.find(".rsImg"), d.length && (a = !0)), a ? (e.bigImage = d.eq(0).attr("data-rsBigImg"), d.each(function () {
        var a = l(this);
        a.is("a") ? c(a, "href") : a.is("img") ? c(a, "src") : c(a)
      })) : b.is("img") && (b.addClass("rsImg rsMainSlideImage"), c(b, "src"))), d = b.find(".rsCaption"), d.length && (e.caption = d.remove()), e.content = b, g.ev.trigger("rsAfterParseNode", [b, e]), f && g.slides.push(e), 0 === e.images.length && (e.isLoaded = !0, e.isRendered = !1, e.isLoading = !1, e.images = null), e
    },
    _a2: function () {
      var b = this,
        f, c, g = function (a) {
          37 === a ? b.prev() : 39 === a && b.next()
        };
      b._a.on("keydown.rskb", function (a) {
        if (!b._k2 && (c = a.keyCode, (37 === c || 39 === c) && !f)) g(c), f = setInterval(function () {
          g(c)
        }, 700)
      }).on("keyup.rskb", function () {
        f && (clearInterval(f), f = null)
      })
    },
    goTo: function (b, f) {
      b !== this.currSlideId && this._l2(b, this.st.transitionSpeed, !0, !f)
    },
    destroy: function (b) {
      this.ev.trigger("rsBeforeDestroy");
      this._a.off("keydown.rskb keyup.rskb " + this._j1 + " " + this._k1);
      this._o1.off(this._i1 + " click");
      this.slider.data("royalSlider", null);
      l.removeData(this.slider, "royalSlider");
      l(window).off("resize.rs");
      b && this.slider.remove();
      this.ev = this.slider = this.slides = null
    },
    _m2: function (b, f) {
      function c(c, e, f) {
        c.isAdded ? (g(e, c), a(e, c)) : (f || (f = d.slidesJQ[e]), c.holder ? f = c.holder : (f = d.slidesJQ[e] = l(f), c.holder = f), c.appendOnLoaded = !1, a(e, c, f), g(e, c), d._o2(c, f, b), appended = c.isAdded = !0)
      }
      function g(a, c) {
        c.contentAdded || (d.setItemHtml(c, b), b || (c.contentAdded = !0))
      }
      function a(a, b, c) {
        d._k && (c || (c = d.slidesJQ[a]), c.css(d._h, (a + d._c1 + p) * d._v))
      }
      function e(a) {
        if (k) {
          if (a > m - 1) return e(a - m);
          if (0 > a) return e(m + a)
        }
        return a
      }
      var d = this,
        j, h, k = d._y,
        m = d.numSlides;
      if (!isNaN(f)) return e(f);
      var n = d.currSlideId,
        p, q = b ? Math.abs(d._n2 - d.currSlideId) >= d.numSlides - 1 ? 0 : 1 : d._x,
        r = Math.min(2, q),
        t = !1,
        u = !1,
        s;
      for (h = n; h < n + 1 + r; h++) if (s = e(h), (j = d.slides[s]) && (!j.isAdded || !j.positionSet)) {
        t = !0;
        break
      }
      for (h = n - 1; h > n - 1 - r; h--) if (s = e(h), (j = d.slides[s]) && (!j.isAdded || !j.positionSet)) {
        u = !0;
        break
      }
      if (t) for (h = n; h < n + q + 1; h++) s = e(h), p = Math.floor((d._t - (n - h)) / d.numSlides) * d.numSlides, (j = d.slides[s]) && c(j, s);
      if (u) for (h = n - 1; h > n - 1 - q; h--) s = e(h), p = Math.floor((d._t - (n - h)) / m) * m, (j = d.slides[s]) && c(j, s);
      if (!b) {
        r = e(n - q);
        n = e(n + q);
        q = r > n ? 0 : r;
        for (h = 0; h < m; h++) if (!(r > n && h > r - 1) && (h < q || h > n)) if ((j = d.slides[h]) && j.holder) j.holder.detach(), j.isAdded = !1
      }
    },
    setItemHtml: function (b, f) {
      function c() {
        if (b.images) {
          if (!b.isLoading) {
            var a, c;
            b.content.hasClass("rsImg") ? (a = b.content, c = !0) : a = b.content.find(".rsImg:not(img)");
            a && !a.is("img") && a.each(function () {
              var a = l(this),
                d = '<img class="rsImg" src="' + (a.is("a") ? a.attr("href") : a.text()) + '" />';
              c ? b.content = l(d) : a.replaceWith(d)
            });
            a = c ? b.content : b.content.find("img.rsImg");
            j();
            a.eq(0).addClass("rsMainSlideImage");
            b.iW && b.iH && (b.isLoaded || k._p2(b), e());
            b.isLoading = !0;
            if (b.isBig) l("<img />").on("load.rs error.rs", function () {
              g([this], !0)
            }).attr("src", b.image);
            else {
              b.loaded = [];
              b.imgLoaders = [];
              for (a = 0; a < b.images.length; a++) {
                var d = l("<img />");
                b.imgLoaders.push(this);
                d.on("load.rs error.rs", function () {
                  b.loaded.push(this);
                  b.loaded.length === b.imgLoaders.length && (l.browser.mozilla ? setTimeout(function () {
                    g(b.loaded, !1)
                  }, 1) : g(b.loaded, !1))
                }).attr("src", b.images[a])
              }
            }
          }
        } else b.isRendered = !0, b.isLoaded = !0, b.isLoading = !1, e(!0)
      }
      function g(c, d) {
        if (c.length) {
          var e = c[0];
          if (d !== b.isBig)(e = b.holder.children()) && 1 < e.length && h();
          else if (b.iW && b.iH) a();
          else if (b.iW = e.width, b.iH = e.height, b.iW && b.iH) a();
          else {
            var f = new Image;
            f.onload = function () {
              f.width ? (b.iW = f.width, b.iH = f.height, a()) : setTimeout(function () {
                f.width && (b.iW = f.width, b.iH = f.height);
                a()
              }, 1E3)
            };
            f.src = e.src
          }
        } else a()
      }
      function a() {
        b.isLoaded = !0;
        b.isLoading = !1;
        e();
        h();
        d()
      }
      function e() {
        if (!b.isAppended) {
          var a = k.st.visibleNearby,
            c = b.id - k._n;
          if (!f && !b.appendOnLoaded && k.st.fadeinLoadedSlide && (0 === c || (a || k._q2 || k._k2) && (-1 === c || 1 === c))) a = {
            visibility: "visible",
            opacity: 0
          }, a[k._f + "transition"] = "opacity 400ms ease-in-out", b.content.css(a), setTimeout(function () {
            b.content.css("opacity", 1)
          }, 16);
          b.holder.find(".rsPreloader").length ? b.holder.append(b.content) : b.holder.html(b.content);
          b.isAppended = !0;
          b.isLoaded && (k._p2(b), d());
          b.sizeReady || (b.sizeReady = !0, setTimeout(function () {
            k.ev.trigger("rsMaybeSizeReady", b)
          }, 100))
        }
      }
      function d() {
        b.loadedTriggered || (b.isLoaded = b.loadedTriggered = !0, b.holder.trigger("rsAfterContentSet"), k.ev.trigger("rsAfterContentSet", b))
      }
      function j() {
        k.st.usePreloader && b.holder.html(k._p1.clone())
      }
      function h() {
        if (k.st.usePreloader) {
          var a = b.holder.find(".rsPreloader");
          a.length && a.remove()
        }
      }
      var k = this;
      b.isLoaded ? e() : f ? !k._k && b.images && b.iW && b.iH ? c() : (b.holder.isWaiting = !0, j(), b.holder.slideId = -99) : c()
    },
    _o2: function (b) {
      this._o1.append(b.holder);
      b.appendOnLoaded = !1
    },
    _f2: function (b, f) {
      var c = this,
        g;
      c.ev.trigger("rsDragStart");
      if (l(b.target).closest(".rsNoDrag", c._q1).length) return c.dragSuccess = !1, !0;
      !f && c._q2 && (c._r2 = !0, c._s2());
      c.dragSuccess = !1;
      if (c._k2) c.hasTouch && (c._t2 = !0);
      else {
        c.hasTouch && (c._t2 = !1);
        c._u2();
        if (c.hasTouch) {
          var a = b.originalEvent.touches;
          if (a && 0 < a.length) g = a[0], 1 < a.length && (c._t2 = !0);
          else return
        } else b.preventDefault(), g = b, c.msEnabled && (g = g.originalEvent);
        c._k2 = !0;
        c._a.on(c._j1, function (a) {
          c._v2(a, f)
        }).on(c._k1, function (a) {
          c._w2(a, f)
        });
        c._x2 = "";
        c._y2 = !1;
        c._z2 = g.pageX;
        c._a3 = g.pageY;
        c._b3 = c._u = (!f ? c._g : c._c3) ? g.pageX : g.pageY;
        c._d3 = 0;
        c._e3 = 0;
        c._f3 = !f ? c._o : c._g3;
        c._h3 = (new Date).getTime();
        if (c.hasTouch) c._d1.on(c._l1, function (a) {
          c._w2(a, f)
        })
      }
    },
    _i3: function (b, f) {
      if (this._j3) {
        var c = this._k3,
          g = b.pageX - this._z2,
          a = b.pageY - this._a3,
          e = this._f3 + g,
          d = this._f3 + a,
          j = !f ? this._g : this._c3,
          e = j ? e : d,
          d = this._x2;
        this._y2 = !0;
        this._z2 = b.pageX;
        this._a3 = b.pageY;
        "x" === d && 0 !== g ? this._d3 = 0 < g ? 1 : -1 : "y" === d && 0 !== a && (this._e3 = 0 < a ? 1 : -1);
        d = j ? this._z2 : this._a3;
        g = j ? g : a;
        f ? e > this._l3 ? e = this._f3 + g * this._m1 : e < this._m3 && (e = this._f3 + g * this._m1) : this._y || (0 >= this.currSlideId && 0 < d - this._b3 && (e = this._f3 + g * this._m1), this.currSlideId >= this.numSlides - 1 && 0 > d - this._b3 && (e = this._f3 + g * this._m1));
        this._f3 = e;
        200 < c - this._h3 && (this._h3 = c, this._u = d);
        f ? this._o3(this._f3) : this._k && this._n3(this._f3)
      }
    },
    _v2: function (b, f) {
      var c = this,
        g;
      if (c.hasTouch) {
        if (c._p3) return;
        var a = b.originalEvent.touches;
        if (a) {
          if (1 < a.length) return;
          g = a[0]
        } else return
      } else g = b, c.msEnabled && (g = g.originalEvent);
      c._y2 || (c._d && (!f ? c._o1 : c._q3).css(c._f + c._t1, "0s"), function d() {
        c._k2 && (c._r3 = requestAnimationFrame(d), c._s3 && c._i3(c._s3, f))
      }());
      if (c._j3) b.preventDefault(), c._k3 = (new Date).getTime(), c._s3 = g;
      else if (a = !f ? c._g : c._c3, g = Math.abs(g.pageX - c._z2) - Math.abs(g.pageY - c._a3) - (a ? -7 : 7), 7 < g) {
        if (a) b.preventDefault(), c._x2 = "x";
        else if (c.hasTouch) {
          c._t3();
          return
        }
        c._j3 = !0
      } else if (-7 > g) {
        if (a) {
          if (c.hasTouch) {
            c._t3();
            return
          }
        } else b.preventDefault(),
        c._x2 = "y";
        c._j3 = !0
      }
    },
    _t3: function () {
      this._p3 = !0;
      this._y2 = this._k2 = !1;
      this._w2()
    },
    _w2: function (b, f) {
      function c(a) {
        return 100 > a ? 100 : 500 < a ? 500 : a
      }
      function g(b, d) {
        if (a._k || f) j = (-a._t - a._c1) * a._v, h = Math.abs(a._o - j), a._b = h / d, b && (a._b += 250), a._b = c(a._b), a._v3(j, !1)
      }
      var a = this,
        e, d, j, h;
      a.ev.trigger("rsDragRelease");
      a._s3 = null;
      a._k2 = !1;
      a._p3 = !1;
      a._j3 = !1;
      a._k3 = 0;
      cancelAnimationFrame(a._r3);
      a._y2 && (f ? a._o3(a._f3) : a._k && a._n3(a._f3));
      a._a.off(a._j1).off(a._k1);
      a.hasTouch && a._d1.off(a._l1);
      a._h1();
      if (!a._y2 && !a._t2 && f && a._u3) {
        var k = l(b.target).closest(".rsNavItem");
        k.length && a.goTo(k.index())
      } else {
        d = !f ? a._g : a._c3;
        if (!a._y2 || "y" === a._x2 && d || "x" === a._x2 && !d) if (!f && a._r2) {
          a._r2 = !1;
          if (a.st.navigateByClick) {
            a._h2(a.msEnabled ? b.originalEvent : b);
            a.dragSuccess = !0;
            return
          }
          a.dragSuccess = !0
        } else {
          a._r2 = !1;
          a.dragSuccess = !1;
          return
        } else a.dragSuccess = !0;
        a._r2 = !1;
        a._x2 = "";
        var m = a.st.minSlideOffset;
        e = a.hasTouch ? b.originalEvent.changedTouches[0] : a.msEnabled ? b.originalEvent : b;
        var n = d ? e.pageX : e.pageY,
          p = a._b3;
        e = a._u;
        var q = a.currSlideId,
          r = a.numSlides,
          t = d ? a._d3 : a._e3,
          u = a._y;
        Math.abs(n - p);
        e = n - e;
        d = (new Date).getTime() - a._h3;
        d = Math.abs(e) / d;
        if (0 === t || 1 >= r) g(!0, d);
        else {
          if (!u && !f) if (0 >= q) {
            if (0 < t) {
              g(!0, d);
              return
            }
          } else if (q >= r - 1 && 0 > t) {
            g(!0, d);
            return
          }
          if (f) {
            j = a._g3;
            if (j > a._l3) j = a._l3;
            else if (j < a._m3) j = a._m3;
            else {
              m = d * d / 0.006;
              k = -a._g3;
              n = a._w3 - a._x3 + a._g3;
              0 < e && m > k ? (k += a._x3 / (15 / (0.003 * (m / d))), d = d * k / m, m = k) : 0 > e && m > n && (n += a._x3 / (15 / (0.003 * (m / d))), d = d * n / m, m = n);
              k = Math.max(Math.round(d / 0.003), 50);
              j += m * (0 > e ? -1 : 1);
              if (j > a._l3) {
                a._y3(j, k, !0, a._l3, 200);
                return
              }
              if (j < a._m3) {
                a._y3(j, k, !0, a._m3, 200);
                return
              }
            }
            a._y3(j, k, !0)
          } else p + m < n ? 0 > t ? g(!1, d) : a._l2("prev", c(Math.abs(a._o - (-a._t - a._c1 + 1) * a._v) / d), !1, !0, !0) : p - m > n ? 0 < t ? g(!1, d) : a._l2("next", c(Math.abs(a._o - (-a._t - a._c1 - 1) * a._v) / d), !1, !0, !0) : g(!1, d)
        }
      }
    },
    _n3: function (b) {
      b = this._o = b;
      this._d ? this._o1.css(this._w1, this._x1 + (this._g ? b + this._y1 + 0 : 0 + this._y1 + b) + this._z1) : this._o1.css(this._g ? this._w1 : this._v1, b)
    },
    updateSliderSize: function (b) {
      var f, c;
      if (this.st.autoScaleSlider) {
        var g = this.st.autoScaleSliderWidth,
          a = this.st.autoScaleSliderHeight;
        this.st.autoScaleHeight ? (f = this.slider.width(), f != this.width && (this.slider.css("height", f * (a / g)), f = this.slider.width()), c = this.slider.height()) : (c = this.slider.height(), c != this.height && (this.slider.css("width", c * (g / a)), c = this.slider.height()), f = this.slider.width())
      } else f = this.slider.width(), c = this.slider.height();
      if (b || f != this.width || c != this.height) {
        this.width = f;
        this.height = c;
        this._z3 = f;
        this._a4 = c;
        this.ev.trigger("rsBeforeSizeSet");
        this.ev.trigger("rsAfterSizePropSet");
        this._d1.css({
          width: this._z3,
          height: this._a4
        });
        this._v = (this._g ? this._z3 : this._a4) + this.st.slidesSpacing;
        this._b4 = this.st.imageScalePadding;
        for (f = 0; f < this.slides.length; f++) b = this.slides[f], b.positionSet = !1, b && (b.images && b.isLoaded) && (b.isRendered = !1, this._p2(b));
        if (this._c4) for (f = 0; f < this._c4.length; f++) b = this._c4[f], b.holder.css(this._h, (b.id + this._c1) * this._v);
        this._m2();
        this._k && (this._d && this._o1.css(this._f + "transition-duration", "0s"), this._n3((-this._t - this._c1) * this._v));
        this.ev.trigger("rsOnUpdateNav")
      }
      this._i2 = this._d1.offset();
      this._i2 = this._i2[this._h]
    },
    appendSlide: function (b, f) {
      var c = this._r(b);
      if (isNaN(f) || f > this.numSlides) f = this.numSlides;
      this.slides.splice(f, 0, c);
      this.slidesJQ.splice(f, 0, '<div style="' + (this._k ? "position:absolute;" : this._m) + '" class="rsSlide"></div>');
      f < this.currSlideId && this.currSlideId++;
      this.ev.trigger("rsOnAppendSlide", [c, f]);
      this._e4(f);
      f === this.currSlideId && this.ev.trigger("rsAfterSlideChange")
    },
    removeSlide: function (b) {
      var f = this.slides[b];
      f && (f.holder && f.holder.remove(), b < this.currSlideId && this.currSlideId--, this.slides.splice(b, 1), this.slidesJQ.splice(b, 1), this.ev.trigger("rsOnRemoveSlide", [b]), this._e4(b), b === this.currSlideId && this.ev.trigger("rsAfterSlideChange"))
    },
    _e4: function () {
      var b = this,
        f = b.numSlides,
        f = 0 >= b._t ? 0 : Math.floor(b._t / f);
      b.numSlides = b.slides.length;
      0 === b.numSlides ? (b.currSlideId = b._c1 = b._t = 0, b.currSlide = b._f4 = null) : b._t = f * b.numSlides + b.currSlideId;
      for (f = 0; f < b.numSlides; f++) b.slides[f].id = f;
      b.currSlide = b.slides[b.currSlideId];
      b._q1 = b.slidesJQ[b.currSlideId];
      b.currSlideId >= b.numSlides ? b.goTo(b.numSlides - 1) : 0 > b.currSlideId && b.goTo(0);
      b._s();
      b._k && b._y && b._o1.css(b._f + b._t1, "0ms");
      b._g4 && clearTimeout(b._g4);
      b._g4 = setTimeout(function () {
        b._k && b._n3((-b._t - b._c1) * b._v);
        b._m2();
        b._k || b._q1.css({
          display: "block",
          opacity: 1
        })
      }, 14);
      b.ev.trigger("rsOnUpdateNav")
    },
    _h1: function () {
      this._e1 && (!this.hasTouch && this._k) && (this._f1 ? this._d1.css("cursor", this._f1) : (this._d1.removeClass("grabbing-cursor"), this._d1.addClass("grab-cursor")))
    },
    _u2: function () {
      this._e1 && (!this.hasTouch && this._k) && (this._g1 ? this._d1.css("cursor", this._g1) : (this._d1.removeClass("grab-cursor"), this._d1.addClass("grabbing-cursor")))
    },
    next: function (b) {
      this._l2("next", this.st.transitionSpeed, !0, !b)
    },
    prev: function (b) {
      this._l2("prev", this.st.transitionSpeed, !0, !b)
    },
    _l2: function (b, f, c, g, a) {
      var e = this,
        d, j, h;
      e._i4 && e.stopVideo();
      e.ev.trigger("rsBeforeMove", [b, g]);
      newItemId = "next" === b ? e.currSlideId + 1 : "prev" === b ? e.currSlideId - 1 : b = parseInt(b, 10);
      if (!e._y) {
        if (0 > newItemId) {
          e._j4("left", !g);
          return
        }
        if (newItemId >= e.numSlides) {
          e._j4("right", !g);
          return
        }
      }
      e._q2 && (e._s2(!0), c = !1);
      j = newItemId - e.currSlideId;
      h = e._n2 = e.currSlideId;
      var k = e.currSlideId + j;
      g = e._t;
      var m;
      e._y ? (k = e._m2(!1, k), g += j) : g = k;
      e._n = k;
      e._f4 = e.slidesJQ[e.currSlideId];
      e._t = g;
      e.currSlideId = e._n;
      e.currSlide = e.slides[e.currSlideId];
      e._q1 = e.slidesJQ[e.currSlideId];
      var k = e.st.slidesDiff,
        l = Boolean(0 < j);
      j = Math.abs(j);
      var p = Math.floor(h / e._x),
        q = Math.floor((h + (l ? k : -k)) / e._x),
        p = (l ? Math.max(p, q) : Math.min(p, q)) * e._x + (l ? e._x - 1 : 0);
      p > e.numSlides - 1 ? p = e.numSlides - 1 : 0 > p && (p = 0);
      h = l ? p - h : h - p;
      h > e._x && (h = e._x);
      if (j > h + k) {
        e._c1 += (j - (h + k)) * (l ? -1 : 1);
        f *= 1.4;
        for (h = 0; h < e.numSlides; h++) e.slides[h].positionSet = !1
      }
      e._b = f;
      e._m2(!0);
      a || (m = !0);
      d = (-g - e._c1) * e._v;
      m ? setTimeout(function () {
        e._h4 = !1;
        e._v3(d, b, !1, c);
        e.ev.trigger("rsOnUpdateNav")
      }, 0) : (e._v3(d, b, !1, c), e.ev.trigger("rsOnUpdateNav"))
    },
    _e2: function () {
      this.st.arrowsNav && (1 >= this.numSlides ? (this._b2.css("display", "none"), this._c2.css("display", "none")) : (this._b2.css("display", "block"), this._c2.css("display", "block"), !this._y && !this.st.loopRewind && (0 === this.currSlideId ? this._b2.addClass("rsArrowDisabled") : this._b2.removeClass("rsArrowDisabled"), this.currSlideId === this.numSlides - 1 ? this._c2.addClass("rsArrowDisabled") : this._c2.removeClass("rsArrowDisabled"))))
    },
    _v3: function (b, f, c, g, a) {
      function e() {
        var a;
        if (j && (a = j.data("rsTimeout"))) j !== h && j.css({
          opacity: 0,
          display: "none",
          zIndex: 0
        }), clearTimeout(a), j.data("rsTimeout", "");
        if (a = h.data("rsTimeout")) clearTimeout(a), h.data("rsTimeout", "")
      }
      var d = this,
        j, h, k = {};
      isNaN(d._b) && (d._b = 400);
      d._o = d._f3 = b;
      d.ev.trigger("rsBeforeAnimStart");
      d._d ? d._k ? (d._b = parseInt(d._b), k[d._f + d._t1] = d._b + "ms", k[d._f + d._u1] = g ? l.rsCSS3Easing[d.st.easeInOut] : l.rsCSS3Easing[d.st.easeOut], d._o1.css(k), g || !d.hasTouch ? setTimeout(function () {
        d._n3(b)
      }, 5) : d._n3(b)) : (d._b = d.st.transitionSpeed, j = d._f4, h = d._q1, h.data("rsTimeout") && h.css("opacity", 0), e(), j && j.data("rsTimeout", setTimeout(function () {
        k[d._f + d._t1] = "0ms";
        k.zIndex = 0;
        k.display = "none";
        j.data("rsTimeout", "");
        j.css(k);
        setTimeout(function () {
          j.css("opacity",
          0)
        }, 16)
      }, d._b + 60)), k.display = "block", k.zIndex = d._l, k.opacity = 0, k[d._f + d._t1] = "0ms", k[d._f + d._u1] = l.rsCSS3Easing[d.st.easeInOut], h.css(k), h.data("rsTimeout", setTimeout(function () {
        h.css(d._f + d._t1, d._b + "ms");
        h.data("rsTimeout", setTimeout(function () {
          h.css("opacity", 1);
          h.data("rsTimeout", "")
        }, 20))
      }, 20))) : d._k ? (k[d._g ? d._w1 : d._v1] = b + "px", d._o1.animate(k, d._b, g ? d.st.easeInOut : d.st.easeOut)) : (j = d._f4, h = d._q1, h.stop(!0, !0).css({
        opacity: 0,
        display: "block",
        zIndex: d._l
      }), d._b = d.st.transitionSpeed, h.animate({
        opacity: 1
      },
      d._b, d.st.easeInOut), e(), j && j.data("rsTimeout", setTimeout(function () {
        j.stop(!0, !0).css({
          opacity: 0,
          display: "none",
          zIndex: 0
        })
      }, d._b + 60)));
      d._q2 = !0;
      d.loadingTimeout && clearTimeout(d.loadingTimeout);
      d.loadingTimeout = a ? setTimeout(function () {
        d.loadingTimeout = null;
        a.call()
      }, d._b + 60) : setTimeout(function () {
        d.loadingTimeout = null;
        d._k4(f)
      }, d._b + 60)
    },
    _s2: function (b) {
      this._q2 = !1;
      clearTimeout(this.loadingTimeout);
      if (this._k) if (this._d) {
        if (!b) {
          b = this._o;
          var f = this._f3 = this._l4();
          this._o1.css(this._f + this._t1, "0ms");
          b !== f && this._n3(f)
        }
      } else this._o1.stop(!0), this._o = parseInt(this._o1.css(this._w1), 10);
      else 20 < this._l ? this._l = 10 : this._l++
    },
    _l4: function () {
      var b = window.getComputedStyle(this._o1.get(0), null).getPropertyValue(this._f + "transform").replace(/^matrix\(/i, "").split(/, |\)$/g),
        f = 0 === b[0].indexOf("matrix3d");
      return parseInt(b[this._g ? f ? 12 : 4 : f ? 13 : 5], 10)
    },
    _m4: function (b, f) {
      return this._d ? this._x1 + (f ? b + this._y1 + 0 : 0 + this._y1 + b) + this._z1 : b
    },
    _k4: function () {
      this._k || (this._q1.css("z-index", 0), this._l = 10);
      this._q2 = !1;
      this.staticSlideId = this.currSlideId;
      this._m2();
      this._n4 = !1;
      this.ev.trigger("rsAfterSlideChange")
    },
    _j4: function (b, f) {
      var c = this,
        g = (-c._t - c._c1) * c._v;
      if (!(0 === c.numSlides || c._q2)) if (c.st.loopRewind) c.goTo("left" === b ? c.numSlides - 1 : 0, f);
      else if (c._k) {
        c._b = 200;
        var a = function () {
          c._q2 = !1
        };
        c._v3(g + ("left" === b ? 30 : -30), "", !1, !0, function () {
          c._q2 = !1;
          c._v3(g, "", !1, !0, a)
        })
      }
    },
    _p2: function (b) {
      if (!b.isRendered) {
        var f = b.content,
          c = "rsMainSlideImage",
          g, a = this.st.imageAlignCenter,
          e = this.st.imageScaleMode,
          d;
        b.videoURL && (c = "rsVideoContainer", "fill" !== e ? g = !0 : (d = f, d.hasClass(c) || (d = d.find("." + c)), d.css({
          width: "100%",
          height: "100%"
        }), c = "rsMainSlideImage"));
        f.hasClass(c) || (f = f.find("." + c));
        if (f) {
          var j = b.iW,
            c = b.iH;
          b.isRendered = !0;
          if ("none" !== e || a) {
            bMargin = "fill" !== e ? this._b4 : 0;
            b = this._z3 - 2 * bMargin;
            d = this._a4 - 2 * bMargin;
            var h, k, l = {};
            if ("fit-if-smaller" === e && (j > b || c > d)) e = "fit";
            if ("fill" === e || "fit" === e) h = b / j, k = d / c, h = "fill" == e ? h > k ? h : k : "fit" == e ? h < k ? h : k : 1, j = Math.ceil(j * h, 10), c = Math.ceil(c * h, 10);
            "none" !== e && (l.width = j, l.height = c, g && f.find(".rsImg").css({
              width: "100%",
              height: "100%"
            }));
            a && (l.marginLeft = Math.floor((b - j) / 2) + bMargin, l.marginTop = Math.floor((d - c) / 2) + bMargin);
            f.css(l)
          }
        }
      }
    }
  };
  l.rsProto = v.prototype;
  l.fn.royalSlider = function (b) {
    var f = arguments;
    return this.each(function () {
      var c = l(this);
      if ("object" === typeof b || !b) c.data("royalSlider") || c.data("royalSlider", new v(c, b));
      else if ((c = c.data("royalSlider")) && c[b]) return c[b].apply(c, Array.prototype.slice.call(f, 1))
    })
  };
  l.fn.royalSlider.defaults = {
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
    usePreloader: !0,
    autoScaleSlider: !1,
    autoScaleSliderWidth: 800,
    autoScaleSliderHeight: 400,
    autoScaleHeight: !0,
    arrowsNavHideOnTouch: !1,
    globalCaption: !1,
    slidesDiff: 2
  };
  l.rsCSS3Easing = {
    easeOutSine: "cubic-bezier(0.390, 0.575, 0.565, 1.000)",
    easeInOutSine: "cubic-bezier(0.445, 0.050, 0.550, 0.950)"
  };
  l.extend(jQuery.easing, {
    easeInOutSine: function (b, f, c, g, a) {
      return -g / 2 * (Math.cos(Math.PI * f / a) - 1) + c
    },
    easeOutSine: function (b, f, c, g, a) {
      return g * Math.sin(f / a * (Math.PI / 2)) + c
    },
    easeOutCubic: function (b,
    f, c, g, a) {
      return g * ((f = f / a - 1) * f * f + 1) + c
    }
  })
})(jQuery, window);
// jquery.rs.active-class v1.0.1
(function (c) {
  c.rsProto._o4 = function () {
    var b, a = this;
    if (a.st.addActiveClass) a.ev.on("rsOnUpdateNav", function () {
      b && clearTimeout(b);
      b = setTimeout(function () {
        a._f4 && a._f4.removeClass("rsActiveSlide");
        a._q1 && a._q1.addClass("rsActiveSlide");
        b = null
      }, 50)
    })
  };
  c.rsModules.activeClass = c.rsProto._o4
})(jQuery);
// jquery.rs.animated-blocks v1.0.2
(function (j) {
  j.extend(j.rsProto, {
    _p4: function () {
      function k() {
        var e = a.currSlide;
        if (a.currSlide && a.currSlide.isLoaded && a._t4 !== e) {
          if (0 < a._s4.length) {
            for (b = 0; b < a._s4.length; b++) clearTimeout(a._s4[b]);
            a._s4 = []
          }
          if (0 < a._r4.length) {
            var g;
            for (b = 0; b < a._r4.length; b++) if (g = a._r4[b]) a._d ? (g.block.css(a._f + a._t1, "0s"), g.block.css(g.css)) : g.running ? g.block.stop(!0, !0) : g.block.css(g.css), a._t4 = null, e.animBlocksDisplayed = !1;
            a._r4 = []
          }
          e.animBlocks && (e.animBlocksDisplayed = !0, a._t4 = e, a._u4(e.animBlocks))
        }
      }
      var a = this,
        b;
      a._q4 = {
        fadeEffect: !0,
        moveEffect: "top",
        moveOffset: 20,
        speed: 400,
        easing: "easeOutSine",
        delay: 200
      };
      a.st.block = j.extend({}, a._q4, a.st.block);
      a._r4 = [];
      a._s4 = [];
      a.ev.on("rsAfterInit", function () {
        k()
      });
      a.ev.on("rsBeforeParseNode", function (a, b, c) {
        b = j(b);
        c.animBlocks = b.find(".rsABlock").css("display", "none");
        c.animBlocks.length || (c.animBlocks = b.hasClass("rsABlock") ? b.css("display", "none") : !1)
      });
      a.ev.on("rsAfterContentSet", function (b, g) {
        g.id === a.currSlideId && setTimeout(function () {
          k()
        }, a.st.fadeinLoadedSlide ? 300 : 0)
      });
      a.ev.on("rsAfterSlideChange", function () {
        k()
      })
    },
    _v4: function (j, a) {
      setTimeout(function () {
        j.css(a)
      }, 6)
    },
    _u4: function (k) {
      var a = this,
        b, e, g, c;
      a._s4 = [];
      k.each(function (k) {
        b = j(this);
        e = {};
        g = {};
        c = null;
        var f = b.data("move-offset");
        isNaN(f) && (f = a.st.block.moveOffset);
        if (0 < f) {
          var d = b.data("move-effect");
          d ? (d = d.toLowerCase(), "none" === d ? d = !1 : "left" !== d && ("top" !== d && "bottom" !== d && "right" !== d) && (d = a.st.block.moveEffect, "none" === d && (d = !1))) : d = a.st.block.moveEffect;
          if (d) {
            var m;
            m = "right" === d || "left" === d ? !0 : !1;
            var l, h;
            isOppositeProp = !1;
            a._d ? (l = 0, h = a._w1) : (m ? isNaN(parseInt(b.css("right"), 10)) ? h = "left" : (h = "right", isOppositeProp = !0) : isNaN(parseInt(b.css("bottom"), 10)) ? h = "top" : (h = "bottom", isOppositeProp = !0), h = "margin-" + h, isOppositeProp && (f = -f), l = parseInt(b.css(h), 10));
            g[h] = a._m4("top" === d || "left" === d ? l - f : l + f, m);
            e[h] = a._m4(l, m)
          }
        }
        if (f = b.attr("data-fade-effect")) {
          if ("none" === f.toLowerCase() || "false" === f.toLowerCase()) f = !1
        } else f = a.st.block.fadeEffect;
        f && (g.opacity = 0, e.opacity = 1);
        if (f || d) c = {}, c.hasFade = Boolean(f),
        Boolean(d) && (c.moveProp = h, c.hasMove = !0), c.speed = b.data("speed"), isNaN(c.speed) && (c.speed = a.st.block.speed), c.easing = b.data("easing"), c.easing || (c.easing = a.st.block.easing), c.css3Easing = j.rsCSS3Easing[c.easing], c.delay = b.data("delay"), isNaN(c.delay) && (c.delay = a.st.block.delay * k);
        d = {};
        a._d && (d[a._f + a._t1] = "0ms");
        d.moveProp = e.moveProp;
        d.opacity = e.opacity;
        d.display = "none";
        a._r4.push({
          block: b,
          css: d
        });
        a._v4(b, g);
        a._s4.push(setTimeout(function (b, d, c, g) {
          return function () {
            b.css("display", "block");
            if (c) {
              var f = {};
              if (a._d) {
                var e = "";
                c.hasMove && (e += c.moveProp);
                c.hasFade && (c.hasMove && (e += ", "), e += "opacity");
                f[a._f + a._s1] = e;
                f[a._f + a._t1] = c.speed + "ms";
                f[a._f + a._u1] = c.css3Easing;
                b.css(f);
                setTimeout(function () {
                  b.css(d)
                }, 24)
              } else setTimeout(function () {
                b.animate(d, c.speed, c.easing)
              }, 16)
            }
            delete a._s4[g]
          }
        }(b, e, c, k), 6 >= c.delay ? 12 : c.delay))
      })
    }
  });
  j.rsModules.animatedBlocks = j.rsProto._p4
})(jQuery);
// jquery.rs.auto-height v1.0.2
(function (b) {
  b.extend(b.rsProto, {
    _w4: function () {
      var a = this;
      if (a.st.autoHeight) {
        var b, d, e, c = function (c) {
          e = a.slides[a.currSlideId];
          if (b = e.holder) if ((d = b.height()) && void 0 !== d) a._a4 = d, a._d || !c ? a._d1.css("height", d) : a._d1.stop(!0, !0).animate({
            height: d
          }, a.st.transitionSpeed)
        };
        a.ev.on("rsMaybeSizeReady.rsAutoHeight", function (a, b) {
          e === b && c()
        });
        a.ev.on("rsAfterContentSet.rsAutoHeight", function (a, b) {
          e === b && c()
        });
        a.slider.addClass("rsAutoHeight");
        a.ev.one("rsAfterInit", function () {
          setTimeout(function () {
            c(!1);
            setTimeout(function () {
              a.slider.append('<div style="clear:both; float: none;"></div>');
              a._d && a._d1.css(a._f + "transition", "height " + a.st.transitionSpeed + "ms ease-in-out")
            }, 16)
          }, 16)
        });
        a.ev.on("rsBeforeAnimStart", function () {
          c(!0)
        });
        a.ev.on("rsBeforeSizeSet", function () {
          setTimeout(function () {
            c(!1)
          }, 16)
        })
      }
    }
  });
  b.rsModules.autoHeight = b.rsProto._w4
})(jQuery);
// jquery.rs.autoplay v1.0.4
(function (b) {
  b.extend(b.rsProto, {
    _x4: function () {
      var a = this,
        d;
      a._y4 = {
        enabled: !1,
        stopAtAction: !0,
        pauseOnHover: !0,
        delay: 2E3
      };
      !a.st.autoPlay && a.st.autoplay && (a.st.autoPlay = a.st.autoplay);
      a.st.autoPlay = b.extend({}, a._y4, a.st.autoPlay);
      a.st.autoPlay.enabled && (a.ev.on("rsBeforeParseNode", function (a, c, e) {
        c = b(c);
        if (d = c.attr("data-rsDelay")) e.customDelay = parseInt(d, 10)
      }), a.ev.one("rsAfterInit", function () {
        a._z4()
      }), a.ev.on("rsBeforeDestroy", function () {
        a.stopAutoPlay()
      }))
    },
    _z4: function () {
      var a = this;
      a.startAutoPlay();
      a.ev.on("rsAfterContentSet", function (d, b) {
        !a._k2 && (!a._q2 && a._a5 && b === a.currSlide) && a._b5()
      });
      a.ev.on("rsDragRelease", function () {
        a._a5 && a._c5 && (a._c5 = !1, a._b5())
      });
      a.ev.on("rsAfterSlideChange", function () {
        a._a5 && a._c5 && (a._c5 = !1, a.currSlide.isLoaded && a._b5())
      });
      a.ev.on("rsDragStart", function () {
        a._a5 && (a.st.autoPlay.stopAtAction ? a.stopAutoPlay() : (a._c5 = !0, a._d5()))
      });
      a.ev.on("rsBeforeMove", function (b, f, c) {
        a._a5 && (c && a.st.autoPlay.stopAtAction ? a.stopAutoPlay() : (a._c5 = !0, a._d5()))
      });
      a._e5 = !1;
      a.ev.on("rsVideoStop",

      function () {
        a._a5 && (a._e5 = !1, a._b5())
      });
      a.ev.on("rsVideoPlay", function () {
        a._a5 && (a._c5 = !1, a._d5(), a._e5 = !0)
      });
      a.st.autoPlay.pauseOnHover && (a._f5 = !1, a.slider.hover(function () {
        a._a5 && (a._c5 = !1, a._d5(), a._f5 = !0)
      }, function () {
        a._a5 && (a._f5 = !1, a._b5())
      }))
    },
    toggleAutoPlay: function () {
      this._a5 ? this.stopAutoPlay() : this.startAutoPlay()
    },
    startAutoPlay: function () {
      this._a5 = !0;
      this.currSlide.isLoaded && this._b5()
    },
    stopAutoPlay: function () {
      this._e5 = this._f5 = this._c5 = this._a5 = !1;
      this._d5()
    },
    _b5: function () {
      var a = this;
      !a._f5 && !a._e5 && (a._g5 = !0, a._h5 && clearTimeout(a._h5), a._h5 = setTimeout(function () {
        var b;
        !a._y && !a.st.loopRewind && (b = !0, a.st.loopRewind = !0);
        a.next(!0);
        b && (a.st.loopRewind = !1)
      }, !a.currSlide.customDelay ? a.st.autoPlay.delay : a.currSlide.customDelay))
    },
    _d5: function () {
      !this._f5 && !this._e5 && (this._g5 = !1, this._h5 && (clearTimeout(this._h5), this._h5 = null))
    }
  });
  b.rsModules.autoplay = b.rsProto._x4
})(jQuery);
// jquery.rs.bullets v1.0.1
(function (c) {
  c.extend(c.rsProto, {
    _i5: function () {
      var a = this;
      "bullets" === a.st.controlNavigation && (a.ev.one("rsAfterPropsSetup", function () {
        a._j5 = !0;
        a.slider.addClass("rsWithBullets");
        for (var b = '<div class="rsNav rsBullets">', e = 0; e < a.numSlides; e++) b += '<div class="rsNavItem rsBullet"><span></span></div>';
        a._k5 = b = c(b + "</div>");
        a._l5 = b.appendTo(a.slider).children();
        a._k5.on("click.rs", ".rsNavItem", function () {
          a._m5 || a.goTo(c(this).index())
        })
      }), a.ev.on("rsOnAppendSlide", function (b, c, d) {
        d >= a.numSlides ? a._k5.append('<div class="rsNavItem rsBullet"><span></span></div>') : a._l5.eq(d).before('<div class="rsNavItem rsBullet"><span></span></div>');
        a._l5 = a._k5.children()
      }), a.ev.on("rsOnRemoveSlide", function (b, c) {
        var d = a._l5.eq(c);
        d && d.length && (d.remove(), a._l5 = a._k5.children())
      }), a.ev.on("rsOnUpdateNav", function () {
        var b = a.currSlideId;
        a._n5 && a._n5.removeClass("rsNavSelected");
        b = c(a._l5[b]);
        b.addClass("rsNavSelected");
        a._n5 = b
      }))
    }
  });
  c.rsModules.bullets = c.rsProto._i5
})(jQuery);
// jquery.rs.deeplinking v1.0.4 + jQuery hashchange plugin v1.3 Copyright (c) 2010
(function (a) {
  a.extend(a.rsProto, {
    _o5: function () {
      var b = this,
        g, c, e;
      b._p5 = {
        enabled: !1,
        change: !1,
        prefix: ""
      };
      b.st.deeplinking = a.extend({}, b._p5, b.st.deeplinking);
      if (b.st.deeplinking.enabled) {
        var h = b.st.deeplinking.change,
          d = "#" + b.st.deeplinking.prefix,
          f = function () {
            var a = window.location.hash;
            return a && (a = parseInt(a.substring(d.length), 10), 0 <= a) ? a - 1 : -1
          }, j = f(); - 1 !== j && (b.st.startSlideId = j);
        h && (a(window).on("hashchange.rs", function () {
          if (!g) {
            var a = f();
            0 > a || (a > b.numSlides - 1 && (a = b.numSlides - 1), b.goTo(a))
          }
        }), b.ev.on("rsBeforeAnimStart",

        function () {
          c && clearTimeout(c);
          e && clearTimeout(e)
        }), b.ev.on("rsAfterSlideChange", function () {
          c && clearTimeout(c);
          e && clearTimeout(e);
          e = setTimeout(function () {
            g = !0;
            window.location.hash = d + (b.currSlideId + 1);
            c = setTimeout(function () {
              g = !1;
              c = null
            }, 60)
          }, 400)
        }));
        b.ev.on("rsBeforeDestroy", function () {
          c = e = null;
          h && a(window).off("hashchange.rs")
        })
      }
    }
  });
  a.rsModules.deeplinking = a.rsProto._o5
})(jQuery);
(function (a, b, g) {
  function c(a) {
    a = a || location.href;
    return "#" + a.replace(/^[^#]*#?(.*)$/, "$1")
  }
  "$:nomunge";
  var e = document,
    h, d = a.event.special,
    f = e.documentMode,
    j = "onhashchange" in b && (f === g || 7 < f);
  a.fn.hashchange = function (a) {
    return a ? this.bind("hashchange", a) : this.trigger("hashchange")
  };
  a.fn.hashchange.delay = 50;
  d.hashchange = a.extend(d.hashchange, {
    setup: function () {
      if (j) return !1;
      a(h.start)
    },
    teardown: function () {
      if (j) return !1;
      a(h.stop)
    }
  });
  var p = function () {
    var e = c(),
      d = r(n);
    e !== n ? (q(n = e, d), a(b).trigger("hashchange")) : d !== n && (location.href = location.href.replace(/#.*/, "") + d);
    l = setTimeout(p, a.fn.hashchange.delay)
  }, d = {}, l, n = c(),
    q = f = function (a) {
      return a
    }, r = f;
  d.start = function () {
    l || p()
  };
  d.stop = function () {
    l && clearTimeout(l);
    l = g
  };
  if (a.browser.msie && !j) {
    var k, m;
    d.start = function () {
      k || (m = (m = a.fn.hashchange.src) && m + c(), k = a('<iframe tabindex="-1" title="empty"/>').hide().one("load", function () {
        m || q(c());
        p()
      }).attr("src", m || "javascript:0").insertAfter("body")[0].contentWindow, e.onpropertychange = function () {
        try {
          "title" === event.propertyName && (k.document.title = e.title)
        } catch (a) {}
      })
    };
    d.stop = f;
    r = function () {
      return c(k.location.href)
    };
    q = function (b, d) {
      var c = k.document,
        f = a.fn.hashchange.domain;
      b !== d && (c.title = e.title, c.open(), f && c.write('<script>document.domain="' + f + '"\x3c/script>'), c.close(), k.location.hash = b)
    }
  }
  h = d
})(jQuery, this);
// jquery.rs.fullscreen v1.0.3
(function (c) {
  c.extend(c.rsProto, {
    _q5: function () {
      var a = this;
      a._r5 = {
        enabled: !1,
        keyboardNav: !0,
        buttonFS: !0,
        nativeFS: !1,
        doubleTap: !0
      };
      a.st.fullscreen = c.extend({}, a._r5, a.st.fullscreen);
      if (a.st.fullscreen.enabled) a.ev.one("rsBeforeSizeSet", function () {
        a._s5()
      })
    },
    _s5: function () {
      var a = this;
      a._t5 = !a.st.keyboardNavEnabled && a.st.fullscreen.keyboardNav;
      if (a.st.fullscreen.nativeFS) {
        a._u5 = {
          supportsFullScreen: !1,
          isFullScreen: function () {
            return !1
          },
          requestFullScreen: function () {},
          cancelFullScreen: function () {},
          fullScreenEventName: "",
          prefix: ""
        };
        var b = ["webkit", "moz", "o", "ms", "khtml"];
        if ("undefined" != typeof document.cancelFullScreen) a._u5.supportsFullScreen = !0;
        else for (var d = 0; d < b.length; d++) if (a._u5.prefix = b[d], "undefined" != typeof document[a._u5.prefix + "CancelFullScreen"]) {
          a._u5.supportsFullScreen = !0;
          break
        }
        a._u5.supportsFullScreen ? (a.nativeFS = !0, a._u5.fullScreenEventName = a._u5.prefix + "fullscreenchange.rs", a._u5.isFullScreen = function () {
          switch (this.prefix) {
            case "":
              return document.fullScreen;
            case "webkit":
              return document.webkitIsFullScreen;
            default:
              return document[this.prefix + "FullScreen"]
          }
        }, a._u5.requestFullScreen = function (a) {
          return "" === this.prefix ? a.requestFullScreen() : a[this.prefix + "RequestFullScreen"]()
        }, a._u5.cancelFullScreen = function () {
          return "" === this.prefix ? document.cancelFullScreen() : document[this.prefix + "CancelFullScreen"]()
        }) : a._u5 = !1
      }
      a.st.fullscreen.buttonFS && (a._v5 = c('<div class="rsFullscreenBtn"><div class="rsFullscreenIcn"></div></div>').appendTo(a._n1).on("click.rs", function () {
        a.isFullscreen ? a.exitFullscreen() : a.enterFullscreen()
      }))
    },
    enterFullscreen: function (a) {
      var b = this;
      if (b._u5) if (a) b._u5.requestFullScreen(c("html")[0]);
      else {
        b._a.on(b._u5.fullScreenEventName, function () {
          b._u5.isFullScreen() ? b.enterFullscreen(!0) : b.exitFullscreen(!0)
        });
        b._u5.requestFullScreen(c("html")[0]);
        return
      }
      if (!b._w5) {
        b._w5 = !0;
        b._a.on("keyup.rsfullscreen", function (a) {
          27 === a.keyCode && b.exitFullscreen()
        });
        b._t5 && b._a2();
        a = c(window);
        b._x5 = a.scrollTop();
        b._y5 = a.scrollLeft();
        b._z5 = c("html").attr("style");
        b._a6 = c("body").attr("style");
        b._b6 = b.slider.attr("style");
        c("body, html").css({
          overflow: "hidden",
          height: "100%",
          width: "100%",
          margin: "0",
          padding: "0"
        });
        b.slider.addClass("rsFullscreen");
        var d;
        for (d = 0; d < b.numSlides; d++) a = b.slides[d], a.isRendered = !1, a.bigImage && (a.isBig = !0, a.isMedLoaded = a.isLoaded, a.isMedLoading = a.isLoading, a.medImage = a.image, a.medIW = a.iW, a.medIH = a.iH, a.slideId = -99, a.bigImage !== a.medImage && (a.sizeType = "big"), a.isLoaded = a.isBigLoaded, a.isLoading = !1, a.image = a.bigImage, a.images[0] = a.bigImage, a.iW = a.bigIW, a.iH = a.bigIH, a.isAppended = a.contentAdded = !1, b._c6(a));
        b.isFullscreen = !0;
        b._w5 = !1;
        b.updateSliderSize();
        b.ev.trigger("rsEnterFullscreen")
      }
    },
    exitFullscreen: function (a) {
      var b = this;
      if (b._u5) {
        if (!a) {
          b._u5.cancelFullScreen(c("html")[0]);
          return
        }
        b._a.off(b._u5.fullScreenEventName)
      }
      if (!b._w5) {
        b._w5 = !0;
        b._a.off("keyup.rsfullscreen");
        b._t5 && b._a.off("keydown.rskb");
        c("html").attr("style", b._z5 || "");
        c("body").attr("style", b._a6 || "");
        var d;
        for (d = 0; d < b.numSlides; d++) a = b.slides[d], a.isRendered = !1, a.bigImage && (a.isBig = !1, a.slideId = -99, a.isBigLoaded = a.isLoaded,
        a.isBigLoading = a.isLoading, a.bigImage = a.image, a.bigIW = a.iW, a.bigIH = a.iH, a.isLoaded = a.isMedLoaded, a.isLoading = !1, a.image = a.medImage, a.images[0] = a.medImage, a.iW = a.medIW, a.iH = a.medIH, a.isAppended = a.contentAdded = !1, b._c6(a, !0), a.bigImage !== a.medImage && (a.sizeType = "med"));
        b.isFullscreen = !1;
        a = c(window);
        a.scrollTop(b._x5);
        a.scrollLeft(b._y5);
        b._w5 = !1;
        b.slider.removeClass("rsFullscreen");
        b.updateSliderSize();
        setTimeout(function () {
          b.updateSliderSize()
        }, 1);
        b.ev.trigger("rsExitFullscreen")
      }
    },
    _c6: function (a) {
      var b = !a.isLoaded && !a.isLoading ? '<a class="rsImg rsMainSlideImage" href="' + a.image + '"></a>' : '<img class="rsImg rsMainSlideImage" src="' + a.image + '"/>';
      a.content.hasClass("rsImg") ? a.content = c(b) : a.content.find(".rsImg").eq(0).replaceWith(b);
      !a.isLoaded && (!a.isLoading && a.holder) && a.holder.html(a.content)
    }
  });
  c.rsModules.fullscreen = c.rsProto._q5
})(jQuery);
// jquery.rs.global-caption v1.0
(function (b) {
  b.extend(b.rsProto, {
    _d6: function () {
      var a = this;
      a.st.globalCaption && (a.ev.on("rsAfterInit", function () {
        a.globalCaption = b('<div class="rsGCaption"></div>').appendTo(!a.st.globalCaptionInside ? a.slider : a._d1);
        a.globalCaption.html(a.currSlide.caption)
      }), a.ev.on("rsBeforeAnimStart", function () {
        a.globalCaption.html(a.currSlide.caption)
      }))
    }
  });
  b.rsModules.globalCaption = b.rsProto._d6
})(jQuery);
// jquery.rs.nav-auto-hide v1.0
(function (b) {
  b.extend(b.rsProto, {
    _e6: function () {
      var a = this;
      if (a.st.navAutoHide && !a.hasTouch) a.ev.one("rsAfterInit", function () {
        if (a._k5) {
          a._k5.addClass("rsHidden");
          var b = a.slider;
          b.one("mousemove.controlnav", function () {
            a._k5.removeClass("rsHidden")
          });
          b.hover(function () {
            a._k5.removeClass("rsHidden")
          }, function () {
            a._k5.addClass("rsHidden")
          })
        }
      })
    }
  });
  b.rsModules.autoHideNav = b.rsProto._e6
})(jQuery);
// jquery.rs.tabs v1.0.1
(function (e) {
  e.extend(e.rsProto, {
    _f6: function () {
      var a = this;
      "tabs" === a.st.controlNavigation && (a.ev.on("rsBeforeParseNode", function (a, d, b) {
        d = e(d);
        b.thumbnail = d.find(".rsTmb").remove();
        b.thumbnail.length ? b.thumbnail = e(document.createElement("div")).append(b.thumbnail).html() : (b.thumbnail = d.attr("data-rsTmb"), b.thumbnail || (b.thumbnail = d.find(".rsImg").attr("data-rsTmb")), b.thumbnail = b.thumbnail ? '<img src="' + b.thumbnail + '"/>' : "")
      }), a.ev.one("rsAfterPropsSetup", function () {
        a._g6()
      }), a.ev.on("rsOnAppendSlide",

      function (c, d, b) {
        b >= a.numSlides ? a._k5.append('<div class="rsNavItem rsTab">' + d.thumbnail + "</div>") : a._l5.eq(b).before('<div class="rsNavItem rsTab">' + item.thumbnail + "</div>");
        a._l5 = a._k5.children()
      }), a.ev.on("rsOnRemoveSlide", function (c, d) {
        var b = a._l5.eq(d);
        b && (b.remove(), a._l5 = a._k5.children())
      }), a.ev.on("rsOnUpdateNav", function () {
        var c = a.currSlideId;
        a._n5 && a._n5.removeClass("rsNavSelected");
        c = e(a._l5[c]);
        c.addClass("rsNavSelected");
        a._n5 = c
      }))
    },
    _g6: function () {
      var a = this,
        c, d;
      a._j5 = !0;
      c = '<div class="rsNav rsTabs">';
      for (var b = 0; b < a.numSlides; b++) b === a.numSlides - 1 && (style = ""), d = a.slides[b], c += '<div class="rsNavItem rsTab">' + d.thumbnail + "</div>";
      c = e(c + "</div>");
      a._k5 = c;
      a._l5 = c.find(".rsNavItem");
      a.slider.append(c);
      a._k5.click(function (b) {
        b = e(b.target).closest(".rsNavItem");
        b.length && a.goTo(b.index())
      })
    }
  });
  e.rsModules.tabs = e.rsProto._f6
})(jQuery);
// jquery.rs.thumbnails v1.0.5
(function (f) {
  f.extend(f.rsProto, {
    _h6: function () {
      var a = this;
      "thumbnails" === a.st.controlNavigation && (a._i6 = {
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
        firstMargin: !0,
        paddingTop: 0,
        paddingBottom: 0
      }, a.st.thumbs = f.extend({}, a._i6, a.st.thumbs), a._j6 = !0, !1 === a.st.thumbs.firstMargin ? a.st.thumbs.firstMargin = 0 : !0 === a.st.thumbs.firstMargin && (a.st.thumbs.firstMargin = a.st.thumbs.spacing), a.ev.on("rsBeforeParseNode", function (a, c, b) {
        c = f(c);
        b.thumbnail = c.find(".rsTmb").remove();
        b.thumbnail.length ? b.thumbnail = f(document.createElement("div")).append(b.thumbnail).html() : (b.thumbnail = c.attr("data-rsTmb"), b.thumbnail || (b.thumbnail = c.find(".rsImg").attr("data-rsTmb")), b.thumbnail = b.thumbnail ? '<img src="' + b.thumbnail + '"/>' : "")
      }), a.ev.one("rsAfterPropsSetup", function () {
        a._k6()
      }), a._n5 = null, a.ev.on("rsOnUpdateNav", function () {
        var e = f(a._l5[a.currSlideId]);
        e !== a._n5 && (a._n5 && (a._n5.removeClass("rsNavSelected"), a._n5 = null), a._l6 && a._m6(a.currSlideId), a._n5 = e.addClass("rsNavSelected"))
      }), a.ev.on("rsOnAppendSlide", function (e, c, b) {
        e = "<div" + a._n6 + ' class="rsNavItem rsThumb">' + a._o6 + c.thumbnail + "</div>";
        b >= a.numSlides ? a._q3.append(e) : a._l5.eq(b).before(e);
        a._l5 = a._q3.children();
        a.updateThumbsSize()
      }), a.ev.on("rsOnRemoveSlide", function (e, c) {
        var b = a._l5.eq(c);
        b && (b.remove(), a._l5 = a._q3.children(), a.updateThumbsSize())
      }))
    },
    _k6: function () {
      var a = this,
        e = "rsThumbs",
        c = a.st.thumbs,
        b = "",
        g, d, h = c.spacing;
      a._j5 = !0;
      a._c3 = "vertical" === c.orientation ? !1 : !0;
      a._n6 = g = h ? ' style="margin-' + (a._c3 ? "right" : "bottom") + ":" + h + 'px;"' : "";
      a._g3 = 0;
      a._p6 = !1;
      a._m5 = !1;
      a._l6 = !1;
      a._q6 = c.arrows && c.navigation;
      d = a._c3 ? "Hor" : "Ver";
      a.slider.addClass("rsWithThumbs rsWithThumbs" + d);
      b += '<div class="rsNav rsThumbs rsThumbs' + d + '"><div class="' + e + 'Container">';
      a._o6 = c.appendSpan ? '<span class="thumbIco"></span>' : "";
      for (var j = 0; j < a.numSlides; j++) d = a.slides[j], b += "<div" + g + ' class="rsNavItem rsThumb">' + d.thumbnail + a._o6 +
        "</div>";
      b = f(b + "</div></div>");
      g = {};
      c.paddingTop && (g[a._c3 ? "paddingTop" : "paddingLeft"] = c.paddingTop);
      c.paddingBottom && (g[a._c3 ? "paddingBottom" : "paddingRight"] = c.paddingBottom);
      b.css(g);
      a._q3 = f(b).find("." + e + "Container");
      a._q6 && (e += "Arrow", c.arrowLeft ? a._r6 = c.arrowLeft : (a._r6 = f('<div class="' + e + " " + e + 'Left"><div class="' + e + 'Icn"></div></div>'), b.append(a._r6)), c.arrowRight ? a._s6 = c.arrowRight : (a._s6 = f('<div class="' + e + " " + e + 'Right"><div class="' + e + 'Icn"></div></div>'), b.append(a._s6)), a._r6.click(function () {
        var b = (Math.floor(a._g3 / a._t6) + a._u6) * a._t6;
        a._y3(b > a._l3 ? a._l3 : b)
      }), a._s6.click(function () {
        var b = (Math.floor(a._g3 / a._t6) - a._u6) * a._t6;
        a._y3(b < a._m3 ? a._m3 : b)
      }), c.arrowsAutoHide && !a.hasTouch && (a._r6.css("opacity", 0), a._s6.css("opacity", 0), b.one("mousemove.rsarrowshover", function () {
        a._l6 && (a._r6.css("opacity", 1), a._s6.css("opacity", 1))
      }), b.hover(function () {
        a._l6 && (a._r6.css("opacity", 1), a._s6.css("opacity", 1))
      }, function () {
        a._l6 && (a._r6.css("opacity", 0), a._s6.css("opacity", 0))
      })));
      a._k5 = b;
      a._l5 = a._q3.children();
      a.msEnabled && a.st.thumbs.navigation && a._q3.css("-ms-touch-action", a._c3 ? "pan-y" : "pan-x");
      a.slider.append(b);
      a._u3 = !0;
      a._v6 = h;
      c.navigation && a._d && a._q3.css(a._f + "transition-property", a._f + "transform");
      a._k5.on("click.rs", ".rsNavItem", function () {
        a._m5 || a.goTo(f(this).index())
      });
      a.ev.off("rsBeforeSizeSet.thumbs").on("rsBeforeSizeSet.thumbs", function () {
        a._w6 = a._c3 ? a._a4 : a._z3;
        a.updateThumbsSize(!0)
      })
    },
    updateThumbsSize: function () {
      var a = this,
        e = a._l5.first(),
        c = {}, b = a._l5.length;
      a._t6 = (a._c3 ? e.outerWidth() : e.outerHeight()) + a._v6;
      a._w3 = b * a._t6 - a._v6;
      c[a._c3 ? "width" : "height"] = a._w3 + a._v6;
      a._x3 = a._c3 ? a._k5.width() : a._k5.height();
      a._m3 = -(a._w3 - a._x3) - a.st.thumbs.firstMargin;
      a._l3 = a.st.thumbs.firstMargin;
      a._u6 = Math.floor(a._x3 / a._t6);
      if (a._w3 < a._x3) a.st.thumbs.autoCenter && a._o3((a._x3 - a._w3) / 2), a.st.thumbs.arrows && a._r6 && (a._r6.addClass("rsThumbsArrowDisabled"), a._s6.addClass("rsThumbsArrowDisabled")), a._l6 = !1, a._m5 = !1, a._k5.off(a._i1);
      else if (a.st.thumbs.navigation && !a._l6 && (a._l6 = !0, !a.hasTouch && a.st.thumbs.drag || a.hasTouch && a.st.thumbs.touch)) a._m5 = !0, a._k5.on(a._i1, function (b) {
        a._f2(b, !0)
      });
      a._d && (c[a._f + "transition-duration"] = "0ms");
      a._q3.css(c);
      if (a._u3 && (a.isFullscreen || a.st.thumbs.fitInViewport)) a._c3 ? a._a4 = a._w6 - a._k5.outerHeight() : a._z3 = a._w6 - a._k5.outerWidth()
    },
    setThumbsOrientation: function (a, e) {
      this._u3 && (this.st.thumbs.orientation = a, this._k5.remove(), this.slider.removeClass("rsWithThumbsHor rsWithThumbsVer"), this._k6(), this._k5.off(this._i1), e || this.updateSliderSize(!0))
    },
    _o3: function (a) {
      this._g3 = a;
      this._d ? this._q3.css(this._w1, this._x1 + (this._c3 ? a + this._y1 + 0 : 0 + this._y1 + a) + this._z1) : this._q3.css(this._c3 ? this._w1 : this._v1, a)
    },
    _y3: function (a, e, c, b, g) {
      var d = this;
      if (d._l6) {
        e || (e = d.st.thumbs.transitionSpeed);
        d._g3 = a;
        d._x6 && clearTimeout(d._x6);
        d._p6 && (d._d || d._q3.stop(), c = !0);
        var h = {};
        d._p6 = !0;
        d._d ? (h[d._f + "transition-duration"] = e + "ms", h[d._f + "transition-timing-function"] = c ? f.rsCSS3Easing[d.st.easeOut] : f.rsCSS3Easing[d.st.easeInOut], d._q3.css(h), d._o3(a)) : (h[d._c3 ? d._w1 : d._v1] = a + "px", d._q3.animate(h,
        e, c ? "easeOutCubic" : d.st.easeInOut));
        b && (d._g3 = b);
        d._y6();
        d._x6 = setTimeout(function () {
          d._p6 = !1;
          g && (d._y3(b, g, !0), g = null)
        }, e)
      }
    },
    _y6: function () {
      this._q6 && (this._g3 === this._l3 ? this._r6.addClass("rsThumbsArrowDisabled") : this._r6.removeClass("rsThumbsArrowDisabled"), this._g3 === this._m3 ? this._s6.addClass("rsThumbsArrowDisabled") : this._s6.removeClass("rsThumbsArrowDisabled"))
    },
    _m6: function (a, e) {
      var c = 0,
        b, f = a * this._t6 + 2 * this._t6 - this._v6 + this._l3,
        d = Math.floor(this._g3 / this._t6);
      this._l6 && (this._j6 && (e = !0,
      this._j6 = !1), f + this._g3 > this._x3 ? (a === this.numSlides - 1 && (c = 1), d = -a + this._u6 - 2 + c, b = d * this._t6 + this._x3 % this._t6 + this._v6 - this._l3) : 0 !== a ? (a - 1) * this._t6 <= -this._g3 + this._l3 && a - 1 <= this.numSlides - this._u6 && (b = (-a + 1) * this._t6 + this._l3) : b = this._l3, b !== this._g3 && (c = void 0 === b ? this._g3 : b, c > this._l3 ? this._o3(this._l3) : c < this._m3 ? this._o3(this._m3) : void 0 !== b && (e ? this._o3(b) : this._y3(b))), this._y6())
    }
  });
  f.rsModules.thumbnails = f.rsProto._h6
})(jQuery);
// jquery.rs.video v1.0.8
(function (e) {
  e.extend(e.rsProto, {
    _z6: function () {
      var a = this;
      a._a7 = {
        autoHideArrows: !0,
        autoHideControlNav: !1,
        autoHideBlocks: !1,
        autoHideCaption: !1,
        youTubeCode: '<iframe src="http://www.youtube.com/embed/%id%?rel=1&autoplay=1&showinfo=0&autoplay=1&wmode=transparent" frameborder="no"></iframe>',
        vimeoCode: '<iframe src="http://player.vimeo.com/video/%id%?byline=0&amp;portrait=0&amp;autoplay=1" frameborder="no" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
      };
      a.st.video = e.extend({}, a._a7,
      a.st.video);
      a.ev.on("rsBeforeSizeSet", function () {
        a._i4 && setTimeout(function () {
          var b = a._q1,
            b = b.hasClass("rsVideoContainer") ? b : b.find(".rsVideoContainer");
          a._b7 && a._b7.css({
            width: b.width(),
            height: b.height()
          })
        }, 32)
      });
      var c = e.browser.mozilla;
      a.ev.on("rsAfterParseNode", function (b, f, d) {
        b = e(f);
        if (d.videoURL) {
          c && (a._d = a._e = !1);
          f = e('<div class="rsVideoContainer"></div>');
          var g = e('<div class="rsBtnCenterer"><div class="rsPlayBtn"><div class="rsPlayBtnIcon"></div></div></div>');
          b.hasClass("rsImg") ? d.content = f.append(b).append(g) : d.content.find(".rsImg").wrap(f).after(g)
        }
      })
    },
    toggleVideo: function () {
      return this._i4 ? this.stopVideo() : this.playVideo()
    },
    playVideo: function () {
      var a = this;
      if (!a._i4) {
        var c = a.currSlide;
        if (!c.videoURL) return !1;
        var b = a._c7 = c.content,
          c = c.videoURL,
          f, d;
        c.match(/youtu\.be/i) || c.match(/youtube\.com/i) ? (d = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/, (d = c.match(d)) && 11 == d[7].length && (f = d[7]), void 0 !== f && (a._b7 = a.st.video.youTubeCode.replace("%id%", f))) : c.match(/vimeo\.com/i) && (d = /(www\.)?vimeo.com\/(\d+)($|\/)/, (d = c.match(d)) && (f = d[2]), void 0 !== f && (a._b7 = a.st.video.vimeoCode.replace("%id%", f)));
        a.videoObj = e(a._b7);
        a.ev.trigger("rsOnCreateVideoElement", [c]);
        a.videoObj.length && (a._b7 = e('<div class="rsVideoFrameHolder"><div class="rsPreloader"></div><div class="rsCloseVideoBtn"><div class="rsCloseVideoIcn"></div></div></div>'), a._b7.find(".rsPreloader").after(a.videoObj), b = b.hasClass("rsVideoContainer") ? b : b.find(".rsVideoContainer"), a._b7.css({
          width: b.width(),
          height: b.height()
        }).find(".rsCloseVideoBtn").off("click.rsv").on("click.rsv",

        function (b) {
          a.stopVideo();
          b.preventDefault();
          b.stopPropagation();
          return !1
        }), b.append(a._b7), a.isIPAD && b.addClass("rsIOSVideo"), a._d7(), setTimeout(function () {
          a._b7.addClass("rsVideoActive")
        }, 10), a.ev.trigger("rsVideoPlay"), a._i4 = !0);
        return !0
      }
      return !1
    },
    stopVideo: function () {
      var a = this;
      return a._i4 ? (a.isIPAD && a.slider.find(".rsCloseVideoBtn").remove(), a._d7(!0), setTimeout(function () {
        a.ev.trigger("rsOnDestroyVideoElement", [a.videoObj]);
        var c = a._b7.find("iframe");
        if (c.length) try {
          c.attr("src", "")
        } catch (b) {}
        a._b7.remove();
        a._b7 = null
      }, 16), a.ev.trigger("rsVideoStop"), a._i4 = !1, !0) : !1
    },
    _d7: function (a) {
      var c = [],
        b = this.st.video;
      b.autoHideArrows && (this._b2 && (c.push(this._b2, this._c2), this._d2 = !1), this._v5 && c.push(this._v5));
      b.autoHideControlNav && this._k5 && c.push(this._k5);
      b.autoHideBlocks && this.currSlide.animBlocks && c.push(this.currSlide.animBlocks);
      b.autoHideCaption && this.globalCaption && c.push(this.globalCaption);
      if (c.length) for (b = 0; b < c.length; b++) a ? c[b].removeClass("rsHidden") : c[b].addClass("rsHidden")
    }
  });
  e.rsModules.video = e.rsProto._z6
})(jQuery);
// jquery.rs.visible-nearby v1.0.2
(function (d) {
  d.rsProto._e7 = function () {
    var a = this;
    a.st.visibleNearby && a.st.visibleNearby.enabled && (a._f7 = {
      enabled: !0,
      centerArea: 0.6,
      center: !0,
      breakpoint: 0,
      breakpointCenterArea: 0.8,
      hiddenOverflow: !0,
      navigateByCenterClick: !1
    }, a.st.visibleNearby = d.extend({}, a._f7, a.st.visibleNearby), a.ev.one("rsAfterPropsSetup", function () {
      a._g7 = a._d1.css("overflow", "visible").wrap('<div class="rsVisibleNearbyWrap"></div>').parent();
      a.st.visibleNearby.hiddenOverflow || a._g7.css("overflow", "visible");
      a._n1 = a.st.controlsInside ? a._g7 : a.slider
    }), a.ev.on("rsAfterSizePropSet", function () {
      var b, c = a.st.visibleNearby;
      b = c.breakpoint && a.width < c.breakpoint ? c.breakpointCenterArea : c.centerArea;
      a._g ? (a._z3 *= b, a._g7.css({
        height: a._a4,
        width: a._z3 / b
      }), a._c = a._z3 * (1 - b) / 2 / b) : (a._a4 *= b, a._g7.css({
        height: a._a4 / b,
        width: a._z3
      }), a._c = a._a4 * (1 - b) / 2 / b);
      c.navigateByCenterClick || (a._p = a._g ? a._z3 : a._a4);
      c.center && a._d1.css("margin-" + (a._g ? "left" : "top"), a._c)
    }))
  };
  d.rsModules.visibleNearby = d.rsProto._e7
})(jQuery);
