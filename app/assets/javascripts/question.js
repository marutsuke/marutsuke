$(function(){
  // $("marutsuke").on('click', function(e){
  //   e.preventDefault();
  //   let answer = $(".input-answer").val();
  //   let book_id = $(this).next().data('book_id');
  //   href = "/books/" + book_id.toString()+ "/chapters/" + chapter_id.toString();
  //   $.ajax({
  //     url: href,
  //     type: "GET",
  //     data: {chapterid: chapter_id},
  //     dataType: 'json'
  //   })
  //   .done(function(sections){
  //     });
  //   })
  //   .fail(function(){
  //     alert('エラーです');
  //   })
  //   .always(() => {
  //   })
  // })
  // console.log(3)
  //この下は小問を作成用-----------------------------------
  function appendSmallQuestionFrom(){
    let count = $(".count").length + 1;
    let html = `<textarea type="textarea" class="count col-10 offset-1 mt-1 mb-3 form-control" id="inlineFormInput" rows="5" name="small_text-${count}" placeholder="(${count})本文のみ入力してください。(任意)" autocomplete="off"></textarea>`;
    $(".textarea").append(html);
  }
  $(".add-small-question").on("click",function(){
    appendSmallQuestionFrom();
  })
  // ----------------------------------------------
})