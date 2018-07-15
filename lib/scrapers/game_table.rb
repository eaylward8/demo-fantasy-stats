# frozen_string_literal: true

class GameTable
  attr_reader :table, :year
  attr_accessor :game_data

  # table is a Nokogiri::XML::Element class
  def initialize(table, year, week)
    @table = table
    @year = year.to_i
    @game_data = { week: week.to_i }
  end

  def populate_game_data
    @game_data[:season_id] = Season.where(year: @year).first.id
    @game_data[:scores] = scrape_score_info
    @game_data
  end

  def scrape_score_info
    @table.search('tr').each_with_object([]) do |row, arr|
      team_name = row.search('.team').text
      points = row.search('.score').text.to_f
      arr << { team_id: lookup_team_id(team_name, @year), points: points }
    end
  end

  def lookup_team_id(name, year)
    season_id = Season.find_by(year: year).id
    name = find_fake_team(name)
    Team.where(name: name, season_id: season_id).first.id
  end

  # not needed in real app
  def find_fake_team(team_name)
    owner = Owner::TEAM_NAME_MAP.find do |o|
      o[:team_names].keys.include?(team_name.to_sym)
    end
    owner[:team_names][team_name.to_sym]
  end
end
