class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :update_index, :edit_basic_info, :destroy]
  before_action :logged_in_user, only: [:show, :update, :update_index, :destroy, :edit_basic_info]
  before_action :correct_user, only: [ :edit,:update]
  before_action :set_one_month, only: :show
  before_action :admin_user, only: [:destroy, :edit_basic_info]

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @attendances = Attendance.all
    respond_to do |format|
      format.html
      format.csv { send_data Attendance.to_csv, type: 'text/csv; charset=shift_jis', filename: "attendances.csv" }
    end
  end

  def index
      @users = User.all
      respond_to do |format|
      format.html do
      end
      format.csv do
        send_data render_to_string,filename:"original_filename.csv",type: :csv
      end
    end
  end 

  def import
    if params[:file].blank?
      flash[:danger]= "csvファイルを選択してください"
      redirect_to users_url
    elsif 
      File.extname(params[:file].original_filename) != ".csv"
      flash[:danger]= "csvファイル以外は出力できません"
      redirect_to users_url
    else
      User.import(params[:file]) 
      flash[:success]= "インポートが完了しました"
      redirect_to users_url
    end

  rescue ActiveRecord::RecordInvalid
    flash[:danger]= "不正なファイルのため、インポートに失敗しました"
    redirect_to users_url
  rescue ActiveRecord::RecordNotUnique
    flash[:danger]= "既にインポート済です"
    redirect_to users_url
  end
  



  def update_index
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      flash[:danger] = "更新に失敗しました。"
      redirect_to users_url
    end 
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

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end 

  def working 
    # ユーザーモデルから全てのユーザーに紐づいた勤怠たちを代入
    @users = User.all.includes(:attendances)
end 


  


  private

    def user_params
      params.require(:user).permit(:name, :email, :department,:staff_id,:card_id, :password, 
        :password_confirmation, :basic_work_time, :designation_work_start_time, :designation_work_end_time)
    end

  end
