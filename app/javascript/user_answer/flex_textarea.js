$(document).on("turbolinks:load", function () {
  if ($("#answer_text").length) {
    var $textarea = $("#answer_text");
    var lineHeight = parseInt($textarea.css("lineHeight"));

    $textarea.on("input", function (e) {
      var lines = ($(this).val() + "\n").match(/\n/g).length;
      $(this).height(lineHeight * lines);
    });
  }
});
