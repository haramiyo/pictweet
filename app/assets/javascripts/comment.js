$(function(){
  function buildHTML(comment){
    let html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    // console.log(this)
    let formData = new FormData(this);  //thisの要素のデータをJavaScriptのオブジェクトにとしてFormDataを生成
    let url = $(this).attr('action')  //.attrはaction属性に対する値(フォームの送信先のurl)を取得
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){  //date = サーバから返されたデータ(=create.json.jbuilderのデータ)
      let html = buildHTML(data);
      $('.comments').append(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);  //submitボタンのdisabled属性(一度押したらボタンが押せなくなる)をpropでfalseにする
    })
    .fail(function(){
      alert('error');
    })
  })
})