class EmployeeType < ActiveRecord::Base
	has_many :employees
	has_many :task_domains, through: :responsiblities

	def self.label(field = nil)
		return 'Tipo de Funcionário' if field.nil?
		return case field
		when :title
			'Título'
		when :description
			'Descrição'
		else
			field.to_s.capitalize
		end
	end

end
