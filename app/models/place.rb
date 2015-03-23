class Place < ActiveRecord::Base
	belongs_to :place_type
	has_many :tasks

	def self.label(field = nil)
		return 'Lugar' if field.nil?
		return case field
		when :code
			'Código'
		when :compl
			'Complemento'
		when :vacant
			'Vazio?'
		else
			field.to_s.capitalize
		end
	end
end
