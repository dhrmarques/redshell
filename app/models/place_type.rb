class PlaceType < RedShellModel
	has_many :places

	def self.label(field = nil)
		case field
		when nil
			'Tipo de Lugar'
		when :restricted
			'Acesso restrito?'
		when :common
			'Área comum?'
		else
			superclass.label field
		end
	end

	def self.icon
		'home'
	end
end
