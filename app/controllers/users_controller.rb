class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :edit_basic_info]
  before_action :logged_in_user, only: [:show, :edit, :update, :edit_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_one_month, only: :show
  before_action :admin_user, only: [:destroy, :edit_basic_info]

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def index
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
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit 
    end 
  end  

  def edit_basic_info
  end 

  


  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :basic_work_time, :designation_work_start_time, :designation_work_end_time)
    end

  end
