class Task < ActiveRecord::Base
  
  validate :start_task_time_and_after_validation
  validate :after_validation
  validate :checkin_start_validation

  def start_task_time_and_after_validation
    if checkin_start != nil && after != nil
      if checkin_start < after
        errors[:base] << "Can't create task with checkin_start date before starting date!"
      end
    end
  end

  def after_validation
    if after != nil && before != nil
      if before < after
        errors[:base] << "Can't create task with ending date before starting date!"
      end
    end
  end

  def checkin_start_validation
    if checkin_start != nil && checkin_finish != nil
      if checkin_finish < checkin_start
        errors[:base] << "Can't create task with checkin_start date before checkin_finish date!"
      end
    end
  end

end
