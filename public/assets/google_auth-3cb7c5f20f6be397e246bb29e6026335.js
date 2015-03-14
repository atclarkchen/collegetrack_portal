$(document).on('ready page:load', function () {

  function popupCenter(linkUrl, width, height, name) {
      var separator = (linkUrl.indexOf('?') !== -1) ? '&' : '?',
          url = linkUrl + separator + 'popup=true',
          left = (screen.width - width) / 2,
          top = (screen.height - height) / 2,
          windowFeatures = 'menubar=no,toolbar=no,status=no,width=' + width +
              ',height=' + height + ',left=' + left + ',top=' + top;
      return window.open(url, name, windowFeatures);
  }

  $("a.popup").click(function(e) {
    popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
    e.stopPropagation(); return false;
  });
});
