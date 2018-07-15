# frozen_string_literal: true

module ScheduleMethods
  def past_schedule_page(year)
    get_past_season_home(year.to_s).links_with(text: 'Schedule').first.click
  end

  def past_schedule_page_by_week(year, week=1)
    by_week_page = past_schedule_page(year.to_s).links_with(text: 'By Week').first.click
    by_week_page.links_with(text: week.to_s).first.click
  end

  def past_game_data(year)
    # only call past_schedule_page_by_week once because it triggers the login process
    page = past_schedule_page_by_week(year.to_s, 1)
    weeks = [*1..13]
    x = weeks.each_with_object([]) do |week, arr|
      page = next_week_page(page, week) if week > 1
      arr << get_week_data(page, year, week)
    end.flatten
  end

  def get_week_data(page, year, week)
    page.search('.scorethin table').each_with_index.map do |table, i|
      game_data = GameTable.new(table, year, week).populate_game_data
      game_data[:game_number] = i + 1
      game_data
    end
  end

  def next_week_page(start_page, week)
    return if week > 13
    start_page.links_with(text: week.to_s).first.click
  end

  def create_game_records(year)
    game_data = past_game_data(year)
    game_data.each do |g|
      unless Game.where(season_id: g[:season_id], week: g[:week], game_number: g[:game_number]).exists?
        game = Game.create(g.slice(:season_id, :week, :game_number))
        g[:scores].each do |score|
          game.scores.create(score)
        end
      end
    end
  end
end
