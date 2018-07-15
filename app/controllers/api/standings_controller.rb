# frozen_string_literal: true

module Api
  class StandingsController < ApplicationController
    def index
      render json: AllTimeStandings.new.data
    end
  end
end
