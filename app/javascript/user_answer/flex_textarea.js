$(document).on("turbolinks:load", function () {
  const text_area_dummy = document.getElementById(
    "js-user-answer-form-text-area-dummy"
  );

  const text_area = document.getElementById("js-user-answer-form-text-area");

  if (text_area) {
    text_area.addEventListener("input", function () {
      text_area_dummy.textContent = text_area.value + "\u200b";
    });
  }
});
