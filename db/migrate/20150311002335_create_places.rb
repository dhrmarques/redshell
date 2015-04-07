class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :code
      t.string :compl

      t.timestamps
    end
  end
end
