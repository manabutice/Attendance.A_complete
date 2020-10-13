module AttendancesHelper

  def attendance_state_start(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end

  def attendance_state_finish(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end

  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end

  
  
  
  # 時間外時間
  def overtime_worked_on(finish, end_time, tomorrow)    
    if tomorrow == true
      # finishとend_timeの時と分をそれぞれ計算し、差分を合わせるために、分側を60で割っている
      format("%.2f", (((finish.hour - end_time.hour) + ((finish.min - end_time.min) / 60.0) + 24)))
    else
      format("%.2f", (((finish.hour - end_time.hour) + ((finish.min - end_time.min) / 60.0))))
    end
  end

end
