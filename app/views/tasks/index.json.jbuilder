json.array!(@tasks) do |task|
  json.extract! task, :id, :description, :checkin, :due
  json.url task_url(task, format: :json)
end
