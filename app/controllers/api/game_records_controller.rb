# frozen_string_literal: true

module Api
  class GameRecordsController < ApplicationController
    def points_most
      all        = format_game_records(Game.with_highest_scores)
      reg_season = format_game_records(Game.reg_season.with_highest_scores)
      playoffs   = format_game_records(Game.playoffs.with_highest_scores(10))
      render json: { all: all, reg_season: reg_season, playoffs: playoffs }
    end

    def points_least
      all        = format_game_records(Game.with_lowest_scores)
      reg_season = format_game_records(Game.reg_season.with_lowest_scores)
      playoffs   = format_game_records(Game.playoffs.with_lowest_scores(10))
      render json: { all: all, reg_season: reg_season, playoffs: playoffs }
    end

    private

    def format_game_records(games)
      games.each_with_object([]).with_index do |(game, arr), i|
        arr << {
          rank: i + 1,
          owner: game.scores.first.team.owner.name,
          points: game.scores.first.points,
          year: game.season.year,
          week: game.game_type ? "#{game.week} (#{game.game_type})" : game.week,
          opponent: game.scores.last.team.owner.name
        }
      end
    end
  end
end
