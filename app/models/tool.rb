class Tool < RedShellModel
	belongs_to :task

	def self.label(field = nil)
		case field
		when nil
			'Ferramenta'
		when :task
			'Sendo usado na tarefa'
		else
			superclass.label field
		end
	end

	def self.icon
		'wrench'
	end
end
