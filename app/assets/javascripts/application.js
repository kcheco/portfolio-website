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
//= require jquery
//= require rails-ujs
//= require jquery-ui/core
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/sortable
//= require popper
//= require bootstrap
//= require html5sortable
// require turbolinks
//= require_tree .

$(document).ready(function () {

  $('#book_date_read, #watched_video_date_viewed, #project_date_completed').datepicker({
    dateFormat: 'yy-mm-dd',
    defaultYear: '0d',
    changeYear: true,
    minDate: new Date(2013, 1-1, 1),
    maxDate: '0d',
    showAnim: "fadeIn",
    changeMonth: true,
    changeYear: true,
    showButtonPanel: true
  });

  $('.dropdown-toggle').dropdown();

});
