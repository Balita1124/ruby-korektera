json.array!(@historiques) do |historique|
  json.extract! historique, :id, :action
  json.url historique_url(historique, format: :json)
end
