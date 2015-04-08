class Task < RedShellModel

	belongs_to :employee
	belongs_to :place
  belongs_to :task_type
  has_many :tools
  
#  validate :start_task_time_and_after_validation
  validate :after_vs_before_validation
  validate :negative_time_validation
#  validate :checkin_start_validation
  validates :task_type_id, presence: true
  validates :place_id, presence: true

  def start_task_time_and_after_validation
    if checkin_start != nil && after != nil
      if checkin_start < after
        errors[:base] << "Não é possível criar tarefas com data de check-in antes de data de início!"
      end
    end
  end

  def after_vs_before_validation
    if after != nil && before != nil
      if before < after
        errors[:base] << "Não é possível criar tarefas com data de término antes de data de início!"
      end
    end
  end

  def negative_time_validation
    if after < DateTime.now || before < DateTime.now
      errors[:base] << "Não é possível indicar que a tarefa seja feita no passado!"
    end
  end

  def checkin_start_validation
    if checkin_start != nil && checkin_finish != nil
      if checkin_finish < checkin_start
        errors[:base] << "Não é possível criar tarefas com data de check-in antes de data de check-out!"
      end
    end
  end

  def self.label(field = nil)
    case field
    when nil
      'Tarefa'
    when :after
      'Após'
    when :before
      'Antes de'
    when :checkin_start
      'Iniciada em'
    when :checkin_finish
      'Finalizada em'
    when :tools
      'Ferramentas'
    when :employee_id
      'Funcionário'
    when :details
      'Detalhes'
    when :json
      'JSON (Recursos)'
    else
      superclass.label field
    end
  end

  def self.icon
    'clock-o'
  end

  def tool_list
    tools = self.tools.map {|t| t.title}
    tools.join(", ")
  end

end
