class UsersController < ApplicationController
  def edit
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(params[:id])
    user.update(user_params) if user.id == current_user.id
    redirect_to :root
  end

  private
  def user_params
    params.require(:user).permit(:name,:email)
  end
end
