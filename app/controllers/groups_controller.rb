class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]

  def index

  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      #グループの作成に成功したとき
      redirect_to group_messages_path(@group), notice: "グループを作成しました"
    else
      #グループの作成に失敗したとき
      render :new
    end
  end

  def edit

  end

  def update
    if @group.update(group_params)
      #updateに成功したとき
      redirect_to group_messages_path(@group), notice: "グループを編集しました"
    else
      #updateに失敗したとき
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
