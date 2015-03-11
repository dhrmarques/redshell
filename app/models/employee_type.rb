class EmployeeType < ActiveRecord::Base
	has_many :employees
	has_many :task_domains, through: :responsiblities
end
