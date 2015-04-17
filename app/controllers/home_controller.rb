class HomeController < ApplicationController
  
  # GET /
  def index
  	@entity_classes = [:employees, :employee_types, :places, :place_types, :responsibilities, :task_domains, :task_types, :tasks, :tools]
  end

end
