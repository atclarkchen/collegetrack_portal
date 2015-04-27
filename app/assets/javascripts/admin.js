var Admin = {
  setup: function() {
    $('#users').on('click', '.x_button', Admin.destroy);
    $('#add_user_form').on('submit', Admin.submit);
  },
  destroy: function() {
    var email = $(this).parent().prev().prev().text();
    swal({
      title: "Are you sure?",
      text: "Your will have to re-add the user!",
      type: "error",
      showCancelButton: true,
      confirmButtonClass: "btn-danger",
      confirmButtonText: "Yes",
      closeOnConfirm: false
    },
    function(){
      swal("Deleted!", "User has been deleted.", "success");
      $.ajax({
        url: "/admin/",
        method: "delete",
        data: {"email": email},
        success: function(html) {
          $('#users').html(html);
          $('#add_user_form')[0].reset();
        }
      });
    });
  },
  submit: function() {
    $.ajax({
      url: "/admin/",
      method: "post",
      data: $('#add_user_form').serialize(),
      success: function(html) {
        toastr.options.positionClass = "toast-bottom-right";
        toastr.success('Email added');
        $('#users').html(html);
        $('#add_user_form')[0].reset();
      }
    });
    return false;
  }
}

$(Admin.setup);