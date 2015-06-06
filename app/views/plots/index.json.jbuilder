json.array!(@tales) do |tale|
  json.extract! tale, :id, :title
  json.url tale_url(tale, format: :json)
end
