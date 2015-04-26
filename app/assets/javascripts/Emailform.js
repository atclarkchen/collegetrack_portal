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

      $('input[type="submit"]').on("click", function(e) {
        e.preventDefault();
        e.stopPropagation();

        if(myDropzone.getQueuedFiles().length > 0) {
          window.alert("files in queue");
          myDropzone.processQueue();
        }
        // } else {
        //   $('#email_form').submit();
        // }
      });
    }
  });
});