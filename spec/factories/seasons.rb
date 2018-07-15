# frozen_string_literal: true

FactoryGirl.define do
  sequence(:year) { |n| 2000 + n }

  factory :season do
    year
  end
end
