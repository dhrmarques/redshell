class TaskType < RedShellModel
	belongs_to :task_domain
	has_many :tasks
	has_and_belongs_to_many :place_types

	before_validation :not_periodic_correction
	validate :n_weeks_validation
	validate :minutes_validation
  validates_presence_of :task_domain
  # validates_presence_of :place_types

  def not_periodic_correction
  	if week_days.nil? || week_days.empty?
  		each_n_weeks = nil
  		ignore_if_vacant = nil
  		after_in_minutes = nil
  		before_in_minutes = nil
  	end
  end

  def n_weeks_validation
    return if week_days.nil? || week_days.empty?
  	unless TaskType.n_possible_weeks.include? each_n_weeks
  		errors[:base] << "Intervalo de semanas inválido."
  	end
  end

  def minutes_validation
  	unless week_days.nil? || week_days.empty?
			unless 0 <= after_in_minutes && after_in_minutes < 24 * 60
				errors[:base] << "Horário inválido para o campo #{TaskType.label(:after_in_minutes)}."
			end
			unless 0 <= before_in_minutes && before_in_minutes < 24 * 60
				errors[:base] << "Horário inválido para o campo #{TaskType.label(:before_in_minutes)}."
			end
      if after_in_minutes >= before_in_minutes
        errors[:base] << "Intervalo de tempo inválido."
      end
		end
  end

  def self.n_possible_weeks
  	(1..10).to_a + (3..13).to_a.map { |i| i * 4 }
  end

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
