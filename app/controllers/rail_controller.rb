class RailController < ApplicationController
  def index
    api_key = Rails.application.credentials.rail_api_key

    api = RailApi.new(api_key)

    # all the rail data
    @rail_data = api.rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    # different categories to populate filter dropdowns
    @destinations = api.rail_data.pluck("DESTINATION").uniq.sort
    @lines = api.rail_data.pluck("LINE").map(&:capitalize).uniq.sort
    @arriving_at_stations = api.rail_data.pluck("STATION").map(&:titleize).uniq.sort
    
    # min and max waiting seconds
    @waiting_seconds = api.rail_data.pluck("WAITING_SECONDS").map(&:to_i).minmax
  end
end
