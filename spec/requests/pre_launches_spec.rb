require 'rails_helper'
#include Capybara::DSL

feature "Subsribing to newsletter" do 
  let(:subscribe_button_text){'Chcę!'}
  let(:user){ build :user}
  before :each do
      visit pre_launch_path
  end


  context "when someone subscribed" do
    
    before :each do
      fill_in 'email', with: user.email
      click_button subscribe_button_text
    end

   scenario "he should see confirmation message" do
      expect(page).to have_content 'Dziękujemy :)Niedługo poznasz więcej szczegółów!'
    end

   scenario 'he should not see email field' do
       expect(page).not_to have_selector 'input[type=email]'
    end

   scenario 'he should not see any error message' do
      expect(page).not_to have_content 'Upewnij się czy podany email jest prawidłowy.'
      expect(page).not_to have_content 'Mamy już Twój email.'
    end
  end

  context 'when someone use invalid email' do
   scenario 'while providing empty string he should see error message' do
      fill_in 'email', with: ""
      click_button subscribe_button_text
      expect(page).to have_content 'Upewnij się, czy podany email jest prawidłowy.'
    end
   
   scenario 'while email pattern do not match validation regex he should see error message' do
      fill_in 'email', with: 'wrong email' 
      click_button subscribe_button_text
      expect(page).to have_content 'Upewnij się, czy podany email jest prawidłowy.'
   end
  end

  context 'when someone use existing email' do
   scenario 'he should see thank you message' do
      fill_in 'email', with: user.email
      click_button subscribe_button_text
      visit '/pre_launch'
      fill_in 'email', with: user.email
      click_button subscribe_button_text
      expect(page).to have_content 'Dziękujemy :)Niedługo poznasz więcej szczegółów!'
    end
  end

end
