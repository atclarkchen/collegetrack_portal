/*jQuery time*/
var Filter = {
	setup: function() {
		$('#accordian').on('click', 'h3', Filter.slide);
		$('#accordian').on('click', 'a', Filter.highlight);
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
};

$(Filter.setup);