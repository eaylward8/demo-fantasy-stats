# frozen_string_literal: true

class AllTimeStandings
  attr_reader :owners, :data

  def initialize
    @owners = Owner.includes(:teams).all
    @data = fetch_data
  end

  def fetch_data
    @owners.each_with_object([]) do |owner, arr|
      arr << stat_hash(owner)
    end.sort_by { |o| [-o[:points], -o[:wins]] }
  end

  def stat_hash(owner)
    wins = owner.total_reg_season(:wins)
    losses = owner.total_reg_season(:losses)
    firsts = owner.teams_ranked(1)
    seconds = owner.teams_ranked(2)
    thirds = owner.teams_ranked(3)
    {
      name: owner.name,
      wins: wins,
      losses: losses,
      pct: sprintf('%.3f', (wins / (wins + losses).to_f)).slice(1..-1),
      first: firsts,
      second: seconds,
      third: thirds,
      points: calculate_points(firsts, seconds, thirds)
    }
  end

  def calculate_points(firsts, seconds, thirds)
    firsts * 5 + seconds * 3 + thirds
  end
end
