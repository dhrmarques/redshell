class CreateTaskDomains < ActiveRecord::Migration
  def change
    create_table :task_domains do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
