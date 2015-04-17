json.array!(@task_domains) do |task_domain|
  json.extract! task_domain, :id, :title, :description
  json.url task_domain_url(task_domain, format: :json)
end
