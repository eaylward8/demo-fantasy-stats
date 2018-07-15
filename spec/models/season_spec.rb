# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(create :season).to be_valid
    end
  end

  describe 'validations' do
    it 'is invalid without a year' do
      expect(build :season, year: nil).to_not be_valid
    end

    it 'is invalid if year is not a number' do
      expect(build :season, year: 'sometime').to_not be_valid
    end
  end
end
