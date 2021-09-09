Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :microsoft_office365, ENV['OFFICE365_KEY'], ENV['OFFICE365_SECRET']
  # provider :azure_oauth2,
  # {
  #   client_id: ENV['AZURE_CLIENT_ID'],
  #   client_secret: ENV['AZURE_CLIENT_SECRET']
  # }
  provider :microsoft_graph, ENV['AZURE_APPLICATION_CLIENT_ID'], ENV['AZURE_APPLICATION_CLIENT_SECRET']
end
