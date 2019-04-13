$(function(){
  function appendChapter(chapter){
    let html = `<li class="index-lists_list" data-id=${chapter.id}>${chapter.chapter}</li>`;
    $('.main-contain_row_chapter').append(html);
  }


  $('.index-lists_list-book').on('click', function(e){
    e.preventDefault();
    let book_id = $(this).data('book_id');
    href = "/books/" + book_id.toString();
    console.log(href);
    $.ajax({
      url: "/books/" + book_id.toString(),
      type: "GET",
      data: {bookid: book_id},
      dataType: 'json'
    })
    .done(function(chapters){
      chapters.forEach(function(chapter){
        appendChapter(chapter);
      });
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })
})
