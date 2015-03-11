class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.float :qty
      t.string :measure_unit
      t.boolean :as_int
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
