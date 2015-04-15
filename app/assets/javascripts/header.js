$(document).ready(function () {
    $('nav > a').each(function () {
	if (window.location.href.match(new RegExp(this.text,"i"))) {
	    $(this).addClass("active");
	}
    });
});