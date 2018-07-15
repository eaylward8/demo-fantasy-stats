# frozen_string_literal: true

FactoryGirl.define do
  factory :game do
    week { rand(1..16) }
    association :season, strategy: :build
    game_type nil

    factory :game_w_season do
      association :season, strategy: :build
    end

    trait :reg_season do
      week { rand(1..13) }
    end

    trait :playoff do
      week { rand(14..16) }
      game_type 'Playoff'
    end
  end
end
