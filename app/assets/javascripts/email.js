// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var FilterToggle = {
	setup: function() {
		$('#email_form').on('click', '#change_filter', FilterToggle.slideOpen);
	},
	slideOpen: function() {
	    $('#accordian').animate({width: 'toggle'});
    }
};

$(FilterToggle.setup);