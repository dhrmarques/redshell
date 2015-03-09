json.array!(@chambermaids) do |chambermaid|
  json.extract! chambermaid, :id, :login, :passcode, :name, :surname
  json.url chambermaid_url(chambermaid, format: :json)
end
