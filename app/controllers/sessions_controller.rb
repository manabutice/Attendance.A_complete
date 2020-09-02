class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    else  
      flash[:danger] = "認証に失敗しました。"
      render :new
    end
  end
end
