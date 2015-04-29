$(document).ready(function() {
  // Disable autoDiscover
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#email_form").dropzone({
    uploadMultiple: true,
    paramName: "email[files]",
    maxFilesize: 4,
    addRemoveLinks: true,
    autoProcessQueue: false,
    parallelUploads: 50,
    maxFiles: 10,
    previewsContainer: "#dropzone-preview",

    init: function() {
      var myDropzone = this;
      var submitButton;

      $("input[type=submit]").on("click", function() {
        submitButton = $(this).val();
      });

      $('#email_form').on("submit", function(e) {
        if(myDropzone.getQueuedFiles().length > 0) {
          e.preventDefault();
          e.stopPropagation();
          tinymce.get('email_body').save();
          myDropzone.processQueue();
        } else {
          var formData = form.serializedArray();
          formData.push({ name: "user_press", value: submitButton });
          $.ajax({
            type: form.attr('method'),
            url:  form.attr('action'),
            data: formData,
            success: function(data) {
              if(data.status == "redirect") {
                window.location = data.to;
              }
            }
          });
        }
      });

      this.on("sendingmultiple", function(file, xhr, formData) {
        formData.append('user_press', submitButton);
      });

      this.on("successmultiple", function(file, data) {
        if(data.status == "redirect") {
          window.location = data.to;
        }
      });
    }
  });
});