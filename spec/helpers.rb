require "#{Rails.root}/app/helpers/tasks_helper.rb"
include TasksHelper

module Helpers
  @@week_days = {
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
  }

  #go to next 
  def next_week_day(date, day)
    while (TasksHelper.week_day(date) != @@week_days[day] || not(@@week_days.include? day)) do
      date += 1.day
    end

    date
  end

  def tohash_and_filter(task_type_array)
    task_type_array.map do |task_type|
      task_type.as_json.select do |key, value|
        TasksHelper.considered_fields.include? key
      end
    end
  end

  def filter(task_type_array)
    task_type_array.map do |task_type|
      task_type.select(TasksHelper.considered_fields)
    end
  end

  def tohash(task_type_array)
    task_type_array.map do |task_type|
      task_type.as_json
    end
  end

end