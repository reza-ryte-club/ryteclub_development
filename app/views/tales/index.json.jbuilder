json.array!(@tales) do |tale|
  json.extract! tale, :id, :title, :subheading
  json.url tale_url(tale, format: :json)
end
