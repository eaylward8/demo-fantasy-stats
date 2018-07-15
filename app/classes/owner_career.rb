# frozen_string_literal: true

class OwnerCareer
  attr_reader :owner, :data

  def initialize(owner)
    @owner = owner
    @data = fetch_data
  end

  def fetch_data
    [regular_season, playoffs, combined]
  end

  def regular_season
    {
      name: 'Reg Season',
      wins: owner.total_reg_season(:wins),
      losses: owner.total_reg_season(:losses),
      pct: owner.reg_season_win_pct,
      avg_pts: owner.avg_pts_reg_season,
      margin: owner.avg_margin_reg_season
    }
  end

  def playoffs
    pr = owner.playoff_record
    {
      name: 'Playoffs',
      wins: pr[:wins],
      losses: pr[:losses],
      pct: (pr[:wins] / (pr[:wins] + pr[:losses].to_f)).round(3),
      avg_pts: owner.avg_pts_playoffs,
      margin: owner.avg_margin_playoffs
    }
  end

  def combined
    {
      name: 'Combined',
      wins: owner.total(:wins),
      losses: owner.total(:losses),
      pct: owner.total_win_pct,
      avg_pts: owner.weekly_avg_pts,
      margin: owner.avg_margin_total
    }
  end
end
