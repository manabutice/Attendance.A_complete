class UsersController < ApplicationController

  def show
    @usre = User.find(params[:id])
  end

  def new
    @user = User.new
  end
end
