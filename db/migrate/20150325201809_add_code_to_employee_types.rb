class AddCodeToEmployeeTypes < ActiveRecord::Migration
  def change
    add_column :employee_types, :code, :string
  end
end
