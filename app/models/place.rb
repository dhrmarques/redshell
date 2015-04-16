class Place < RedShellModel
	belongs_to :place_type
	has_many :tasks

  validates :code, presence: true
  validates_presence_of :place_type

	def self.label(field = nil)
		case field
		when nil
			'Lugar'
		when :code
			'Código'
		when :compl
			'Complemento'
		when :vacant
			'Vazio?'
		else
			superclass.label field
		end
	end

	def self.icon
		'bed'
	end
end
