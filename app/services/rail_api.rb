class RailApi
  include HTTParty

  def initialize(api_key)
    @options = { query: { apikey: api_key } }
  end

  def rail_data
    self.class.get("http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals", @options)
  end
end
