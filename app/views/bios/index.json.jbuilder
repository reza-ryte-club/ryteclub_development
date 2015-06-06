json.array!(@bios) do |bio|
  json.extract! bio, :id, :title, :user_id
  json.url bio_url(bio, format: :json)
end
