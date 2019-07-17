class UsersController < ApplicationController
  before_action :find_user, only: %i(show)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "controllers.users.register.create.info"
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit :name, :email, :username,
      :password, :password_confirmation,
      :address, :phone_number
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "controllers.users.register.find_user"
    redirect_to root_path
  end
end
