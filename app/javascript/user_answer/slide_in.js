$(document).on("turbolinks:load", function () {
  const toggle = document.getElementById("slide_in_toggle");
  const toggleMessage = document.getElementById("slide_in_toggle_message");
  const slideIn = document.getElementById("slide_in");

  if (slideIn) {
    toggle.onclick = function () {
      slideIn.classList.toggle("open");
      toggle.classList.toggle("open");
      if (slideIn.classList.contains("open")) {
        toggleMessage.innerText = "閉じる";
      } else {
        toggleMessage.innerText = "問題を見る";
      }
    };
  }
});
