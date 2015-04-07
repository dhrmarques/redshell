json.array!(@tasks) do |task|
  json.extract! task, :id, :after, :before, :checkin_start, :checkin_finish, :details
  json.url task_url(task, format: :json)
end
