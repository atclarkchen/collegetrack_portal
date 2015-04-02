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
	var filters = [];
	$("#save_filter").parent().find('.selected').each(function () {
	    filters.push($(this).text());
	});
        $.ajax({
	    type: "GET",
	    url: "/email/email_list",
	    data: {"filters":filters},
	    success: function(data) {
		$("#email_bcc").val(data);
	    }
	});
    }
};    
$(Filter.setup);