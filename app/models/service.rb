class Service < RedShellModel
  belongs_to :task_type
  belongs_to :place

  validates :task_type, presence: true
  validates :place, presence: true

  def self.label(field = nil)
    case field
    when nil
      'Serviços'
    else
      superclass.label field
    end
  end
end
