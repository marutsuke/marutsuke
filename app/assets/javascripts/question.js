$(function(){
  $(".marutsuke").on('click', function(e){
    e.preventDefault();
    let answer = $(".input-answer").val();
    
    let small_question_id = $(this).data('small_question_id');
    let question_id = $(this).next().data('question_id');

    href = "/questions/" + question_id.toString() + "/small_questions/" + small_question_id.toString()

    console.log(href)

    $.ajax({
      url: href,
      type: "GET",
      data: {smallquestionid: small_question_id, answer: answer},
      dataType: 'json'
    })
    .done(function(sections){
      console.log("やった！")
    })
    .fail(function(){
      alert('エラーです');
    })
    .always(() => {
    })
  })

  // この下は小問を作成用-----------------------------------
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