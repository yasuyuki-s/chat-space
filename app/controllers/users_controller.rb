class UsersController < ApplicationController

  def index
    @users = User.where("name LIKE(?)","%#{params[:keyword]}%")

    respond_to do |format|
      format.json
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    if current_user.update(user_params)
      #updateに成功したとき
      redirect_to :root, notice: "ユーザー情報を更新しました"
    else
      #updateに失敗したとき
      flash.now[:alert] = "更新処理にエラーが発生しました"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
