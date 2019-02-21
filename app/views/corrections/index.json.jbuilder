json.array!(@corrections) do |correction|
  json.extract! correction, :id, :avant, :demande, :description
  json.url correction_url(correction, format: :json)
end
