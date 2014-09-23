require 'rails_helper'
include Capybara::DSL

feature "Pre-launch page" do 
  feature "email field and button" do
    it "should save email after filling it in to email field and clickin submit button" 
    visit '/pre_launch'
    fill_in 'user_email', with: "roszman@gmail.com"
  end  
end
