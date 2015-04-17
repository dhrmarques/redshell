json.array!(@tools) do |tool|
  json.extract! tool, :id, :task_id, :title, :description
  json.url tool_url(tool, format: :json)
end
