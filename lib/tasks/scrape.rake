# frozen_string_literal: true

namespace :scrape do
  desc 'Create Team records from past season data'
  task :teams, [:year] => [:environment] do |t, args|
    year = args[:year].to_i
    check_year(year)
    Season.create(year: year) unless Season.find_by(year: year)

    puts 'Getting ready to create Team records...'
    count = Team.where(season: Season.where(year: year)).count
    puts "Currently #{count} Team records for the #{year} season."

    scraper = FantasyScraper.new
    scraper.create_team_records(year)

    new_count = Team.where(season: Season.where(year: year)).count
    puts "#{new_count - count} Teams imported."
    puts "#{new_count} Teams exist for the #{year} season."
  end

  desc 'Create Game and Score records from past season data'
  task :games_scores, [:year] => [:environment] do |t, args|
    year = args[:year].to_i
    check_year(year)

    season = Season.find_by(year: year)

    puts 'Getting ready to create Game and Score records'
    game_count = season.games.count
    score_count = season.scores.count
    puts "Currently #{game_count} Game records for the #{year} season."
    puts "Currently #{score_count} Score records for the #{year} season."

    scraper = FantasyScraper.new
    scraper.create_game_records(year)

    season.reload
    new_game_count = season.games.count
    new_score_count = season.scores.count
    puts "#{new_game_count - game_count} Games imported."
    puts "#{new_game_count} Games exist for the #{year} season."
    puts "#{new_score_count - score_count} Scores imported."
    puts "#{new_score_count} Scores exist for the #{year} season."
  end

  desc 'Create Playoff Game and Score records from past season data'
  task :playoffs, [:year] => [:environment] do |t, args|
    year = args[:year].to_i
    check_year(year)

    season = Season.find_by(year: year)

    puts 'Getting ready to create Playoff Game and Score records'
    game_count = season.games.where(week: [14, 15, 16]).count
    puts "Currently #{game_count} Playoff Game records for the #{year} season."

    scraper = FantasyScraper.new
    scraper.create_playoff_game_records(year)

    season.reload
    new_game_count = season.games.where(week: [14, 15, 16]).count
    puts "#{new_game_count - game_count} Playoff Games imported."
    puts "#{new_game_count} Playoff Games exist for the #{year} season."
  end

  def check_year(year)
    if year < 2012 || year >= Time.now.year
      puts "Hey. What the heck. Give me a year between 2012 and #{Time.now.year - 1}."
      exit
    end
  end
end
