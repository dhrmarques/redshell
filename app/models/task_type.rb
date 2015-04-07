class TaskType < RedShellModel
	belongs_to :task_domain
	has_many :tasks
	has_and_belongs_to_many :place_types

	def self.label(field = nil)
		case field
		when nil
			'Tipo de Tarefa'
		when :title
			'Título'
		when :description
			'Descrição'
	    when :week_days
	    	'Dias da semana'
	    when :each_n_weeks
	    	'Intervalo de semanas'
	    when :ignore_if_vacant
	    	'Ignorar se vazio?'
	    when :after_in_minutes
	    	'Após'
	    when :before_in_minutes
	    	'Antes de'
		else
			superclass.label field
		end
	end

	def self.icon
		'tasks'
	end
end
