class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by username: params[:session][:username].downcase
    if @user&.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        remember_user
        redirect_to @user
      else
        message = t "controllers.users.sessions.create.message"
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = t "controllers.users.sessions.create.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember_user
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
  end
end
