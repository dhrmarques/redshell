json.array!(@places) do |place|
  json.extract! place, :id, :code, :compl, :vacant, :place_type_id
  json.url place_url(place, format: :json)
end
