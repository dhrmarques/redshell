class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :after
      t.datetime :before
      t.datetime :checkin_start
      t.datetime :checkin_finish
      t.text :details

      t.timestamps
    end
  end
end
