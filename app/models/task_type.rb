class TaskType < ActiveRecord::Base
	belongs_to :task_domain
	has_many :tasks
end
