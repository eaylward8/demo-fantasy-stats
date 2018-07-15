# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :owner_list, :season_list

  def owner_list
    @owner_list ||= Owner.select(:id, :name)
  end

  def season_list
    @season_list ||= Season.select(:id, :year).order(year: :desc)
  end
end
