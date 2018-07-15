# frozen_string_literal: true

class OwnerRecords
  attr_reader :owner, :data, :high_score, :low_score, :big_win, :big_loss, :small_win, :small_loss,
              :high_points_for, :low_points_for, :most_moves, :least_moves

  def initialize(owner)
    @owner = owner
    @high_score = owner.high_score_week_year
    @low_score = owner.low_score_week_year
    @big_win = owner.biggest_win
    @big_loss = owner.biggest_loss
    @small_win = owner.smallest_win
    @small_loss = owner.smallest_loss
    @teams_data = owner.teams_data.sort_by { |t| t[:points_for] }
    @high_points_for = @teams_data.last
    @low_points_for = @teams_data.first
    @most_moves = owner.most_moves
    @least_moves = owner.least_moves
    @data = fetch_data
  end

  def fetch_data
    { game: game_records, season: season_records }
  end

  def game_records
    [
      {
        description: 'Points - Most',
        stat: high_score[0],
        week: high_score[1],
        year: high_score[2]
      },
      {
        description: 'Points - Least',
        stat: low_score[0],
        week: low_score[1],
        year: low_score[2]
      },
      {
        description: 'Win - Biggest',
        stat: big_win[:margin],
        week: big_win[:week],
        year: big_win[:year],
        opponent: big_win[:opponent]
      },
      {
        description: 'Win - Smallest',
        stat: small_win[:margin],
        week: small_win[:week],
        year: small_win[:year],
        opponent: small_win[:opponent]
      },
      {
        description: 'Loss - Biggest',
        stat: big_loss[:margin],
        week: big_loss[:week],
        year: big_loss[:year],
        opponent: big_loss[:opponent]
      },
      {
        description: 'Loss - Smallest',
        stat: small_loss[:margin],
        week: small_loss[:week],
        year: small_loss[:year],
        opponent: small_loss[:opponent]
      }
    ]
  end

  def season_records
    [
      {
        description: 'Points - Most',
        stat: high_points_for[:points_for],
        year: high_points_for[:year]
      },
      {
        description: 'Points - Least',
        stat: low_points_for[:points_for],
        year: low_points_for[:year]
      },
      {
        description: 'Moves - Most',
        stat: most_moves[:moves],
        year: most_moves[:year]
      },
      {
        description: 'Moves - Least',
        stat: least_moves[:moves],
        year: least_moves[:year]
      }
    ]
  end
end
