class HomeController < ApplicationController
  
  # GET /
  def index
  	@entity_classes = [
  		[:employees, 'user'],
  		[:employee_types, 'users'],
  		[:places, 'bed'],
  		[:place_types, 'home'],
      [:responsibilities, 'briefcase'],
  		[:task_domains, 'puzzle-piece'],
  		[:task_types, 'tasks'],
  		[:tasks, 'clock-o'],
  		[:tools, 'wrench']
  	]
  end

end
