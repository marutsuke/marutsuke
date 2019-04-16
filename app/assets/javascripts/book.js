$(function(){
  //この下はSection表示用-----------------------------------
  function appendSections(section){
    let html = `<li class="index-lists_list section-lists  animated bounceInDown faster" data-section_id=${section.id}><a href="/chapters/${section.chapter_id}/sections/${section.id}">${section.section}</a>
    </li>`;
    $('.main-contain_row_section').append(html);
  }
  $(document).on("mouseover", ".chapter-lists-mouse",
    function(){
    $(this).addClass("jq-red");
  });
  $(document).on("mouseout", ".chapter-lists-mouse",
    function(){
    $(this).removeClass("jq-red");
  });
  $(document).on("click", ".chapter-lists-mouse",
    function(){
      $('.chapter-lists-mouse').removeClass("jq-blue");
      $(this).toggleClass("jq-blue");
  });

  //clickしたらsectionがでる
  $(document).on('click','.chapter-lists', function(e){
    e.preventDefault();
    let chapter_id = $(this).data('chapter_id');
    let book_id = $(this).next().data('book_id');
    href = "/books/" + book_id.toString()+ "/chapters/" + chapter_id.toString();
    $.ajax({
      url: href,
      type: "GET",
      data: {chapterid: chapter_id},
      dataType: 'json'
    })
    .done(function(sections){
      $('.section-lists').remove();
      sections.forEach(function(section){
        appendSections(section);
      });
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })

  // ーーーーーーーーこの下はchapter表示用jQuery----------------
  function appendChapter(chapter){
    let html = `<li class="index-lists_list chapter-lists  chapter-lists-mouse  animated bounceInDown faster" data-chapter_id=${chapter.id}>${chapter.chapter}</li><div class="chapter-lists animated bounceInDown faster" data-book_id=${chapter.book_id}></div>`;
    $('.main-contain_row_chapter').append(html);
  }
  $('.index-lists_list-book').on('mouseover', function(){
    $(this).addClass("jq-red");
  });
  $('.index-lists_list-book').on('mouseout', function(){
    $(this).removeClass("jq-red");
  });
  $('.index-lists_list-book').on('click', function(){
    $('.index-lists_list-book').removeClass("jq-blue");
    $(this).toggleClass("jq-blue");
  });


  //clickしたらchapterがでる
  $('.index-lists_list-book').on('click', function(e){
    // e.preventDefault();これがあるとaタグが反応しない！！！！森口さんありがとう！
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
      $('.section-lists').remove();
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
  // ーーーーーーーーこの上はchapter表示用jQuery----------------
})