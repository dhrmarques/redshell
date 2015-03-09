class Task < ActiveRecord::Base
	belongs_to :chambermaid
	belongs_to :room
end
