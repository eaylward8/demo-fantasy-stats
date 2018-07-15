# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :team
  belongs_to :game

  validates :points, numericality: { greater_than_or_equal_to: 0 }

  scope :by_most_points, -> { order(points: :desc) }
  scope :by_least_points, -> { order(:points) }
  scope :reg_season, -> { joins(:game).merge(Game.reg_season) }
  scope :playoffs, -> { joins(:game).merge(Game.playoffs) }

  def self.top(amount = 25)
    by_most_points.limit(amount)
  end

  def self.bottom(amount = 25)
    by_least_points.limit(amount)
  end
end
