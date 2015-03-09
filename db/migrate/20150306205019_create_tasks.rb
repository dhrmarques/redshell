class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.datetime :checkin
      t.datetime :due

      t.belongs_to :chambermaid, index: true
      t.belongs_to :room, index: true

      t.timestamps
    end
  end
end
