# frozen_string_literal: true

class FantasyScraper
  include StandingsMethods
  include ScheduleMethods
  include PlayoffMethods

  def initialize
    @agent = Mechanize.new
    @username = ENV['Y_USERNAME']
    @password = ENV['Y_PASSWORD']
    @login_url = 'https://login.yahoo.com/config/login?.src=spt&.intl=us&.done=http%3A%2F%2Ffootball.fantasysports.yahoo.com%2Ff1%3F.scrumb%3D0&specId=usernameRegWithName'
  end

  def get_fantasy_home
    login_page1 = @agent.get(@login_url)
    login_form1 = login_page1.forms.first
    login_form1.username = @username

    login_page2 = @agent.submit(login_form1, login_form1.buttons.first)
    login_form2 = login_page2.forms.first
    login_form2.password = @password

    @agent.submit(login_form2, login_form2.button('verifyPassword'))
  end

  def get_league_home
    fantasy_home = get_fantasy_home
    fantasy_home.links_with(text: '812')[0].click
  end

  def get_past_season_home(year)
    season_form = get_league_home.forms.select { |form| form.has_field?('seasonspec') }.first
    season_form.field_with(name: 'seasonspec').options.find do |o|
      !!o.text.match(/#{year}/)
    end.tick
    @agent.submit(season_form)
  end
end
