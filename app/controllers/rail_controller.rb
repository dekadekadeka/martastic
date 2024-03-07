class RailController < ApplicationController
  include RailApi

  def index
    @rail_data = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    # different categories to populate filter dropdowns
    @arriving_at_stations = rail_data.pluck("STATION").map(&:titleize).uniq.sort
    @destinations = rail_data.pluck("DESTINATION").uniq.sort
    @lines = rail_data.pluck("LINE").map(&:capitalize).uniq.sort
    
    # min and max waiting seconds
    # TODO: change this to direction
    @waiting_seconds = rail_data.pluck("WAITING_SECONDS").map(&:to_i).minmax
  end

  def filter
    # TODO
    # Put dropdown container in a partial to generate dropdowns with only available options
    # Add search by direction of travel
    scope = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    scope = scope.select {|data| data["STATION"] == params[:station].upcase } if params[:station].present?
    scope = scope.select {|data| data["DESTINATION"] == params[:destination] } if params[:destination].present?
    scope = scope.select {|data| data["LINE"] == params[:line].upcase } if params[:line].present?

    @rail_data = scope

    respond_to do |format|
      format.html { render partial: 'schedule_card', collection: @rail_data }
    end
  end
end
