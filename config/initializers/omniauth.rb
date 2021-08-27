Rails.application.config.middleware.use OmniAuth::Builder do
  provider :microsoft_office365, ENV['OFFICE365_KEY'], ENV['OFFICE365_SECRET']
end
