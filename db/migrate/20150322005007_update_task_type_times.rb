class UpdateTaskTypeTimes < ActiveRecord::Migration
  def change
  	change_table :task_types do |t|
  		t.remove :after
  		t.remove :before
  		t.integer :after_in_minutes
  		t.integer :before_in_minutes
  	end
  end
end
