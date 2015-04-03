// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var EmailFilter = {
    setup: function() {
        $('#email_form').on('click', '#change_filter', EmailFilter.slideOpen);
        $('#filters').on('click', '.x', EmailFilter.remove);
    },
    slideOpen: function() {
        $('#accordian').animate({width: 'toggle'});
    },
    remove: function() {
        var filterText = $(this).prev().text();
        $(this).parent().remove();
        $(".selected").each(function() {
            if ($(this).text() == filterText) {
                $(this).toggleClass('selected');
                return false;
            }
        });
    }
};

$(EmailFilter.setup);