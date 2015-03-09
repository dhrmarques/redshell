class CreateChambermaids < ActiveRecord::Migration
  def change
    create_table :chambermaids do |t|
      t.string :login
      t.string :passcode
      t.string :name
      t.string :surname

      t.timestamps
    end
  end
end
