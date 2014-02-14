// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.typeahead').typeahead( {
    name: 'beers',
    limit: 20,
    remote: 'http://localhost:3000/api/beers/all'
  });
});