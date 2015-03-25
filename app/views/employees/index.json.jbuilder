json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :last_name, :cpf, :email, :employee_type_id, :rg, :birth
  json.url employee_url(employee, format: :json)
end
