class AddPlaceRefToServices < ActiveRecord::Migration
  def change
    add_reference :services, :place, index: true
  end
end
