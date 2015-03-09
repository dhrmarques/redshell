class Room < ActiveRecord::Base
	has_many :tasks

	def desc
		"%s-%d" % [self.building, self.num]
	end
end
