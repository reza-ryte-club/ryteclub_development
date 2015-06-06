json.array!(@follows) do |follow|
  json.extract! follow, :id, :follower_type, :follower_id, :followable_type, :followable_id
  json.url follow_url(follow, format: :json)
end
