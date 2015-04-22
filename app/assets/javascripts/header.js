$(document).ready(function () {
    $('nav > div > a').each(function () {
        if (window.location.href.indexOf($(this).text().toLowerCase().trim()) >= 0) {
            $(this).addClass("active");
        }
    });
});