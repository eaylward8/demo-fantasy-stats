# frozen_string_literal: true

FactoryGirl.define do
  factory :owner_career do
    skip_create
    initialize_with { new(create :owner) }
  end
end
