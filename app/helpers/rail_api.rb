module RailApi
  def rail_data
    # backup data for when real MARTA API goes down
    # backup = File.read('./backup-api.json')
    # JSON.parse(backup)
    marta_key = Base64.decode64(Rails.application.credentials.rail_api_key)
    HTTParty.get("https://developerservices.itsmarta.com:18096/itsmarta/railrealtimearrivals/traindata?apiKey=#{marta_key}")
  end
end
