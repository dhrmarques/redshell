class Chambermaid < ActiveRecord::Base
	has_many :tasks

	def desc
		"%s %s" % [self.name, self.surname]
	end
end
