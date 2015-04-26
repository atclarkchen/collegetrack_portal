Dropzone.options.emailForm = {
  uploadMultiple: true,
  paramName: "email[files]",
  maxFilesize: 4,
  addRemoveLinks: true,
  autoProcessQueue: false,
  parallelUploads: 50,
  maxFiles: 10,
  clickable: false,
  previewsContainer: "#dropzone-preview",

  init: function() {
    var myDropzone = this;

    $('input[type="submit"]').on("click", function(e) {
      e.preventDefault();
      e.stopPropagation();
      myDropzone.processQueue();

      // if(myDropzone.getQueuedFiles().length > 0) {
      //   myDropzone.processQueue();
      // }
      // } else {
      //   myDropzone.uploadFiles([ ]);
      // }
    });
  }
};