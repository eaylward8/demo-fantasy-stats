# frozen_string_literal: true

module PlayoffMethods
  def get_playoff_game_data(year)
    season_home = get_past_season_home(year.to_s)
    champ_table = season_home.search('#playofftable')
    consolation_page = season_home.link_with(text: 'Consolation').click
    consolation_table = consolation_page.search('#playofftable')

    champ_data = PlayoffTable.new(champ_table, year, true).populate_playoff_data
    consolation_data = PlayoffTable.new(consolation_table, year, false).populate_playoff_data
    combined_playoff_data = champ_data.push(*consolation_data)

    assign_game_numbers(combined_playoff_data)
  end

  def assign_game_numbers(games)
    w14_num = 1
    w15_num = 1
    w16_num = 1

    games.each do |game|
      if game[:week] == 14
        game[:game_number] = w14_num
        w14_num += 1
      elsif game[:week] == 15
        game[:game_number] = w15_num
        w15_num += 1
      elsif game[:week] == 16
        game[:game_number] = w16_num
        w16_num += 1
      end
    end
    games
  end

  def create_playoff_game_records(year)
    game_data = get_playoff_game_data(year)
    game_data.each do |g|
      unless Game.where(season_id: g[:season_id], week: g[:week], game_number: g[:game_number]).exists?
        game = Game.create(g.slice(:season_id, :week, :game_number, :game_type))
        g[:scores].each do |score|
          game.scores.create(score)
        end
      end
    end
  end
end
