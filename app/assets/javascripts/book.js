$(function(){
  //ここから、createアクション用
  //book追加
  // $('.add-book-form').on('submit', function(e){
  //   e.preventDefault();
  //   let href = "/books"
  //   console.log(href);
  //   $.ajax({
  //     url: href,
  //     type: "POST"
  //   })
  //   .done(function(){
  //     alert('登録しました！');
  //     $('.add-book-input').val('')
  //   })
  //   .fail(function(){
  //     alert('エラーです');
  //   })
  // })

  //

  //このしたはトップページのインデックス用
  //この下はSection表示用-----------------------------------
  function appendSections(section){
    let html = `<li class="index-lists_list section-lists  animated bounceInRight faster" data-section_id=${section.id}><a href="/chapters/${section.chapter_id}/sections/${section.id}">${section.section}</a>
    </li>`;
    $('.main-contain_row_section').append(html);
  }
  function appendAddSection(chapter_id){
    let html = `<form class="animated bounceInRight faster section-lists">
    <input type="text" class="col-12 mt-1" id="inlineFormInput" placeholder="">
    <button type="submit" class="btn btn-light btn-sm  add-section section-lists col-3 float-right" style="min-width: 4rem; data-chapter_id=${chapter_id}">追加</button>
    </form>`
    $('.main-contain_row_section').append(html);
  }
  //マウスを上にすると光る。
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
      if (sections.length != 0){
        appendAddSection(sections[0].chapter_id);
      } else {
        appendAddSection(0);
      }
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })

  // ーーーーーーーーこの下はchapter表示用jQuery----------------
  function appendChapter(chapter){
    let html = `<li class="index-lists_list chapter-lists  chapter-lists-mouse  animated bounceInRight faster" data-chapter_id=${chapter.id}>${chapter.chapter}</li><div class=" chapter-lists animated bounceInRight faster" data-book_id=${chapter.book_id}></div>`;
    $('.main-contain_row_chapter').append(html);
  }
  function appendAddCapter(book_id){
    let html = `<form class="animated bounceInRight faster chapter-lists">
    <input type="text" class="col-12 mt-1" id="inlineFormInput" placeholder="">
    <button type="submit" class="btn btn-light btn-sm  add-chapter chapter-lists col-3 float-right" style="min-width: 4rem; data-book_id=${book_id}">追加</button>
    </form>`
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
      $('.section-lists').remove();
      chapters.forEach(function(chapter){
        appendChapter(chapter);
      });
      if (chapters.length != 0){
        appendAddCapter(chapters[0].book_id);
      } else {
        appendAddCapter(0);
      }
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })
  // ーーーーーーーーこの上はchapter表示用jQuery----------------
})