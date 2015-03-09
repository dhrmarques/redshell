class CheckinController < ApplicationController

	# GET /
	def list
		@chambermaid = Chambermaid.find(2)
		@list = @chambermaid.tasks.where(checkin: nil)
	end
end
