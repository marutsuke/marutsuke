$(document).on("turbolinks:load", function () {
  const confirm_checkbox = document.getElementById("js-confirm-checkbox");
  const active_sign_up_btn = document.getElementById("js-active_sign_up_btn");
  const inactive_sign_up_btn = document.getElementById(
    "js-inactive_sign_up_btn"
  );
  if (confirm_checkbox) {
    confirm_checkbox.addEventListener("change", function () {
      if (confirm_checkbox.checked) {
        active_sign_up_btn.classList.remove("u-display-none");
        inactive_sign_up_btn.classList.add("u-display-none");
      } else {
        active_sign_up_btn.classList.add("u-display-none");
        inactive_sign_up_btn.classList.remove("u-display-none");
      }
    });
  }
});
