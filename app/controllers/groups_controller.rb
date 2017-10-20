class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      #グループの作成に成功したとき
      redirect_to :root, notice: "グループを作成しました"
    else
      #グループの作成に失敗したとき
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
