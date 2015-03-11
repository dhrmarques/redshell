class Task < ActiveRecord::Base
	has_one :employee
	has_one :place
end
