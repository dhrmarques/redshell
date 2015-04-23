class TaskDomain < RedShellModel
	has_many :task_types
	has_many :employee_types, through: :responsiblities

  validates :title,  presence: true

	def self.label(field = nil)
		case field
		when nil
			'Domínio de Tarefa'
		else
			superclass.label field
		end
	end

	def self.icon
		'puzzle-piece'
	end
end
