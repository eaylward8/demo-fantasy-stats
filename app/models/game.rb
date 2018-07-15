# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :season
  has_many :scores
  has_many :teams, through: :scores

  validates :week, inclusion: { in: [*1..16] }

  scope :reg_season, -> { where(game_type: nil) }
  scope :playoffs, -> { where.not(game_type: nil) }

  def self.with_highest_scores(amount = 25)
    Game.includes(:season, scores: { team: :owner }).order('scores.points desc').limit(amount)
  end

  def self.with_lowest_scores(amount = 25)
    Game.includes(:season, scores: { team: :owner }).order('scores.points').limit(amount)
  end

  def winning_team
    scores.order(points: :desc).first.team
  end

  def losing_team
    scores.order(:points).first.team
  end

  def point_differential
    (scores.first.points - scores.second.points).abs.round(2)
  end
end
