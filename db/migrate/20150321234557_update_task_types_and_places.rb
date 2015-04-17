class UpdateTaskTypesAndPlaces < ActiveRecord::Migration
  def change
  	change_table :task_types do |t|
  		t.boolean :ignore_if_vacant
  		t.index :week_days
  		t.index :each_n_weeks
  	end

  	change_table :places do |t|
  		t.boolean :vacant
  		t.index :vacant
  		t.index :code
  	end
  end
end
