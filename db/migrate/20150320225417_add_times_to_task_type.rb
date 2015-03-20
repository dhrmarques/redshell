class AddTimesToTaskType < ActiveRecord::Migration
  def change
  	change_table :task_types do |t|
  		t.time :before
  		t.time :after
  	end
  end
end
