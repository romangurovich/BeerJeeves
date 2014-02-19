// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('#beers-search').select2({
    minimumInputLength: 2,
    ajax: {
      url: "../api/beers/autocomplete",
      dataType: 'json',
      data: function (term, page) {
        return {
          query: term
        };
      },
      results: function (data, page) {
        return { results: data };
      }
    }
  });

});
