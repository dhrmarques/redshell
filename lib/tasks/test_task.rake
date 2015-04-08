# module Recurring
#   class DailyTest
#     include Delayed::RecurringJob
#     run_every 10.seconds
#     queue 'slow-jobs'

#     def perform
#       new_employee = Employee.create(:email => "test" + Random.rand(1000).to_s + "@test.test", :password => "yaaaaaaaaaay", :sign_in_count => 0)
#       p new_employee.errors.full_messages
#     end
#   end
# end

# namespace :test_task do
#   desc "Test task"
#   task init: :environment do
#     # Delete any previously-scheduled recurring jobs
#     Delayed::Job.where('(handler LIKE ?)', '--- !ruby/object:Recurring::%').destroy_all

#     Recurring::DailyTest.schedule!
#   end
# end