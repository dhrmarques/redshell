class PlaceType < ActiveRecord::Base
	has_many :places

	def self.label(field = nil)
		return 'Tipo de Lugar' if field.nil?
		return case field
		when :title
			'Título'
		when :description
			'Descrição'
		when :restricted
			'Acesso restrito?'
		when :common
			'Área comum?'
		else
			field.to_s.capitalize
		end
	end
end
