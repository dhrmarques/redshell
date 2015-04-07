class RedShellModel < ActiveRecord::Base

	self.abstract_class = true

	def self.label(field = nil)
		return 'RedShellModel?' if field.nil?
		case field
		when :title
			'Título'
		when :description
			'Descrição'
		else
			field.to_s.capitalize
		end
	end

	def self.icon
		'cube'
	end
end



