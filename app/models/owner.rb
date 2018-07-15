# frozen_string_literal: true

class Owner < ApplicationRecord
  has_many :teams
  validates :name, presence: true
  include OwnerTeamNameMap

  # ideas
  # avg points against per week (reg season and playoffs)
  # playoff streak - consecutive seasons in playoffs
  # win streak (reg season, combined)

  def seasons_played
    teams.count
  end

  def games_played
    teams.joins(:games).count
  end

  def total(stat)
    return unless %i(wins losses ties).include? stat.to_sym
    total = total_reg_season(stat.to_sym)
    total += playoff_record[stat.to_sym] if stat.to_sym != :ties
    total
  end

  def total_reg_season(stat)
    return unless %i(wins losses ties).include? stat.to_sym
    teams.sum(stat.to_sym)
  end

  def avg_reg_season(stat)
    return unless %i(wins losses ties).include? stat.to_sym
    teams.average(stat.to_sym).to_f
  end

  def total_win_pct
    wins = total(:wins)
    (wins / games_played.to_f).round(3)
  end

  def reg_season_win_pct
    (total_reg_season(:wins) / (seasons_played * 13.0)).round(3)
  end

  def avg_reg_season_rank
    # more difficult
    # need to know reg season record & points for each team in that season
  end

  def reg_season_record
    { wins: teams.sum(:wins), losses: teams.sum(:losses), ties: teams.sum(:ties) }
  end

  def playoff_record
    team_ids = teams.pluck(:id)
    # include/join teams as well?
    games = Game.includes(:scores).where(week: [*14..16]).order('scores.points')
    games.each_with_object({ wins: 0, losses: 0 }) do |g, h|
      next unless (team_ids & g.scores.pluck(:team_id)).present?
      team_ids.include?(g.scores.last.team_id) ? h[:wins] += 1 : h[:losses] += 1
    end
  end

  def best_final_rank
    teams.minimum(:final_rank)
  end

  def worst_final_rank
    teams.maximum(:final_rank)
  end

  def avg_final_rank
    teams.average(:final_rank).to_f
  end

  def teams_ranked(rank=1)
    return unless [*1..16].include?(rank.to_i)
    teams.where(final_rank: rank.to_i).count
  end

  def total_moves
    teams.sum(:moves)
  end

  def most_moves
    teams.select(:id, :season_id, :moves).order(:moves)
         .last.attributes.each_with_object({}) do |(k, v), h|
      k == 'season_id' ? h[:year] = Season.find(v).year : h[k.to_sym] = v
    end
  end

  def least_moves
    teams.select(:id, :season_id, :moves).order(:moves)
         .first.attributes.each_with_object({}) do |(k, v), h|
      k == 'season_id' ? h[:year] = Season.find(v).year : h[k.to_sym] = v
    end
  end

  def playoff_teams
    teams.where(made_playoffs: true).count
  end

  def most_points
    teams.joins(:scores).maximum(:points)
  end

  def least_points
    teams.joins(:scores).minimum(:points)
  end

  def high_score_week_year
    # returns array [points, week, year]
    Score.where(team_id: teams.ids)
         .includes(game: :season)
         .order(points: :desc)
         .pluck(:points, :week, :year).first
  end

  def low_score_week_year
    # returns array [points, week, year]
    Score.where(team_id: teams.ids)
         .includes(game: :season)
         .order(:points)
         .pluck(:points, :week, :year).first
  end

  def weekly_avg_pts
    teams.joins(:scores).average(:points).to_f.round(2)
  end

  def avg_pts_reg_season
    Score.joins(:game)
         .where(team_id: teams.pluck(:id), games: { week: [*1..13] })
         .average(:points).to_f.round(2)
  end

  def avg_pts_playoffs
    Score.joins(:game)
         .where(team_id: teams.pluck(:id), games: { week: [*14..16] })
         .average(:points).to_f.round(2)
  end

  def game_ids
    Game.includes(:teams).where(teams: { id: teams.ids }).ids
  end

  def games_data
    Game.includes(:season, scores: { team: :owner })
        .where(id: game_ids)
        .order(:season_id, :week)
        .references(:season, scores: { team: :owner } )
  end

  def margins_by_week_year
    team_ids = teams.ids
    games_data.map do |g|
      score = g.scores.find { |s| team_ids.include?(s.team_id) }
      opp_score = g.scores.find { |s| score != s }
      { week: g.week,
        year: g.season.year,
        margin: (score.points - opp_score.points).round(2),
        opponent: opp_score.team.owner.name }
    end.sort_by { |record| record[:margin] }
  end

  def biggest_win
    margins_by_week_year.last
  end

  def biggest_loss
    margins_by_week_year.first
  end

  def smallest_win
    margins_by_week_year.reject { |record| record[:margin] < 0 }.first
  end

  def smallest_loss
    margins_by_week_year.reject { |record| record[:margin] > 0 }.last
  end

  # TODO: refactor margin methods
  def avg_margin_total
    game_ids = Game.includes(:teams).where(teams: { id: teams.ids }).ids
    return nil unless game_ids.present?

    points = Game.includes(scores: :team)
                 .where(teams: { id: teams.ids })
                 .order(:season_id, :week)
                 .map { |g| g.scores[0].points }
    opp_points = Game.includes(scores: :team)
                     .where(id: game_ids)
                     .where.not(teams: { id: teams.ids })
                     .order(:season_id, :week)
                     .map { |g| g.scores[0].points }
    margins = [points, opp_points].transpose.map { |arr| arr.reduce(&:-).round(2) }
    (margins.reduce(&:+) / margins.count).round(2)
  end

  def avg_margin_reg_season
    game_ids = Game.includes(:teams).where(week: [*1..13], teams: { id: teams.ids }).ids
    return nil unless game_ids.present?

    points = Game.includes(scores: :team)
                 .where(id: game_ids, teams: { id: teams.ids })
                 .order(:season_id, :week)
                 .map { |g| g.scores[0].points }
    opp_points = Game.includes(scores: :team)
                     .where(id: game_ids)
                     .where.not(teams: { id: teams.ids })
                     .order(:season_id, :week)
                     .map { |g| g.scores[0].points }
    margins = [points, opp_points].transpose.map { |arr| arr.reduce(&:-).round(2) }
    (margins.reduce(&:+) / margins.count).round(2)
  end

  def avg_margin_playoffs
    game_ids = Game.includes(:teams).where(week: [*14..16], teams: { id: teams.ids }).ids
    return nil unless game_ids.present?

    points = Game.includes(scores: :team)
                 .where(id: game_ids, teams: { id: teams.ids })
                 .order(:season_id, :week)
                 .map { |g| g.scores[0].points }
    opp_points = Game.includes(scores: :team)
                     .where(id: game_ids)
                     .where.not(teams: { id: teams.ids })
                     .order(:season_id, :week)
                     .map { |g| g.scores[0].points }
    margins = [points, opp_points].transpose.map { |arr| arr.reduce(&:-).round(2) }
    (margins.reduce(&:+) / margins.count).round(2)
  end

  def record_against_all
    team_ids = teams.pluck(:id)
    records = init_owner_record_hash
    games = Game.includes(scores: { team: :owner }).order('scores.points')

    games.each_with_object(records) do |g, records|
      next if (team_ids & g.scores.pluck(:team_id)).empty?
      l_owner = g.scores[0].team.owner.id
      w_owner = g.scores[1].team.owner.id

      # if first team id is in team_ids, that's a loss
      if team_ids.include?(g.scores[0].team_id)
        records[w_owner][:total_l] += 1
        g.game_type ? records[w_owner][:pl_l] += 1 : records[w_owner][:reg_l] += 1
      else # win
        records[l_owner][:total_w] += 1
        g.game_type ? records[l_owner][:pl_w] += 1 : records[l_owner][:reg_w] += 1
      end
    end
  end

  def most_victories_against
    records = record_against_all
    most_wins_val = records.values.sort { |a, b| b[:r_wins] <=> a[:r_wins] }.first
    records.select do |k, v|
      v[:r_wins] == most_wins_val[:r_wins]
    end
  end

  def most_losses_against
    records = record_against_all
    most_wins_val = records.values.sort { |a, b| b[:r_losses] <=> a[:r_losses] }.first
    records.select do |k, v|
      v[:r_losses] == most_wins_val[:r_losses]
    end
  end

  def longest_win_streak
    streak = 0
    longest = 0
    Game.joins(:teams).where(teams: { owner_id: id }).each do |g|
      if g.winning_team.owner == self
        streak += 1
      else
        longest = streak if streak > longest
        streak = 0
      end
    end
    longest
  end

  def teams_data
    teams.includes(:season, scores: :game).where(games: { week: [*1..13] })
         .each_with_object([]) do |t, arr|
      team_hash = t.attributes.except('id', 'owner_id', 'season_id', 'created_at', 'updated_at')
      team_hash[:year] = t.season.year
      team_hash[:points_for] = t.scores.map(&:points).reduce(:+).round(2)
      team_hash[:points_against] = t.points_against_reg_season
      arr << team_hash.symbolize_keys
    end
  end

  def game_ids_by_week(start_wk = 1, end_wk = 16)
    Game.joins(:teams).where(week: [*start_wk..end_wk], teams: { id: teams.ids }).ids
  end

  private

    def init_owner_record_hash
      opponents = Owner.where.not(id: id).pluck(:id, :name)
      opponents.each_with_object({}) do |opp, h|
        h[opp[0]] = {
          name: opp[1],
          total_w: 0,
          total_l: 0,
          reg_w: 0,
          reg_l: 0,
          pl_w: 0,
          pl_l: 0
        }
      end
    end
end
