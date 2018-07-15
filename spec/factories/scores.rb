# frozen_string_literal: true

FactoryGirl.define do
  factory :score do
    points { Faker::Number.decimal(2) }
    association :game, strategy: :create

    factory :reg_season_score do
      association :game, :reg_season, strategy: :create
    end

    factory :playoff_score do
      association :game, :playoff, strategy: :create
    end
  end
end
