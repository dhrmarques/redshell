json.array!(@tools) do |tool|
  json.extract! tool, :id, :qty, :measure_unit, :as_int, :title, :description
  json.url tool_url(tool, format: :json)
end
