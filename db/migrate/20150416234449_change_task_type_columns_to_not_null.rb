class ChangeTaskTypeColumnsToNotNull < ActiveRecord::Migration
  def change
    change_column_null(:task_types, :task_domain_id, false)
  end
end
