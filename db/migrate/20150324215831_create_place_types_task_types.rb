class CreatePlaceTypesTaskTypes < ActiveRecord::Migration
  def change
    create_table :place_types_task_types, id: false do |t|
      t.references :place_type
      t.references :task_type
    end

    add_index :place_types_task_types, [:place_type_id, :task_type_id]
    add_index :place_types_task_types, :task_type_id
    add_index :place_types_task_types, :place_type_id

    remove_column :responsibilities, :active, :boolean
  end
end
