# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OwnerCareer do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:owner_career).instance_of? OwnerCareer).to be true
    end
  end
end
