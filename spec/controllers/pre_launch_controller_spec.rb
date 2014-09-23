require 'rails_helper'

RSpec.describe PreLaunchController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "POST subscribe" do
    it "saving user with email" do
      user = build(:user)
      User.should_receive(:create).
                 with({email: user.email}.with_indifferent_access)
      post :subscribe, user: {email: user.email}
      #expect{}.to change(User, :count)
    end
  end
end
