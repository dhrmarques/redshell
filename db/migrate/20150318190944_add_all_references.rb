class AddAllReferences < ActiveRecord::Migration
  def change
  	add_reference :tasks, :place, index: true
  	add_reference :tasks, :employee, index: true
  	add_reference :tasks, :task_type, index: true

  	add_reference :employees, :employee_type, index: true

  	add_reference :places, :place_type, index: true
  	
  	add_reference :task_types, :task_domain, index: true
  	
  	add_reference :tools, :task, index: true

  	add_reference :responsibilities, :responsibility, index: true
  	add_reference :responsibilities, :task_domain, index: true
  end
end
