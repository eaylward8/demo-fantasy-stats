# frozen_string_literal: true

class PlayoffTable
  attr_reader :table, :year
  attr_accessor :game_data

  def initialize(table, year, championship=true)
    @table = table
    @year = year.to_i
    @playoff_data = []
    @championship = championship
  end

  def populate_playoff_data
    game_divs = @table.search('tbody').xpath('//div[starts-with(@id, "g")]')
    game_divs.each do |game_div|
      next if game_div['id'] == 'g9'
      next if game_div.search('p')[1].text == 'Bye'

      game_data = {}
      game_data[:season_id] = Season.find_by(year: @year).id
      header = header = game_div.search('h5').first.text
      game_data[:game_type] = determine_game_type(header)
      game_data[:week] = determine_week(header)
      game_data[:scores] = scrape_score_info(game_div)
      @playoff_data << game_data
    end
    @playoff_data
  end

  def scrape_score_info(game_div)
    game_div.search('p').each_with_object([]) do |p, arr|
      team_name = p.search('span a').text
      points = p.search('strong').text.to_f
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

  def determine_game_type(header)
    if header == 'Semifinal' && !@championship
      'Consolation Semifinal'
    elsif header == 'Quarterfinal' && !@championship
      'Consolation Quarterfinal'
    else
      header
    end
  end

  def determine_week(header)
    if @year == 2016
      case header
      when 'Quarterfinal'
        14
      when 'Semifinal', '5th Place Game', '11th Place Game'
        15
      when 'Final', '3rd Place Game', '7th Place Game', '9th Place Game'
        16
      end
    else
      case header
      when 'Quarterfinal'
        14
      when 'Semifinal'
        15
      when 'Final', '3rd Place Game', '5th Place Game', '7th Place Game'
        16
      end
    end
  end
end
