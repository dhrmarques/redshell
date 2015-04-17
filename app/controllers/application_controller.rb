class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :verify_permissions

  private

  def verify_permissions
  	if not current_employee
	  	authenticate_employee!
	  end

  	if current_employee and not current_employee.is_admin? and not view_context.current_controller? ["tasks"]
  		redirect_to(todo_tasks_path)
  	end
  end
end
