class UsersController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    if current_user.update(user_params)
      #updateに成功したとき
      redirect_to :root
    else
      #updateに失敗したとき
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
