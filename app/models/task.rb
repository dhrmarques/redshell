class Task < RedShellModel

  require 'json'

	belongs_to :employee
	belongs_to :place
  belongs_to :task_type
  has_many :tools
  
#  validate :start_task_time_and_after_validation
  validate :after_vs_before_validation, :on => :create
  validate :negative_time_validation, :on => :create
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
      errors[:base] << "Não é possível especificar que a tarefa seja feita no passado!"
    end
  end

  def checkin_start_validation
    if checkin_start != nil && checkin_finish != nil
      if checkin_finish < checkin_start
        errors[:base] << "Não é possível criar tarefas com data de check-in antes de data de check-out!"
      end
    end
  end

  def self.advices
    [:not_yet, :no_need_to, :do_it, :urgent, :already_late, :past]
  end

  def urgency_params    
    check = checkin_start.nil? ? 
        "CHECK IN" :
        (checkin_finish.nil? ? "CHECK OUT" : "Encerrada")
    adv = calc_advice
    {
      start_advice: adv,
      checkinout: check,
      spotlight: spotlight?(adv)
    }
  end

  def spotlight? adv
    self.class.advices[1..4].include? adv
  end

  def calc_advice
    t = Time.now.beginning_of_minute
    # t = Time.parse('2015-04-09 15:03:04').beginning_of_minute # simulate time

    i = if checkin_start.nil?
      diff = t - after
      if diff < 0
        (diff.abs > 24.hours) ? 0 : 1
      elsif t < before
        lateness = diff / (before - after)
        (lateness < 0.5) ? 2 : 3
      else
        4
      end
      
    elsif checkin_finish.nil?
      diff = t - before
      if diff > 0
        4
      else
        chill = diff.abs / (before - after)
        (chill < 0.5) ? 3 : ((chill < 1.0) ? 2 : 1)
      end
    else
      5
    end
    self.class.advices[i]
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

  def products
    return nil if json.nil?
    JSON.parse(json, symbolize_names: true)
  end

end
