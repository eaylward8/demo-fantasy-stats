# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  let!(:season) { create :season }

  describe 'validations' do
    it 'has a valid factory' do
      expect(build(:game, season: season)).to be_valid
    end

    it 'is invalid if week is not in 1 through 16' do
      expect(build(:game, season: season, week: 0)).to_not be_valid
    end

    it 'is valid if week is in 1 through 16' do
      expect(build(:game, season: season, week: 13)).to be_valid
    end
  end
end
