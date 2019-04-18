$(function(){


  //--この下は、問題の丸つけ用----------
  function judge(data_count,html_count,id){
    $(`.judged-${id}`).remove()
    if(data_count !== html_count){
      $(`.judge-${id}`).append(`<li class="judged-${id} animated bounceInDown faster jq-blue col-3">正解！</li>`)
      $(`.btn-${id}`).prop("disabled", true);
    }
    else{
      $(`.judge-${id}`).append(`<li class="judged-${id} animated bounceInDown faster jq-red col-3">もう一度チャレンジ！</li>`)
    }
  }
  function commentary(count,question_id){
    if($(".jq-blue").length == count){
     $(".list-group").append(`<li><a href="/questions/${question_id}/small_questions">解答・解説をみる！</a></li>`)
    }
  }

  $(".marutsuke").on('click', function(e){
    e.preventDefault();
    let answer = $(this).prev().val();
    let small_question_id = $(this).data('small_question_id');
    let question_id = $(this).next().data('question_id');
    let correct_count = $(this).next().next().data('correct_count');

    href = "/questions/" + question_id.toString() + "/small_questions/" + small_question_id.toString()

    $.ajax({
      url: href,
      type: "GET",
      data: {smallquestionid: small_question_id, answer: answer},
      dataType: 'json'
    })
    .done(function(data){
      judge(data.correct_count,correct_count,data.id)
      console.log(data.small_question_count)
      commentary(data.small_question_count,data.question_id)
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