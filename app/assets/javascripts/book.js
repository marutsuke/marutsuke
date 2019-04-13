$(function(){
  function appendHTML(chapter){
    let html = `<li class="index-lists_list" data-id=${chapter.id}>${chapter.chapter}</li>`;
    $('.main-contain_row_chapter').append(html);
  }


  let reloadMessages = function(){


  last_message_id = $('.main--contents__wrap').last().data('msgid')


  href = window.location.href.replace(/messages/,"api/") + 'messages'
    $.ajax({
      type: 'GET',
      url: href,
      data: {id: last_message_id},
      dataType: 'json'
    })
    .done(function(messages) {
      messages.forEach(function(message){
      let html = buildHTML(message);
      $('.main--contents').append(html)
      $('.main--contents').animate({ scrollTop: $('.main--contents')[0].scrollHeight}, 1000);
      });
    })
    .fail(function(){
    });
  }


  reloadMessages
  // setInterval(reloadMessages, 5000);



  $('.jquery-api__form').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let href = $(this).attr('action');
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.main--contents').append(html)
      $('.jquery-api__text').val('')
      $('.main--contents').animate({ scrollTop: $('.main--contents')[0].scrollHeight}, 1000);
    })
    .fail(function(){
      alert('error');
    })
    .always(() => {
      $(".bottom-button").removeAttr("disabled");
    })
  })
})
