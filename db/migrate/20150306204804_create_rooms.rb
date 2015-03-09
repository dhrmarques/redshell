class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :num
      t.string :building
      t.float :area
      t.string :kind
      t.string :status

      t.timestamps
    end
  end
end
