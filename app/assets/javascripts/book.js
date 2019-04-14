$(function(){
  //この下はSection表示用-----------------------------------
  function appendSections(section){
    let html = `<li class="index-lists_list section-lists" data-section_id=${section.id}>${section.section}</li>`;
    $('.main-contain_row_section').append(html);
  }
  //マウスを上にすると光る。
  $(document).on("mouseover", ".chapter-lists",
    function(){
    $(this).addClass("jq-red");
  });
  $(document).on("mouseout", ".chapter-lists",
    function(){
    $(this).removeClass("jq-red");
  });
  $(document).on("click", ".chapter-lists",
    function(){
    $(this).toggleClass("jq-blue");
  });


  //clickしたらsectionがでる
  $(document).on('click','.chapter-lists', function(e){
    e.preventDefault();
    let chapter_id = $(this).data('chapter_id');
    let book_id = $(this).next().data('book_id');
    href = "/books/" + book_id.toString();+ "/chapters/" + chapter_id.toString();
    ///books/:book_id/chapters/:id
    $.ajax({
      url: href,
      type: "GET",
      data: {chapterid: chapter_id},
      dataType: 'json'
    })
    .done(function(sections){
      // $('.chapter-lists').remove();
      sections.forEach(function(section){
        appendSections(section);
      });
      console.log(sections)
    })
    .fail(function(){
      alert('エラーです');
      console.log("エラー")
    })
    .always(() => {
    })
  })




  // ーーーーーーーーこの下はchapter表示用jQuery----------------
  function appendChapters(chapter){
    let html = `<li class="index-lists_list chapter-lists" data-chapter_id=${chapter.id}>${chapter.chapter}</li><div class="chapter-lists" data-book_id=${chapter.book_id}></div>`;
    $('.main-contain_row_chapter').append(html);
  }
  //マウスを上にすると光る。クリックしたら色が変わる。
  $('.index-lists_list-book').on('mouseover', function(){
    $(this).addClass("jq-red");
  });
  $('.index-lists_list-book').on('mouseout', function(){
    $(this).removeClass("jq-red");
  });
  $('.index-lists_list-book').on('click', function(){
    $(this).toggleClass("jq-blue");
  });


  //clickしたらchapterがでる
  $('.index-lists_list-book').on('click', function(e){
    e.preventDefault();
    let book_id = $(this).data('book_id');
    href = "/books/" + book_id.toString();
    $.ajax({
      url: href,
      type: "GET",
      data: {bookid: book_id},
      dataType: 'json'
    })
    .done(function(chapters){
      $('.chapter-lists').remove();
      chapters.forEach(function(chapter){
        appendChapters(chapter);
      });
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })
  // ーーーーーーーーこの上はchapter表示用jQuery----------------
})