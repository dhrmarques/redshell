json.array!(@place_types) do |place_type|
  json.extract! place_type, :id, :title, :description, :restricted, :common
  json.url place_type_url(place_type, format: :json)
end
