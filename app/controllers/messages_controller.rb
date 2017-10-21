class MessagesController < ApplicationController
  before_action :set_group, only:[:index, :create]

  def index
    @message = Message.new
    @group_messages = @group.messages.order("created_at ASC")
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      #メッセージの作成に成功したとき
      redirect_to group_messages_path(@group)
    else
      #メッセージの作成に失敗したとき
      render :index
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
