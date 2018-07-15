# frozen_string_literal: true

class Season < ApplicationRecord
  has_many :teams
  has_many :games
  has_many :scores, through: :games

  validates :year, presence: true, numericality: true
end
