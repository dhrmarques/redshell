class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.datetime :after
      t.datetime :before

      t.timestamps
    end
  end
end
