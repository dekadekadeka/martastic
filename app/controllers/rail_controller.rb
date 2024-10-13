class RailController < ApplicationController
  include RailApi

  def index
    @rail_data = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    respond_to do |format|
      if @rail_data.any?
        format.html
      else
        format.html { render :after_hours }
      end
    end
  end

  def filter
    # all rail data
    scope = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    # filter by station
    scope = scope.select {|data| data["STATION"] == params[:station].upcase } if params[:station].present?
    # if a station is present, get only its destinations and lines
    # if no station, then get all available destinations and lines 
    @destinations = scope.pluck("DESTINATION").uniq.sort
    @lines = scope.pluck("LINE").map(&:capitalize).uniq.sort
    # filter by destination
    scope = scope.select {|data| data["DESTINATION"] == params[:destination] } if params[:destination].present?
    # filter by line
    scope = scope.select {|data| data["LINE"] == params[:line].upcase } if params[:line].present?
    # final filtered rail data
    @rail_data = scope

    respond_to do |format|
      if @rail_data.any?
        format.html do
          render partial: "schedule_card", collection: @rail_data, as: :schedule_card
        end

        format.json do
          render json: { destinations: @destinations, lines: @lines }
        end
      else
        format.json { render json: { error: "Sorry, no trains matched your filters!" }}
      end
    end
  end
end
