class Responsibility < ActiveRecord::Base
	belongs_to :task_domain
	belongs_to :employee_type

	def self.label(field = nil)
		return 'Responsabilidade' if field.nil?
		return case field
		else
			field.to_s.capitalize
		end
	end
end
