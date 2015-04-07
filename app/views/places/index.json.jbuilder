json.array!(@places) do |place|
  json.extract! place, :id, :code, :compl
  json.url place_url(place, format: :json)
end
