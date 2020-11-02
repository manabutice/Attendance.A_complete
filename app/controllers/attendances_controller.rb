class AttendancesController < ApplicationController
 
  before_action :set_user, only: [:edit_one_month, :update_one_month, :edit_overtime_notice, :edit_one_month_notice]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_user, only: [:index,:destroy,:edit_basic_info]
  before_action :set_one_month, only: [:edit_one_month]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"


  # 残業申請お知らせモーダル
  def edit_overtime_notice
    @users = User.joins(:attendances).group("users.id").where(attendances: {indicater_reply: "申請中"})
    @attendances = Attendance.where.not(overtime_finished_at: nil).order("worked_on ASC")
  end

# 残業申請お知らせモーダル更新
  def update_overtime_notice
    ActiveRecord::Base.transaction do 
      o1 = 0
      o2 = 0
      o3 = 0
      overtime_notice_params.each do |id, item|
      if item[:indicater_reply].present?
        if (item[:change] == "1") && (item[:indicater_reply] == "なし" || item[:indicater_reply] == "承認" || item[:indicater_reply] == "否認")
        attendance = Attendance.find(id)
        user = User.find(attendance.user_id)
          if item[:indicater_reply] == "なし" 
            o1+= 1
            item[:overtime_finished_at] = nil
            item[:tomorrow] = nil
            item[:overtime_work] = nil
            item[:indicater_check] = nil

          elsif item[:indicater_reply] == "承認"
                item[:indicater_check] = nil
            o2 += 1
        attendance.indicater_check_anser = "残業申請を承認しました"

          elsif item[:indicater_reply] == "否認"
                item[:indicater_check] = nil
            o3 += 1
        attendance.indicater_check_anser = "残業申請を否認しました"
          end
          attendance.update_attributes!(item)
          flash[:success] = "【残業申請】　#{o1}件なし,　#{o2}件承認,　#{o3}件否認しました"
          redirect_to user_url(params[:user_id])
          return
          else 
            flash[:danger] = "指示者確認を更新、または変更にチェックを入れて下さい"
            redirect_to user_url(params[:user_id])
            return
          end
        end
      end
    end
    rescue ActiveRecord::RecordInvalid 
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to edit_overtime_notice_user_attendance_url(@user,item)
  end
  
# 残業申請モーダル
  def edit_overtime_request
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    @superior = User.where(superior: true).where.not( id: current_user.id )
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


# 勤怠変更申請
  def edit_one_month 
    @attendance = Attendance.find(params[:id])
    @superior = User.where(superior: true).where.not( id: current_user.id )
  end 

  def update_one_month
    # カラムを更新した件数を入れる変数を定義
    ActiveRecord::Base.transaction do 
      c1 = 0
      # ストロングパラメーターのidと各カラムを配列で回す
      attendances_params.each do |id,item|
        # Attendanceテーブルから1つのidを見つける
        @attendance = Attendance.find(id)
        # 上長が選択されていること
          if item[:indicater_check_edit].present?
            # 時間が入っていない場合はエラー
            if item[:started_edit_at].blank? && item[:finished_edit_at].present?
              flash[:danger] = "出勤時刻が存在しません"
              redirect_to attendances_edit_one_month_user_url(date: params[:date])
              return
              # 出勤時間が入っていて退勤時間が空場合はエラー
            elsif item[:started_edit_at].present? && item[:finished_edit_at].blank?
              flash[:danger] = "退勤時間が存在しません"
              redirect_to attendances_edit_one_month_user_url(date: params[:date]) 
              return

              # 翌日にチェックがなく出勤時間が退勤時間より小さい場合  
            elsif item[:tomorrow] == "0" && item[:started_edit_at].to_s > item[:finished_edit_at].to_s
              flash[:danger] = "時刻に誤りがあります"
              redirect_to attendances_edit_one_month_user_url(date: params[:date])
              return

              # 備考が空の場合
            elsif item[:note].blank?
              flash[:danger] = "変更内容を記入して下さい"
              redirect_to attendances_edit_one_month_user_url(date: params[:date])
              return
            end
              
            # 翌日チェックがあれば
            if item[:tomorrow] == "1"
              # item[:worked_on]で今日の日付を取る。to_dateで今日か明日かの日付を取る。tomorrowで次の日の日付を取る。これを変数tomorrow_dayに代入
              tomorrow_day = item[:worked_on].to_date.tomorrow.to_s
              # 退勤時刻のカラム = 上記で作ったtomorrow_dayを文字列にしたもの + 空欄 + 退勤時間を文字列にし、:00を渡すことで日本時間にしてる
              item[:finished_edit_at] = tomorrow_day.to_s + " " + item[:finished_edit_at].to_s + ":00"
            else
              # 退勤時刻のカラム = 今日の日付を文字列にしたもの + 空欄 + 退勤時間を文字列にし、:00を渡すことで日本時間にしてる
              item[:finished_edit_at] = item[:worked_on].to_s + " " + item[:finished_edit_at].to_s + ":00"
            end
            # カラム更新
            c1 += 1
            @attendance.update_attributes!(item)
          end
      end
    flash[:success] = "勤怠変更を#{c1}件受け付けました"
    redirect_to user_url(@user)
    end
  rescue ActiveRecord::RecordInvalid 
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
    return
  end


  def edit_one_month_notice
    @users = User.joins(:attendances).group("users.id").where(attendances: {indicater_reply_edit: "申請中"})
    @attendances = Attendance.where.not(started_edit_at: nil, finished_edit_at: nil).order("worked_on ASC")
  end  


  def update_one_month_notice
  end  
  

  


private
    # 勤怠編集
    def attendances_params
      # userに紐ずくattendanceテーブルの（出社日,出勤,退勤,翌日,備考,指示者確認（どの上長か,指示者確認（申請かどうか））
      params.require(:user).permit(attendances: [:worked_on, :started_edit_at, :finished_edit_at, :tomorrow, :note, :indicater_check_edit, :indicater_reply_edit])[:attendances]
    end


    # 残業申請モーダルの情報
    def overtime_params
      # attendanceテーブルの（残業終了予定時間,翌日、残業内容、指示者確認（どの上長か）、指示者確認（申請かどうか））
      params.require(:attendance).permit(:overtime_finished_at, :tomorrow, :overtime_work,:indicater_check,:indicater_reply)
    end

    # 残業申請お知らせモーダルの情報
    def overtime_notice_params
      # attendanceテーブルの（指示者確認,変更、勤怠を確認する）
      params.require(:user).permit(attendances: [:overtime_work, :indicater_reply, :change, :indicater_check, :overtime_finished_at, :indicater_check_anser])[:attendances]
    end
  end   
