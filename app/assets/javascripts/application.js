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
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core


document.addEventListener("turbolinks:load", function () {
  tinymce.remove();
  tinymce.init({
    selector: 'textarea#post_body',
    plugins: 'image media link',
    toolbar: 'undo redo | styleselect | bold italic | image media | link'

  });
});

$.fn.datepicker.dates['en'] = {
  days: ["Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"],
  daysShort: ["Nie", "Pon", "Wto", "Śro", "Czw", "Pia", "Sob"],
  daysMin: ["Ni", "Pn", "Wt", "Śr", "Cz", "Pt", "So"],
  months: ["Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec", "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"],
  monthsShort: ["Sty", "Lut", "Mar", "Kwi", "Maj", "Cze", "Lip", "Sie", "Wrz", "Paź", "Lis", "Gru"],
  today: "Dziś",
  clear: "Wyczyść",
  format: "mm/dd/yyyy",
  titleFormat: "MM yyyy", /* Leverages same syntax as 'format' */
  weekStart: 0,
  todayHighlight: true
};


