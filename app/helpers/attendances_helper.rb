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
end
