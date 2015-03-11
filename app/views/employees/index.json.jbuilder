json.array!(@employees) do |employee|
  json.extract! employee, :id, :name, :last_name, :cpf, :rg, :birth
  json.url employee_url(employee, format: :json)
end
