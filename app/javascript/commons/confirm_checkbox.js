$(document).on("turbolinks:load", function () {
  const confirm_checkbox = document.getElementById("js-confirm-checkbox");
  const active_button = document.getElementById("js-active_button");
  const inactive_button = document.getElementById("js-inactive_button");
  if (confirm_checkbox) {
    confirm_checkbox.addEventListener("change", function () {
      if (confirm_checkbox.checked) {
        active_button.classList.remove("u-display-none");
        inactive_button.classList.add("u-display-none");
      } else {
        active_button.classList.add("u-display-none");
        inactive_button.classList.remove("u-display-none");
      }
    });
  }
});
