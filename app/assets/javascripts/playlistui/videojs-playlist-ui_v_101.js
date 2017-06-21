/*! videojs-playlist-ui - v1.0.1 - 2015-03-30
* Copyright (c) 2015 Brightcove; Licensed Apache-2.0 */

(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/*! videojs-playlist-ui - v0.0.0 - 2015-3-12
 * Copyright (c) 2015 Brightcove
 * Licensed under the Apache-2.0 license. */

// Array#indexOf analog for IE8
"use strict";

var indexOf = function indexOf(array, target) {
  for (var i = 0, _length = array.length; i < _length; i++) {
    if (array[i] === target) {
      return i;
    }
  }
  return -1;
};

// see https://github.com/Modernizr/Modernizr/blob/master/feature-detects/css/pointerevents.js
var supportsCssPointerEvents = (function () {
  var element = document.createElement("x");
  element.style.cssText = "pointer-events:auto";
  return element.style.pointerEvents === "auto";
})();

var defaults = {
  className: "vjs-playlist",
  supportsCssPointerEvents: supportsCssPointerEvents
};

var createThumbnail = function createThumbnail(thumbnail) {
  if (!thumbnail) {
    var placeholder = document.createElement("div");
    placeholder.className = "vjs-playlist-thumbnail";
    return placeholder;
  }

  var picture = document.createElement("picture");
  picture.className = "vjs-playlist-thumbnail";

  if (typeof thumbnail === "string") {
    // simple thumbnails
    var img = document.createElement("img");
    img.src = thumbnail;
    picture.appendChild(img);
  } else {
    // responsive thumbnails

    // additional variations of a <picture> are specified as
    // <source> elements
    for (var i = 0; i < thumbnail.length - 1; i++) {
      var _variant = thumbnail[i];
      var source = document.createElement("source");
      // transfer the properties of each variant onto a <source>
      for (var prop in _variant) {
        source[prop] = _variant[prop];
      }
      picture.appendChild(source);
    }

    // the default version of a <picture> is specified by an <img>
    var variant = thumbnail[thumbnail.length - 1];
    var img = document.createElement("img");
    for (var prop in variant) {
      img[prop] = variant[prop];
    }
    picture.appendChild(img);
  }
  return picture;
};

videojs.PlaylistMenuItem = videojs.Component.extend({
  init: function init(player, options) {
    var _this = this;

    if (!options.item) {
      throw new Error("Cannot construct a PlaylistMenuItem without an item option");
    }
    // stub out the element so Component doesn't construct one
    options.el = true;
    videojs.Component.call(this, player, options);
    this.el_ = this.createEl(options.item);

    this.item = options.item;
    this.emitTapEvents();

    this.on(["click", "tap"], function (event) {
      player.playlist.currentItem(indexOf(player.playlist(), _this.item));
    });
  },
  createEl: function createEl(item) {
    var li = document.createElement("li");
    li.className = "vjs-playlist-item";

    // Thumbnail image
    li.appendChild(createThumbnail(item.thumbnail));

    // Duration
    if (item.duration) {
      var duration = document.createElement("time");
      var time = videojs.formatTime(item.duration);
      duration.className = "vjs-playlist-duration";
      duration.setAttribute("datetime", "PT0H0M" + item.duration + "S");
      duration.appendChild(document.createTextNode(time));
      li.appendChild(duration);
    }

    // Name and description
    var name = document.createElement("cite");
    var nameValue = item.name || this.localize("Untitled Video");
    name.className = "vjs-playlist-name";
    name.appendChild(document.createTextNode(nameValue));
    name.setAttribute("title", nameValue);
    li.appendChild(name);

    if (item.description) {
      var description = document.createElement("p");
      description.className = "vjs-playlist-description";
      description.appendChild(document.createTextNode(item.description));
      description.setAttribute("title", item.description);
      li.appendChild(description);
    }
    return li;
  }
});

videojs.PlaylistMenu = videojs.Component.extend({
  init: function init(player, options) {
    var _this = this;

    if (!player.playlist) {
      throw new Error("videojs-playlist is required for the playlist component");
    }

    var settings = videojs.util.mergeOptions(defaults, options);

    if (!settings.el) {
      this.el_ = document.createElement("ol");
      this.el_.className = settings.className;
      settings.el = this.el_;
    }

    videojs.Component.call(this, player, settings);

    // If CSS pointer events aren't supported, we have to prevent
    // clicking on playlist items during ads with slightly more
    // invasive techniques. Details in the stylesheet.
    if (settings.supportsCssPointerEvents) {
      this.addClass("vjs-csspointerevents");
    }

    this.createPlaylist_();

    if (!videojs.TOUCH_ENABLED) {
      this.addClass("vjs-mouse");
    }

    player.on(["loadstart", "playlistchange"], function (event) {
      _this.update();
    });

    // keep track of whether an ad is playing so that the menu
    // appearance can be adapted appropriately
    player.on("adstart", function () {
      _this.addClass("vjs-ad-playing");
    });
    player.on("adend", function () {
      _this.removeClass("vjs-ad-playing");
    });
  },
  createPlaylist_: function createPlaylist_() {
    var playlist = this.player_.playlist() || [];

    // remove any existing items
    for (var i = 0; i < this.items.length; i++) {
      this.removeChild(this.items[i]);
    }
    this.items.length = 0;
    var overlay = this.el_.querySelector(".vjs-playlist-ad-overlay");
    if (overlay) {
      overlay.parentNode.removeChild(overlay);
    }

    // create new items
    for (var i = 0; i < playlist.length; i++) {
      var item = new videojs.PlaylistMenuItem(this.player_, {
        item: playlist[i]
      });
      this.items.push(item);
      this.addChild(item);
    }

    // Inject the ad overlay. IE<11 doesn't support "pointer-events:
    // none" so we use this element to block clicks during ad
    // playback.
    overlay = document.createElement("li");
    overlay.className = "vjs-playlist-ad-overlay";
    this.el_.appendChild(overlay);

    // select the current playlist item
    var selectedIndex = this.player_.playlist.currentItem();
    if (this.items.length && selectedIndex >= 0) {
      this.items[selectedIndex].addClass("vjs-selected");
    }
  },
  items: [],
  update: function update() {
    // replace the playlist items being displayed, if necessary
    var playlist = this.player_.playlist();
    if (this.items.length !== playlist.length) {
      // if the menu is currently empty or the state is obviously out
      // of date, rebuild everything.
      this.createPlaylist_();
      return;
    }
    for (var i = 0; i < this.items; i++) {
      if (this.items[i].item !== playlist[i]) {
        // if any of the playlist items have changed, rebuild the
        // entire playlist
        this.createPlaylist_();
        return;
      }
    }

    // the playlist itself is unchanged so just update the selection
    var currentItem = this.player_.playlist.currentItem();
    for (var i = 0; i < this.items.length; i++) {
      if (i === currentItem) {
        this.items[i].addClass("vjs-selected");
      } else {
        this.items[i].removeClass("vjs-selected");
      }
    }
  }
});

/**
 * Initialize the plugin.
 * @param options (optional) {object} configuration for the plugin
 */
var playlistUi = function playlistUi(options) {
  var player = this;
  var settings = undefined,
      elem = undefined;

  if (!player.playlist) {
    throw new Error("videojs-playlist is required for the playlist component");
  }

  // if the first argument is a DOM element, use it to build the component
  if (typeof HTMLElement !== "undefined" && options instanceof HTMLElement || options && options.nodeType === 1) {
    elem = options;
    settings = videojs.util.mergeOptions(defaults);
  } else {
    // lookup the elements to use by class name
    settings = videojs.util.mergeOptions(defaults, options);
    elem = document.querySelector("." + settings.className);
  }

  // build the playlist menu
  settings.el = elem;
  player.playlistMenu = new videojs.PlaylistMenu(player, settings);
};

// register the plugin
videojs.plugin("playlistUi", playlistUi);

// IE8 does not define HTMLElement so use a hackier type check

},{}]},{},[1]);
