// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require rails-ujs
//= require activestorage
//= require_tree
//= require bootstrap-material-design/dist/js/bootstrap-material-design.js
//= require swiper/js/swiper.js
//= require swiper.js

function previewFileWithId(selector) {
  const target = this.event.target;
  const file = target.files[0];
  const reader  = new FileReader();
  reader.onloadend = function () {
      selector.src = reader.result;
  }
  if (file) {
      reader.readAsDataURL(file);
  } else {
      selector.src = "";
  }
}