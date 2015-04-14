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
        Filter.pull_emails();
    }
};

var editBox;
var allowedRepeat = false;
var RecipientField = {
    setup: function() {
        $('td').on('dblclick', '.filter_box, .edit_box', RecipientField.edit);
        $('td').on('keypress', '.recipient_text', RecipientField.checkEnter);
        $('td').on('keydown', '.recipient_text', RecipientField.checkBackspace);
        $('td').on('keyup', '.recipient_text', RecipientField.checkSpace);
        $('td').on('input', '.recipient_text', RecipientField.autoGrow);
        $('td').on('blur', '.recipient_text', RecipientField.restore);
        $('td').on('selectstart', '.filter_box, .edit_box', RecipientField.disableSelect);
        $('td').on('click', '.x', RecipientField.remove);
        $('td').on('keypress', '#email_subject', RecipientField.disableEnter);
    },
    disableSelect: function() {
        return false;
    },
    disableEnter: function() {
        var key = (event.keyCode ? event.keyCode : event.which);
        if (key === 13) {
            return false;
        }
    },
    edit: function() {
        editBox = $('.recipient_text').detach();
        var boxWidth = $(this).outerWidth();
        $(this).replaceWith('<textarea class="recipient_text" rows="1" style="width: ' + boxWidth + 'px;">' + $(this).text() + '</textarea>');
        $('.recipient_text').select();
        return false;
    },
    restore: function() {
        var email = $(this).val().trim();
        var parent = $(this).parent();
        if (email === '') {
            $(this).remove();
        } else {
            $(this).replaceWith("<div class='edit_box'><span class='ui_fil'><div class ='left_fil'>" + email + "</div><div class='x'></div></span><input name='email[bcc]' type='hidden' value='" + email + "'></div>");
        }
        $(parent).append('<textarea class="recipient_text" rows="1"></textarea>');
        $(RecipientField.resizeField);
    },
    remove: function() {
        $(this).parent().parent().remove();
        $(RecipientField.resizeField);
    },
    resizeField: function() {
        var rowWidth = 0;
        var divWidth = $('#recipient_bcc').width();
        $('#recipient_bcc').children('div').each(function() {
            cellWidth = $(this).outerWidth();
            if (rowWidth + cellWidth > divWidth) {
                rowWidth = 0; 
            }
            rowWidth += $(this).outerWidth();
        });
        var resizeWidth = divWidth - rowWidth - 20;
        if (resizeWidth < 40) {
            resizeWidth = divWidth;
        } 
        $('.recipient_text').outerWidth(resizeWidth);
    },
    autoGrow: function() {
        allowedRepeat = false;
        var elem = $(this)
        setTimeout(function () {
            var width = RecipientField.getTextWidth(elem);
            var divWidth = $('#recipient_bcc').width();
            if (width + 100 >= divWidth) {
                width = divWidth - 20;
            }
            $(elem).width(width + 40);
        }, 100);
    },
    getTextWidth: function(elem) {
        var html_calc = $('<span>' + $(elem).val() + '</span>');
        html_calc.css('font-size',$(elem).css('font-size')).hide();
        html_calc.prependTo('body');
        var width = html_calc.outerWidth();
        html_calc.remove();
        return width;
    },
    checkEnter: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        if (key === 13) {
            var parent = $(this).parent();
            $(this).blur();
            $(parent).find('.recipient_text').select();
            return false;
        }
    },
    checkBackspace: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        if (!allowedRepeat) return;
        if ($(this).val() === '' && key === 8) {
            $(this).prev().remove();
            allowedRepeat = false;
        }
    },
    checkSpace: function(e) {
        var key = (e.keyCode ? e.keyCode : e.which);
        var email = $(this).val().trim();
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (key === 8 && $(this).val() === '') {
            allowedRepeat = true;
        } else if (key === 32 && filter.test(email)) {
            var parent = $(this).parent();
            $(this).blur();
            $(parent).find('.recipient_text').select();
            return false;
        }
    }
}


$(EmailFilter.setup);
$(RecipientField.setup);


// Expanding textarea still weird.
// Parse pasted text delimiters = space and comma
// shrink away when clicking away from div