class UpdateResponsibilityReferences < ActiveRecord::Migration
  def change
  	remove_column :responsibilities, :responsibility_id
  	add_reference :responsibilities, :employee_type, index: true
  end
end
