module RailApi
  def rail_data
    # backup data for when real MARTA API goes down
    # backup = File.read('./backup-api.json')
    # JSON.parse(backup)
    HTTParty.get("https://developerservices.itsmarta.com:18096/itsmarta/railrealtimearrivals/traindata?apiKey=#{Rails.application.credentials.rail_api_key}")
  end
end
