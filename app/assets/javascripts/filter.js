/*jQuery time*/
var Filter = {
    setup: function() {
        $('#accordian').on('click', 'h3', Filter.slide);
        $('#accordian').on('click', 'a', Filter.highlight);
        $('#accordian').on('click', '#save_filter', Filter.save);
        Filter.pull_emails();
    },
    slide: function() {
        $('#accordian ul ul').slideUp();
        if (!$(this).next().is(":visible")) {
            $(this).next().slideDown();
        }
    },
    highlight: function() {
        $(this).toggleClass('selected');
        return false;
    },
    save: function() {
        $('#filters').empty();
        $(this).parent().find('.selected').each(function () {
            $('#filters').append("<span class='ui_fil'><div class='left_fil'>" + $(this).text() + "</div><div class='x'></div></span>");
        });
        $('#accordian ul ul').slideUp();
        $('#accordian').animate({width: 'toggle'});
        Filter.pull_emails();
    },
    pull_emails: function() {
        var filters = {};
        $("#save_filter").parent().find('h3').each(function () {
            var category = $(this).text();
            var selected = [];
            $(this).next().find('.selected').each(function() {
                selected.push($(this).text());
            });
            filters[category] = selected;
        });
        $.ajax({
            type: "GET",
            url: "/email/email_list",
            data: {"filters": filters},
            success: function(data) {
                console.log(data);
                $('.filter_box').remove();
                for (var email of data) {
                    $('#recipient_bcc').prepend("<div class='filter_box'><span class='ui_fil'><div class ='left_fil'>" + email + "</div><div class='x'></div></span><input name='email[bcc]' type='hidden' value='" + email + "'></div>");
                }
                $(RecipientField.resizeField);
            }
        });
    },
};
$(Filter.setup);