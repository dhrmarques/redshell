class ChangeEmployeeColumnsToNotNull < ActiveRecord::Migration
  def change
    change_column_null(:employees, :employee_type_id, false)
  end
end
