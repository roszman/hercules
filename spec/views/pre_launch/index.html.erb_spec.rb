require 'rails_helper'

describe "PreLaunch" do 
  
  describe "#index" do

    before :each do
      visit pre_launch_path 
    end

    it "should have the content 'evosano'" do
      expect(page).to have_content('evosano')
    end

    it "should have the main message content" do
      expect(page).to have_content('Twój prywatny trener online. Darmowy, na zawsze.')
    end
    
    it "should have the features content" do
      expect(page).to have_content('Plany treningowe')
      expect(page).to have_content('Baza ćwiczeń')
      expect(page).to have_content('Analiza postępów')
    end
    
    it "should have intriguing question ;)" do
      expect(page).to have_content('Chcesz wiedzieć kiedy startujemy?')
    end

    it "should have field for user email" do
      expect(page).to have_selector('input[type=email]#email')
    end

    it "should have button to subscribe" do
      expect(page).to have_selector("input[type=submit][value='Chcę!']")
    end

    it 'should have facebook share button' do
      expect(page).to have_content 'Udostępnij'
    end

    it 'should have tweeter tweet button' do
      expect(page).to have_content 'Tweet'
    end

    it 'should have contact button' do
      expect(page).to have_content 'Kontakt'
    end

    it 'should have spam policy info' do
      expect(page).to have_content 'Zero spamu, tylko konkretne informacje na temat startu naszej usługi.'
    end

    it 'should not have debugger output' do
      expect(page).not_to have_selector 'pre.debug_dump'
    end
  end
end
