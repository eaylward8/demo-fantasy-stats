# frozen_string_literal: true

class StandingsRow
  attr_reader :row, :year
  attr_accessor :team_data

  # row is a Nokogiri::XML::Element class
  def initialize(row, year)
    @row = row
    @year = year.to_i
    @team_data = {}
  end

  def populate_team_data
    @team_data[:season_id] = Season.where(year: @year).first.id
    @team_data[:made_playoffs] = made_playoffs
    @team_data[:final_rank] = final_rank
    @team_data[:name] = find_fake_team(team_name)
    record = record_array
    @team_data[:wins] = record[0]
    @team_data[:losses] = record[1]
    @team_data[:ties] = record[2]
    @team_data[:moves] = moves
    @team_data[:owner_id] = map_team_to_owner
    @team_data
  end

  # not needed in real app
  def find_fake_team(team_name)
    owner = Owner::TEAM_NAME_MAP.find do |o|
      o[:team_names].keys.include?(team_name.to_sym)
    end
    owner[:team_names][team_name.to_sym]
  end

  def map_team_to_owner
    owner = Owner::TEAM_NAME_MAP.find do |o|
      o[:team_names].values.include?(team_data[:name])
    end
    Owner.where(name: owner[:name]).first.id
  end

  def made_playoffs
    @row.children[1].children[0].text[0] == '*'
  end

  def final_rank
    rank = @row.children[1].children[0].text.match(/\d+\d*/)[0].to_i
    rank.positive? ? rank : nil
  end

  def team_name
    @row.children[3].search('a').text
  end

  def record_array
    @row.children[5].children[0].text.split('-').map(&:to_i)
  end

  def moves
    @row.children[17].children[0].text.to_i
  end
end
