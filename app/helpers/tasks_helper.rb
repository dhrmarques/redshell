require 'active_support/core_ext/date_time/calculations'
module TasksHelper

  def week_day(date)
    ((date.days_to_week_start) + 1) % 7
  end

  # primeiro dia que o TaskType vai/foi rodado
  def first_day(task_type, day)
    return_date = task_type.created_at
    index = 0

    while (week_day(return_date) != day && index < 7) do
      return_date += 1.day
      index += 1
    end

    return_date
  end

  def considered_fields
    ["after_in_minutes", "before_in_minutes", "description", "title", "each_n_weeks", "created_at"]
  end

  def get_tasks_to_be_created(day)
    daily_tasks = TaskType.where("week_days like '%?%'", day).select(considered_fields).select do |task_type| 
      first_runned_day = first_day(task_type, day)
      # p "******* tasks title ************"
      # p task_type.title + " " + (first_day(task_type, day)).to_s + " " + (task_type.each_n_weeks * 7).to_s + "-" + ((Time.zone.now - first_runned_day) / 1.day).to_i.to_s
      # p "********************************"
      Time.zone.now >= first_runned_day && ((((Time.zone.now - first_runned_day) / 1.day).to_i) % (task_type.each_n_weeks * 7) == 0)
    end

    daily_tasks
  end

  def create_tasks(day)
    

    # p "******* tasks count ************"
    # p daily_tasks.count
    # p "********************************"
    # daily_tasks.each do |task_type|
    #   p task_type.title
    # end
    # daily_tasks.each do |task_type|
    #   p task_type.title + " " + task_type.created_at
    # end
    daily_tasks = get_tasks_to_be_created(day)
    daily_tasks.each do |task_type|
      new_task = Task.new(:after => Time.now + task_type.after_in_minutes.minutes,:before => Time.now + task_type.before_in_minutes.minutes,:details => task_type.title + " - " + task_type.description)
      if new_task.save
        p "SUCSSES" + day.to_s
      else
        p "ERROR " + day.to_s
      end
    end
    p "Periodic tasks Job! Day: " + day.to_s
  end
end