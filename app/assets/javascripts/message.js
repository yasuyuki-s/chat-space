$(function(){
  var message_list = $(".chat__main__body__messages");

  function ScrollToBottom(){
    $(".chat__main__body").animate({scrollTop: message_list.height()}, "fast");
  };

  function appendMessage(message){
    var html = `<li class="chat__main__body__messages__message">
                  <p class="chat__main__body__messages__message__name">
                  ${ message.name }
                  </p>
                  <p class="chat__main__body__messages__message__time">
                  ${ message.created_at }
                  </p>
                  <p class="chat__main__body__messages__message__body">
                  ${ message.body }
                  </p>
                </li>`;
    var htmlWithImage = `<li class="chat__main__body__messages__message">
                          <p class="chat__main__body__messages__message__name">
                          ${ message.name }
                          </p>
                          <p class="chat__main__body__messages__message__time">
                          ${ message.created_at }
                          </p>
                          <p class="chat__main__body__messages__message__body">
                          ${ message.body }
                          </p>
                          <img src="${ message.image }">
                          </li>`;
    if(message.image){
      message_list.append(htmlWithImage);
    }else{
      message_list.append(html);
    };
  };

  $("#new_message").on("submit", function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action");
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(data){
      appendMessage(data);
      $("#message_body").val("");
      $("#message_image").val("");
      $("#submit").attr('disabled' , false);
      ScrollToBottom();
    })
    .fail(function(){
      alert('error');
    });
  });

});
