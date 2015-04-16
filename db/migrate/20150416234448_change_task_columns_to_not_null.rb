class ChangeTaskColumnsToNotNull < ActiveRecord::Migration
  def change
    change_column_null(:tasks, :employee_id, false)
    change_column_null(:tasks, :task_type_id, false)
    change_column_null(:tasks, :place_id, false)
  end
end
