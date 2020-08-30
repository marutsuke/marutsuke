$(document).on('turbolinks:load', function() {

  if (document.getElementById('modal')) {
    const modal = document.getElementById('modal');
    const mask = document.getElementById('modal-mask');
    const open = document.getElementById('modal-open');
    const close = document.getElementById('modal-close');

    open.addEventListener('click', function () {
      modal.classList.remove('hidden');
      mask.classList.remove('hidden');
    });
    close.addEventListener('click', function () {
      modal.classList.add('hidden');
      mask.classList.add('hidden');
    });
    mask.addEventListener('click', function () {
      modal.classList.add('hidden');
      mask.classList.add('hidden');
    });
  }

});
