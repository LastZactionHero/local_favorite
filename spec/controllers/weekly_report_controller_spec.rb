require 'spec_helper'

describe WeeklyReportController do
  render_views

  let(:user){FactoryGirl.create(:user)}

  describe "unsubscribe" do

    it "unsubscribes successfully" do
      get :unsubscribe, {unsubscribe_token: user.unsubscribe_token}
      expect(response.body).to include("You have been unsubscribed.")

      user.reload
      expect(user.weekly_updates).to eq(false)
    end

    it "does not unsubscribe with a bad token" do
      get :unsubscribe, {unsubscribe_token: "garbage"}
      expect(response.body).to include("We were not able to unsubscribe because your link is invalid")
    end

  end

end
