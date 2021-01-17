$(document).on("turbolinks:load", function () {
  const text_area_dummy = document.getElementById(
    "js-user-answer-form-text-area-dummy"
  );

  const text_area = document.getElementById("js-user-answer-form-text-area");

  const hidden_area = document.getElementById(
    "js-user-answer-form-hidden-area"
  );

  const cancel_area = document.getElementById("js-user-answer-form-cancel");

  if (text_area) {
    text_area.addEventListener("input", function () {
      text_area_dummy.textContent = text_area.value + "\u200b";
    });
    text_area.addEventListener("focus", function () {
      hidden_area.classList.remove("u-display-none");
    });
    cancel_area.addEventListener("click", function () {
      hidden_area.classList.add("u-display-none");
    });
  }
});
