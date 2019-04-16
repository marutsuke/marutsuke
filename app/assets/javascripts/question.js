$(function(){
  //この下はSection表示用-----------------------------------
  function appendSmallQuestionFrom(){
    let count = $(".count").length + 1;
    let html = `<textarea type="textarea" class="count col-10 offset-1 mt-1 mb-3 form-control" id="inlineFormInput" rows="5" name="small_text-${count}" placeholder="(${count})本文のみ入力してください。(入力任意)"></textarea>`;
    $(".textarea").append(html);
  }
  $(".add-small-question").on("click",function(){
    appendSmallQuestionFrom();
    console.log("yatta");
  })
})