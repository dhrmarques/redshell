json.array!(@tasks) do |task|
  json.extract! task, :id, :task_type_id, :place_id, :after, :before, :employee_id, :checkin_start, :checkin_finish, :details
  json.url task_url(task, format: :json)
end
