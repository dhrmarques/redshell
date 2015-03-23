class TaskDomain < ActiveRecord::Base
	has_many :task_types
	has_many :employee_types, through: :responsiblities

	def self.label(field = nil)
		return 'Domínio de Tarefa' if field.nil?
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
