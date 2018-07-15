# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  let!(:season) { build :season }
  let!(:owner) { build :owner }
  let!(:team) { Team.create(
    season: season,
    owner: owner,
    name: "#{Faker::Hipster.words.first} #{Faker::Team.creature}".titleize,
    wins: 9,
    losses: 4,
    ties: 0,
    final_rank: 3,
    moves: 20
  ) }

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:team, season: season, owner: owner)).to be_valid
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      team.name = nil
      expect(team).to_not be_valid
    end

    it 'is invalid if made_playoffs is non-boolean' do
      team.made_playoffs = nil
      expect(team).to_not be_valid
    end

    it 'is invalid if wins are a non-integer' do
      team.wins = 'yo'
      expect(team).to_not be_valid
    end

    it 'is invalid if losses are a non-integer' do
      team.losses = 'whoa'
      expect(team).to_not be_valid
    end

    it 'is invalid if ties are a non-integer' do
      team.ties = 'no'
      expect(team).to_not be_valid
    end

    it 'is invalid if final rank is a non-integer' do
      team.final_rank = 'doe'
      expect(team).to_not be_valid
    end

    it 'is invalid if moves are a non-integer' do
      team.moves = 'joe'
      expect(team).to_not be_valid
    end

    it 'is invalid if wins are negative' do
      team.wins = -1
      expect(team).to_not be_valid
    end

    it 'is invalid if losses are negative' do
      team.losses = -1
      expect(team).to_not be_valid
    end

    it 'is invalid if ties are negative' do
      team.ties = -1
      expect(team).to_not be_valid
    end

    it 'is invalid if final rank is negative' do
      team.final_rank = -1
      expect(team).to_not be_valid
    end

    it 'is invalid if moves are negative' do
      team.moves = -1
      expect(team).to_not be_valid
    end

    it 'is invalid if sum of wins, losses, and ties is greater than 16' do
      team.wins = 10
      team.losses = 6
      team.ties = 1
      expect(team).to_not be_valid
    end
  end
end
