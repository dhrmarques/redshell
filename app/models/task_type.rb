class TaskType < ActiveRecord::Base
	belongs_to :task_domain
	has_many :tasks

	def self.label(field = nil)
		return 'Tipo de Tarefa' if field.nil?
		return case field
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
			field.to_s.capitalize
		end
	end
end
