# frozen_string_literal: true

FactoryGirl.define do
  factory :team do
    name { "#{Faker::Hipster.words.first} #{Faker::Team.creature}".titleize }
    wins { [*0..13].sample }
    losses { 13 - wins }
    ties 0
    moves { [*0..40].sample }
    final_rank { wins.to_i >= 7 ? [*1..7].sample : [*8..14].sample }
    made_playoffs { final_rank.to_i <= 8 ? true : false }
    association :season, strategy: :build

    factory :team_w_owner_and_season do
      association :owner, strategy: :build
      association :season, strategy: :build
    end

    trait :with_scores_and_games do
      association :owner, strategy: :build
      after(:create) do |team|
        count = team.wins + team.losses
        create_list :reg_season_score, count, team: team
      end
    end
  end
end
