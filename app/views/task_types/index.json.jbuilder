json.array!(@task_types) do |task_type|
  json.extract! task_type, :id, :task_domain_id, :title, :week_days, :each_n_weeks, :ignore_if_vacant, :after_in_minutes, :before_in_minutes, :description
  json.url task_type_url(task_type, format: :json)
end
