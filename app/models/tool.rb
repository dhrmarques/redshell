class Tool < ActiveRecord::Base
	belongs_to :task

	def self.label(field = nil)
		return 'Ferramenta' if field.nil?
		return case field
		when :title
			'Título'
		when :description
			'Descrição'
		else
			field.to_s.capitalize
		end
	end
end
