class AlterTools < ActiveRecord::Migration
  def change
  	change_table :tools do |t|
  		t.remove :qty, :measure_unit, :as_int
  	end
  end
end
