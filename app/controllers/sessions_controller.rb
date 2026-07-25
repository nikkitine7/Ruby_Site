class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email] || params.dig(:session, :email)
    password = params[:password] || params.dig(:session, :password)

    user = User.find_by(email: email.to_s.downcase.strip)
    if user&.authenticate(password)
      reset_session
      session[:user_id] = user.id
      if user.role == "admin"
        redirect_to admin_dashboard_path, notice: "Signed in as admin."
      else
        redirect_to root_path, notice: "Signed in successfully."
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Signed out successfully."
  end
end
