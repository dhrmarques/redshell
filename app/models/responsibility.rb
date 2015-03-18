class Responsibility < ActiveRecord::Base
	belongs_to :task_domain
	belongs_to :employee_type
end
