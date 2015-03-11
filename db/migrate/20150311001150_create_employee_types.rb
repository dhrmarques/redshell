class CreateEmployeeTypes < ActiveRecord::Migration
  def change
    create_table :employee_types do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
