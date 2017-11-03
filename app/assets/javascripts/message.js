$(function(){
  var message_list = $(".chat__main__body__messages");

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
                  </p>`;
    if(message.image){
      html += `<img src="${ message.image }"></li>`;
    }else{
      html += `</li>`;
    };
    message_list.append(html);
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
      $(".chat__main__body").animate({scrollTop: message_list.height()}, "fast");
    })
    .fail(function(){
      alert('error');
    });
  });

});
