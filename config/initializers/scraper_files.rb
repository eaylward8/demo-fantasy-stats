# frozen_string_literal: true

# order matters here, otherwise I'd loop over & require each one
require File.join(Rails.root, 'lib/scrapers', 'standings_methods')
require File.join(Rails.root, 'lib/scrapers', 'schedule_methods')
require File.join(Rails.root, 'lib/scrapers', 'playoff_methods')
require File.join(Rails.root, 'lib/scrapers', 'fantasy_scraper')
require File.join(Rails.root, 'lib/scrapers', 'standings_row')
require File.join(Rails.root, 'lib/scrapers', 'game_table')
require File.join(Rails.root, 'lib/scrapers', 'playoff_table')
