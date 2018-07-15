# frozen_string_literal: true

module StandingsMethods
  def get_past_standings_table(year)
    standings_page = get_past_season_home(year.to_s).links_with(text: 'Standings').first.click
    standings_page.search('#standingstable')
  end

  def scrape_past_team_names(year)
    standings = get_past_standings_table(year.to_s)
    standings.search('tbody tr').map do |row|
      StandingsRow.new(row, year).team_name
    end
  end

  def scrape_all_team_names_from(start_yr, end_yr)
    [*start_yr..end_yr].each_with_object({}) do |year, h|
      h[year] = scrape_past_team_names(year.to_s)
    end
  end

  def past_standings_data(year)
    standings = get_past_standings_table(year.to_s)
    standings.search('tbody tr').each_with_object([]) do |row, arr|
      arr << StandingsRow.new(row, year).populate_team_data
    end
  end

  def create_team_records(year)
    standings_data = past_standings_data(year)
    standings_data.each do |team|
      # check if team already exists for that season
      unless Team.where(owner_id: team[:owner_id], season_id: team[:season_id]).exists?
        Team.create(team)
      end
    end
  end
end
