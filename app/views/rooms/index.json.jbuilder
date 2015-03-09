json.array!(@rooms) do |room|
  json.extract! room, :id, :num, :building, :area, :kind, :status
  json.url room_url(room, format: :json)
end
