class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :last_name
      t.string :cpf
      t.string :rg
      t.date :birth

      t.timestamps
    end
  end
end
