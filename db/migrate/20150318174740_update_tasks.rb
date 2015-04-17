class UpdateTasks < ActiveRecord::Migration
  def change
  	change_table :tasks do |t|
      t.text :json
	end
  end
end
