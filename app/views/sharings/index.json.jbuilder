json.array!(@sharings) do |sharing|
  json.extract! sharing, :id, :email, :tale_id
  json.url sharing_url(sharing, format: :json)
end
