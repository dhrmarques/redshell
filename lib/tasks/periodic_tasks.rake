require "#{Rails.root}/app/helpers/tasks_helper"
include TasksHelper

namespace :periodic_tasks do
  require "active_support"
	desc "Create periodic tasks in the db"
  task init: :environment do
    # Delete any previously-scheduled recurring jobs
    Delayed::Job.where('(handler LIKE ?)', '--- !ruby/object:Recurring::%').destroy_all

    # Recurring::DailyTasks.schedule!
    Recurring::MondayTasks.schedule(run_every: 1.week, run_at: 'monday 0:00am')
    Recurring::TuesdayTasks.schedule(run_every: 1.week, run_at: 'tuesday 0:00am')
    Recurring::WednesdayTasks.schedule(run_every: 1.week, run_at: 'wednesday 0:00am')
    Recurring::ThursdayTasks.schedule(run_every: 1.week, run_at: 'thursday 0:00am')
    Recurring::FridayTasks.schedule(run_every: 1.week, run_at: 'friday 0:00am')
    Recurring::SaturdayTasks.schedule(run_every: 1.week, run_at: 'saturday 0:00am')
    Recurring::SundayTasks.schedule(run_every: 1.week, run_at: 'sunday 0:00am')
  end
end

module Recurring

  class MondayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(1)
    end
  end

  class TuesdayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(2)
    end
  end

  class WednesdayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(3)
    end
  end

  class ThursdayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(4)
    end
  end

  class FridayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(5)
    end
  end

  class SaturdayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(6)
    end
  end

  class SundayTasks
    include Delayed::RecurringJob
    def perform
      create_tasks(0)
    end
  end

end