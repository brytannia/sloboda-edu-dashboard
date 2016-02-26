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

var text;
$(document).ready(function() {
  current_uri = document.location.pathname;
  $("#user_phone").mask("(999) 999-99-99");
  $('a').removeClass('currentPage');

  if (current_uri == gon.current_profile) {
    text = 'My profile';
  } else if (current_uri == gon.current_users) {
    text = 'Colleagues';
  } else {
    text = '';
  }

  current_link = $('a').filter(function(index) {
    return $(this).text() === text;
  });
  current_link.addClass('currentPage');
});
