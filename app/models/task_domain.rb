class TaskDomain < ActiveRecord::Base
	has_many :task_types
	has_many :employee_types, through: :responsiblities
end
