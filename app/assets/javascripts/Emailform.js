Dropzone.options.emailForm = {
  uploadMultiple: true,
  paramName: "email[files]",
  maxFilesize: 4,
  addRemoveLinks: true,
  autoProcessQueue: false,
  parallelUploads: 100,
  maxFiles: 5,

  init: function() {
    var myDropzone = this;

    // First change the button to actually tell Dropzone to process the queue.
    this.element.querySelector("#btn-upload").addEventListener("click", function(e) {
      // Make sure that the form isn't actually being sent.
      e.preventDefault();
      e.stopPropagation();
      myDropzone.processQueue();
    });
  }
};