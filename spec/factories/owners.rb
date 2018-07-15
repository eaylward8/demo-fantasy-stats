# frozen_string_literal: true

FactoryGirl.define do
  factory :owner do
    name { Faker::Name.name }
  end

  trait :with_teams do
    transient do
      team_count 1
    end

    after(:create) do |owner, evaluator|
      create_list :team, evaluator.team_count, owner: owner
    end
  end
end
