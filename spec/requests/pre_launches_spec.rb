require 'rails_helper'
#include Capybara::DSL

feature "Subsribing to newsletter" do 

  let(:user){ build :user}
  before :each do
      visit pre_launch_path
  end


  context "when someone subscribed" do
    
    before :each do
      fill_in 'email', with: user.email
      click_button 'Zapisz się'
    end

   scenario "he should see confirmation message" do
      expect(page).to have_content 'Twój email został dodany!'
    end

   scenario 'he should not see email field' do
       expect(page).not_to have_selector 'input[type=email]'
    end

   scenario 'he should not see any error message' do
      expect(page).not_to have_content 'Niepoprawny email!'
      expect(page).not_to have_content 'Ten email już istnieje!'
    end
  end

  context 'when someone use invalid email' do
   scenario 'while providing empty string he should see error message' do
      fill_in 'email', with: ""
      click_button 'Zapisz się'
      expect(page).to have_content 'Niepoprawny email!'
    end
   
   scenario 'while email pattern do not match validation regex he should see error message' do
      fill_in 'email', with: 'wrong email' 
      click_button 'Zapisz się'
      expect(page).to have_content 'Niepoprawny email!'
   end
  end

  context 'when someone use existing email' do
   scenario 'he should see information about existing email' do
      fill_in 'email', with: user.email
      click_button 'Zapisz się'
      visit '/pre_launch'
      fill_in 'email', with: user.email
      click_button 'Zapisz się'
      expect(page).to have_content 'Ten email już istnieje!'
    end
  end

end
