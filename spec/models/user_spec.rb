require 'spec_helper'

describe User do

  describe 'create' do

    it 'initializes with automatic favoriting true' do
      user = FactoryGirl.create(:user)
      expect(user.automatic_favoriting).to eq(true)
    end
    
  end

  describe 'unsubscribe_token' do

    it 'should have an unsubscribe token' do
      user = FactoryGirl.create(:user)
      expect(user.unsubscribe_token).to be_present
      expect(user.weekly_updates).to eq(true)
    end

  end

  describe "unsubscribe_weekly_reports!" do

    it 'should unsubscribe' do
      user = FactoryGirl.create(:user)
      user.unsubscribe_weekly_reports!
      expect(user.weekly_updates).to eq(false)
    end

  end

end
