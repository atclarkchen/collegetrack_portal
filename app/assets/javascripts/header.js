var Navbar = {
  setup: function() {
    $('.navbar').on('click', 'a:first-child', Navbar.logout);

    /* Call save draft when leaving url */
    //$(window).on("unload", Navbar.saveDraft);

    Navbar.highlight();
  },
  logout: function() {
    swal({
      title: "Are you sure you want to logout?",
      type: "warning",
      showCancelButton: true,
      confirmButtonClass: "btn-danger",
      confirmButtonText: "Yes",
      closeOnConfirm: true
    },
    function(){
      $.ajax({
        url: "/users/sign_out/",
        method: "delete",
        success: function(html) {
          window.location = '/'
        }
      });
    });
    return false;
  },
  /*
  saveDraft: function() {
    if ($(location).prop('pathname') == "/email") {
      $.ajax({
        type: "GET",
        url: "/email/save_draft"
      });
    }
  },
  */
  highlight: function() {
    $('nav > div > a').each(function () {
      if (window.location.href.indexOf($(this).text().toLowerCase().trim()) >= 0) {
        $(this).addClass("active");
      }
    });
  }
}

$(Navbar.setup);