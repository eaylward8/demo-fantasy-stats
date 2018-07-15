# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :owner
  belongs_to :season
  has_many :scores
  has_many :games, through: :scores

  validates_presence_of :name
  validates :made_playoffs, inclusion: { in: [true, false] }
  validates_numericality_of :final_rank,
                            :wins,
                            :losses,
                            :ties,
                            :moves,
                            only_integer: true,
                            greater_than_or_equal_to: 0
  validate :sum_of_wlt

  def sum_of_wlt
    if (wins + losses + ties) > 16
      errors.add(:base, 'Sum of wins, losses, and ties cannot exceed 16')
    end
  end

  def points_reg_season
    games.where(week: [*1..13]).sum(:points)
  end

  def points_playoffs
    games.where(week: [*14..16]).sum(:points)
  end

  def total_points
    games.sum(:points)
  end

  def points_against_reg_season
    Score.joins(:game).where(games: { id: games.ids, week: [*1..13] })
                      .where.not(team_id: id)
                      .sum(:points)
  end
end
