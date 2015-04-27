Dropzone.options.emailForm = {
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

    $('input[type="submit"]').addEventListener("click", function(e){
      myDropzone.processQueue();
    });
  }
};

// $(document).ready(function() {
//   // Disable autoDiscover
//   Dropzone.autoDiscover = false;

//   // grap our upload form by its id
//   $("#email_form").dropzone({
//     uploadMultiple: true,
//     paramName: "email[files]",
//     maxFilesize: 4,
//     addRemoveLinks: true,
//     // autoProcessQueue: false,
//     parallelUploads: 50,
//     maxFiles: 10,
//     previewsContainer: "#dropzone-preview",

//     // init: function() {
//     //   var myDropzone = this;

//     //   var submitForm = document.querySelector("#send_draft");

//     //   submitForm.addEventListener('click', function(e) {

//     //   });
//     // }
//   });
// });