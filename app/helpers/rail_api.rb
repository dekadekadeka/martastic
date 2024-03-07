module RailApi
  def rail_data
    # backup data for when real MARTA API goes down
    # backup = File.read('./backup-api.json')
    # JSON.parse(backup)
    HTTParty.get("http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals")
  end
end
