# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:owner)).to be_valid
    end
  end

  describe 'instance methods' do
    let!(:owner) { create(:owner) }
    let!(:team1) { create(:team,
                          wins: 5,
                          losses: 8,
                          ties: 0,
                          final_rank: 10,
                          made_playoffs: false,
                          owner: owner) }
    let!(:team2) { create(:team,
                          wins: 10,
                          losses: 2,
                          ties: 1,
                          final_rank: 2,
                          made_playoffs: true,
                          owner: owner) }

    let!(:game1) { create :game, :reg_season }
    let!(:game2) { create :game, :playoff }
    let!(:game3) { create :game, :reg_season }
    let!(:game4) { create :game, :playoff }

    let!(:score1) { create :score, points: 142.68, team: team1, game: game1 }
    let!(:score2) { create :score, points: 87.54, team: team1, game: game2 }
    let!(:score3) { create :score, points: 52.47, team: team2, game: game3 }
    let!(:score4) { create :score, points: 93.51, team: team2, game: game4 }

    describe '#seasons_played' do
      it 'returns number of seasons played (via team count)' do
        expect(owner.seasons_played).to eq 2
      end
    end

    describe '#games_played' do
      it 'returns number of games played' do
        expect(owner.games_played).to eq 4
      end
    end

    describe '#total(stat)' do
      it 'returns sum of all wins/losses/ties' do
        expect(owner.total(:wins)).to eq 17
        expect(owner.total(:losses)).to eq 10
        expect(owner.total(:ties)).to eq 1
      end

      it 'returns nil if argument is not wins, losses, or ties' do
        expect(owner.total('beefcakes')).to be_nil
      end
    end

    describe '#total_reg_season(stat)' do
      it 'returns sum of regular season wins/losses/ties' do
        expect(owner.total_reg_season(:wins)).to eq 15
        expect(owner.total_reg_season(:losses)).to eq 10
        expect(owner.total_reg_season(:ties)).to eq 1
      end

      it 'returns nil if argument is not wins, losses, or ties' do
        expect(owner.total_reg_season('pizzas')).to be_nil
      end
    end

    describe '#avg_reg_season(stat)' do
      it "returns avg regular season wins/losses/ties for that owner's teams" do
        expect(owner.avg_reg_season(:wins)).to eq 7.5
        expect(owner.avg_reg_season(:losses)).to eq 5
        expect(owner.avg_reg_season(:ties)).to eq 0.5
      end

      it 'returns nil if argument is not wins, losses, or ties' do
        expect(owner.total_reg_season('bagels')).to be_nil
      end
    end

    describe '#total_win_pct' do
      let!(:owner2) { create(:owner) }
      let!(:owner2_team) { create(:team, wins: 1, owner: owner2) }
      let!(:other_team) { create(:team_w_owner_and_season) }

      let!(:g1) { create(:game, :reg_season) }
      let!(:s1) { create(:score, points: 100, team: owner2_team, game: g1) }
      let!(:s2) { create(:score, points: 80, team: other_team, game: g1) }

      let!(:g2) { create(:game, :playoff) }
      let!(:s3) { create(:score, points: 75, team: owner2_team, game: g2) }
      let!(:s4) { create(:score, points: 98, team: other_team, game: g2) }

      it "returns owner's total win percentage" do
        expect(owner2.total_win_pct).to eq 0.500
      end
    end

    describe '#reg_season_win_pct' do
      it "returns owner's regular season win percentage" do
        expect(owner.reg_season_win_pct).to eq 0.577
      end
    end

    describe '#reg_season_record' do
      it 'returns hash with keys of wins, losses, and ties' do
        expect(owner.reg_season_record.keys).to eq [:wins, :losses, :ties]
      end

      it 'returns hash with values of the sum of wins, losses, and ties' do
        expect(owner.reg_season_record.values).to eq [15, 10, 1]
      end
    end

    describe '#best_final_rank' do
      it "returns best final rank for all owner's teams" do
        expect(owner.best_final_rank).to eq 2
      end
    end

    describe '#avg_final_rank' do
      it "returns avg final rank for all owner's teams" do
        expect(owner.avg_final_rank).to eq 6.0
      end
    end

    describe '#teams_ranked' do
      it "returns the count of owner's teams that finished with the given rank" do
        expect(owner.teams_ranked(1)).to eq 0
        expect(owner.teams_ranked(2)).to eq 1
      end

      it 'returns nil if argument is not in 1 - 16' do
        expect(owner.teams_ranked(20)).to be_nil
      end
    end

    describe '#total_moves' do
      it "returns sum of moves by all owner's teams" do
        expect(owner.total_moves).to eq team1.moves + team2.moves
      end
    end

    describe '#playoff_teams' do
      it 'returns count of teams that made the playoffs' do
        expect(owner.playoff_teams).to eq 1
      end
    end

    describe '#most_points' do
      it 'returns highest single-week point total' do
        expect(owner.most_points).to eq 142.68
      end
    end

    describe '#least_points' do
      it 'returns lowest single-week point total' do
        expect(owner.least_points).to eq 52.47
      end
    end

    describe '#high_score_week_year' do
      it 'returns an array with most points, week number, and year' do
        week = score1.game.week
        year = score1.game.season.year
        expect(owner.high_score_week_year).to eq [142.68, week, year]
      end
    end

    describe '#low_score_week_year' do
      it 'returns an array with least points, week number, and year' do
        week = score3.game.week
        year = score3.game.season.year
        expect(owner.low_score_week_year).to eq [52.47, week, year]
      end
    end

    describe '#weekly_avg_pts' do
      it 'returns weekly avg points scored for owner' do
        expect(owner.weekly_avg_pts).to eq 94.05
      end
    end

    describe '#avg_pts_reg_season' do
      it 'returns avg points scored for regular season games' do
        expect(owner.avg_pts_reg_season).to eq 97.58
      end
    end

    describe '#avg_pts_playoffs' do
      it 'returns avg points scored for playoff games' do
        expect(owner.avg_pts_playoffs).to eq 90.53
      end
    end
  end
end
