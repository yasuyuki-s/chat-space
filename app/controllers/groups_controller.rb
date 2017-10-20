class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    if group.valid?
      #バリデーションを通過した場合
      group.save
      redirect_to :root, notice: "グループを作成しました"
    else
      #バリデーションエラー発生時
      @group = group
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
