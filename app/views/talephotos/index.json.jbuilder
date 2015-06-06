json.array!(@talephotos) do |talephoto|
  json.extract! talephoto, :id, :cover, :tale_id
  json.url talephoto_url(talephoto, format: :json)
end
