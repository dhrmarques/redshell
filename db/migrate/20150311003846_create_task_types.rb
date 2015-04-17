class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
      t.string :title
      t.string :week_days
      t.integer :each_n_weeks
      t.text :description

      t.timestamps
    end
  end
end
