class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: paramas[:session][:email].dowacace)
    if user && user.authenticate(paramas[:session][:password])
      ridirect_to @user
    else  
      render :new
    end
  end
end
