class RailController < ApplicationController
  include RailApi

  def index
    @rail_data = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    # different categories to populate filter dropdowns
    @destinations = rail_data.pluck("DESTINATION").uniq.sort
    @lines = rail_data.pluck("LINE").map(&:capitalize).uniq.sort
    @arriving_at_stations = rail_data.pluck("STATION").map(&:titleize).uniq.sort
    
    # min and max waiting seconds
    @waiting_seconds = rail_data.pluck("WAITING_SECONDS").map(&:to_i).minmax
  end

  def filter
    @rail_data = rail_data.select {|s| s["STATION"] == params[:station].upcase }

    respond_to do |format|
      format.json { render json: render_to_string(partial: 'schedule_card', collection: @rail_data, formats: [:html])}
    end
  end
end
