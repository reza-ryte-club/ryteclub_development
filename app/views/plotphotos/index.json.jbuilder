json.array!(@plotphotos) do |plotphoto|
  json.extract! plotphoto, :id, :image, :plot_id
  json.url plotphoto_url(plotphoto, format: :json)
end
