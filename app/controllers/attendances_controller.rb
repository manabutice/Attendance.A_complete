class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_user, only: [:index,:destroy,:edit_basic_info]
  before_action :set_one_month, only: [:edit_one_month]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"


  def edit_overtime_request
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # ユーザーテーブルから、superiorがtrueになっているものを@superiorに代入
    @superior = User.where(superior: true)
  end

  
  def update_overtime_request
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.update_attributes(overtime_params)
      flash[:success] = "残業申請を受け付けました"
      redirect_to user_url(@user)
    end  
  end


  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end

  def edit_one_month
  end 

  def update_one_month
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end


  
  
  


private
    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end


    # 残業申請モーダルの情報
    def overtime_params
      # attendanceテーブルの（残業終了予定時間,翌日、残業内容、指示者確認（どの上長か）、指示者確認（申請かどうか））
      params.require(:attendance).permit(:overtime_finished_at, :tomorrow, :overtime_work,:indicater_check,:indicater_check_superior)
    end

  end   
