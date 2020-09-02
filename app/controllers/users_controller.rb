class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new 
    end  
  end 

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :edit 
    end 
  end  


  


  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :basic_work_time, :designation_work_start_time, :designation_work_end_time)
    end  
  end
