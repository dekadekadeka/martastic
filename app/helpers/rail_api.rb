module RailApi
  def rail_data
    HTTParty.get("http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals")
  end
end
