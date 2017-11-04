class MessagesController < ApplicationController
  before_action :set_group, only:[:index, :create]

  def index
    @message = Message.new
    @group_messages = @group.messages.order("created_at ASC")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      #メッセージの作成に成功したとき
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group) }
        format.json
      end
    else
      #メッセージの作成に失敗したとき
      redirect_to group_messages_path(@group), alert: "メッセージを入力してください。"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: params[:group_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
