class AddActiveFieldToModels < ActiveRecord::Migration
  def change
  	add_column :employees, 			:active, :boolean, default: true
  	add_column :employee_types, 	:active, :boolean, default: true
  	add_column :places, 			:active, :boolean, default: true
  	add_column :place_types, 		:active, :boolean, default: true
  	add_column :responsibilities, 	:active, :boolean, default: true
  	add_column :tasks, 				:active, :boolean, default: true
  	add_column :task_domains, 		:active, :boolean, default: true
  	add_column :task_types, 		:active, :boolean, default: true
  	add_column :tools, 				:active, :boolean, default: true
  end
end
