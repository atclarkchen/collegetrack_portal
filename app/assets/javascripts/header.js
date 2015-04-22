var Navbar = {
  setup: function() {
    $('.navbar').on('click', 'a:first-child', Navbar.logout);
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
  highlight: function() {
    $('nav > div > a').each(function () {
      if (window.location.href.indexOf($(this).text().toLowerCase().trim()) >= 0) {
        $(this).addClass("active");
      }
    });
  }
}

$(Navbar.setup);