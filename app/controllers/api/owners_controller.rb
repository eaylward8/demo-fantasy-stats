# frozen_string_literal: true

module Api
  class OwnersController < ApplicationController
    def show
      owner = Owner.find(params[:id])
      render json: OwnerSummary.new(owner).data
    end
  end
end
