class RailController < ApplicationController
  include RailApi

  def index
    @rail_data = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    respond_to do |format|
      format.html
      format.json { render json: @rail_data }
    end
  end

  def filter
    # TODO
    # generate dropdowns with only available options
    scope = rail_data.sort_by { |data| data["WAITING_SECONDS"].to_i }

    scope = scope.select {|data| data["STATION"] == params[:station].upcase } if params[:station].present?
    scope = scope.select {|data| data["DESTINATION"] == params[:destination] } if params[:destination].present?
    scope = scope.select {|data| data["LINE"] == params[:line].upcase } if params[:line].present?

    @rail_data = scope

    respond_to do |format|
      if @rail_data.any?
        format.html { render partial: 'schedule_card', collection: @rail_data }
      else
        format.html { render partial: 'empty' }
      end
    end
  end
end
