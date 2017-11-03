 json.name  @message.user.name
 json.body  @message.body
 json.image  @message.image.url
 json.created_at l(@message.created_at, format: :short)
