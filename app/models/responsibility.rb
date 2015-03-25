class Responsibility < RedShellModel
	belongs_to :task_domain
	belongs_to :employee_type

	def self.label(field = nil)
		case field
		when nil
			'Responsabilidade'
		else
			superclass.label field
		end
	end

	def self.icon
		'briefcase'
	end
end
