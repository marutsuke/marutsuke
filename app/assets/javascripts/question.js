$(function(){
  //解答追加用
  $(".add-answer").on('click', function(){
    let small_question_id = $(this).data('small_question_id');
    let answer = $(this).prev().children().val();
    $(this).prev().children().val('')


    let href = `/small_questions/${small_question_id}/answers`
    if (answer!==""){
      $.ajax({
        url: href,
        type: "POST",
        data: {small_question_id: small_question_id,answer:answer},
        dataType: 'json'
      })
      .done(function(data){
        html =`<span>・${data.answer}</span>`
        $(`.answers-${data.small_question_id}`).append(html);
        })
      .fail(function(){
        alert('エラーです');
      })
    }
  })

  //大問削除用
  $(".delete-q-btn").on('click', function(e){
    e.preventDefault();
    let question_id = $(this).data('question_id');

    function disp(){
      // 「OK」時の処理開始 ＋ 確認ダイアログの表示
      if(window.confirm('！警告！\n大問1つ丸々削除します。本当にいいですか。')){
        $.ajax({
          url: `/questions/${question_id}`,
          type: "DELETE",
          data: {question_id: question_id,},
          dataType: 'json'
        })
        .done(function(data){
        $(`.question-${data.id}`).remove()
        })
        .fail(function(){
          alert('エラーです');
        })
        .always(() => {
        })
      }
      else{
      }
    }
    disp()
  })

  //小問削除ボタン用
  $(".delete-sq-btn").on('click', function(e){
    e.preventDefault();
    let small_question_id = $(this).data('small_question_id');

    function disp(){
      // 「OK」時の処理開始 ＋ 確認ダイアログの表示
      if(window.confirm('！警告！\nこの小問を削除します。本当にいいですか。')){
        href = `/small_questions/${small_question_id}`
        $.ajax({
          url: href,
          type: "DELETE",
          data: {small_question_id: small_question_id,},
          dataType: 'json'
        })
        .done(function(data){
        $(`.small-question-${data.id}`).remove()
        })
        .fail(function(){
          alert('エラーです');
        })
        .always(() => {
        })
      }
      else{
       // window.alert('キャンセルされました'); // 警告ダイアログを表示
      }
    }
    disp()
  })

  //--この下は、問題の丸つけ用----------
  // function judge(data_count,html_count,id){
  //   $(`.judged-${id}`).remove()
  //   if(data_count !== html_count){
  //     $(`.judge-${id}`).append(`<li class="judged-${id} animated bounceInDown faster jq-blue col-3">正解！</li>`)
  //     $(`.btn-${id}`).prop("disabled", true);
  //   }
  //   else{
  //     $(`.judge-${id}`).append(`<li class="judged-${id} animated bounceInDown faster jq-red col-3">もう一度チャレンジ！</li>`)
  //   }
  // }

  function judge(user_answer,answers,id){
    $(`.judged-${id}`).remove()
    if(answers.includes(user_answer)){
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
    let small_question_id = $(this).data('small_question_id')
    // let question_id = $(this).next().data('question_id');
    let correct_count = $(this).next().next().data('correct_count');
    href = "/marutsuke"
    $.ajax({
      url: href,
      type: "POST",
      data: {smallquestionid: small_question_id, answer: answer},
      dataType: 'json'
    })
    .done(function(data){
      judge(data.user_answer,data.answers,data.id)
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
