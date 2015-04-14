class AddTaskTypeRefToServices < ActiveRecord::Migration
  def change
    add_reference :services, :task_type, index: true
  end
end
