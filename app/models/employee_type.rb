class EmployeeType < RedShellModel
	has_many :employees
	has_many :task_domains, through: :responsiblities

  validates :title, :code, presence: true

	def self.label(field = nil)
		case field
		when nil
			'Tipo de Funcionário'
		else
			superclass.label field
		end
	end

	def self.icon
		'users'
	end

end
