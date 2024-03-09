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
    scope = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    scope = scope.select {|data| data["STATION"] == params[:station].upcase } if params[:station].present?
    scope = scope.select {|data| data["DESTINATION"] == params[:destination] } if params[:destination].present?
    scope = scope.select {|data| data["LINE"] == params[:line].upcase } if params[:line].present?

    @destinations = scope.pluck("DESTINATION").uniq.sort
    @lines = scope.pluck("LINE").map(&:capitalize).uniq.sort
    @rail_data = scope

    respond_to do |format|
      if @rail_data.any?
        format.json { render json: { destinations: @destinations, lines: @lines, rail_data: @rail_data }}
      else
        format.json { render json: { error: "Sorry, no trains matched your filters!" }}
      end
    end
  end
end
