class CreatePlaceTypes < ActiveRecord::Migration
  def change
    create_table :place_types do |t|
      t.string :title
      t.string :description
      t.boolean :restricted
      t.boolean :common

      t.timestamps
    end
  end
end
