$(function(){
  var search_list = $("#user-search-result");
  var member_list = $("#chat-group-users");

  function appendSearch(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">${ user.name }</p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
               </div>`;
    search_list.append(html);
  };

  function appendMember(id,name) {
    var html = `<div class='chat-group-user clearfix' id='chat-group-user-${ id }'>
                  <input name='group[user_ids][]' type='hidden' value='${ id }'>
                    <p class='chat-group-user__name'>${ name }</p>
                    <a class="chat-group-user__btn chat-group-user__btn--remove">削除</a>
                </div>`;
    member_list.append(html);
  };

  $("#user-search-field").on("keyup", function(){
    var input = $("#user-search-field").val();

    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })
    .done(function(users){
      search_list.empty();
      if(users.length !== 0){
        users.forEach(function(user){
          appendSearch(user);
        });
      };
    })
    .fail(function(){
      alert("ユーザー検索に失敗しました");
    });
  });

  $(document).on("click", ".user-search-add" ,function(){
    name = $(this).attr("data-user-name");
    id = $(this).attr("data-user-id");
    appendMember(id,name);
    $(this).closest(".chat-group-user").remove();
  });

  $(document).on("click", ".chat-group-user__btn--remove" ,function(){
    $(this).closest(".chat-group-user").remove();
  });

});
