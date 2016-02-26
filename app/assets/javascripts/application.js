//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .
//= require maskedinput
//= require pickadate/picker
//= require pickadate/picker.date
//= require turbolinks

$(function(){ $(document).foundation(); });

$(document).ready(function() {
  $("#user_phone").mask("(999) 999-99-99");
});
