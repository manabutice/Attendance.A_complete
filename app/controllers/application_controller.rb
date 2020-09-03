class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}

  def set_one_month 
    @first_day = Date.current.beginning_of_month
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] 
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day)

    unless one_month.count == @attendances.count 
      ActiveRecord::Base.transaction do 
        one_month.each { |day| @user.attendances.create!(worked_on: day) }
      end
    end

  rescue ActiveRecord::RecordInvalid 
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
end
