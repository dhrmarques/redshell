class Place < ActiveRecord::Base
	belongs_to :place_type
	has_many :tasks
end
