# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  let!(:team) { build :team }
  let!(:game) { build :game }

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:score, team: team, game: game)).to be_valid
    end
  end

  describe 'validations' do
    it 'is invalid with non-numeric points' do
      expect(build(:score, team: team, game: game, points: 'forty')).to_not be_valid
    end

    it 'is invalid with negative points' do
      expect(build(:score, team: team, game: game, points: -1)).to_not be_valid
    end
  end
end
