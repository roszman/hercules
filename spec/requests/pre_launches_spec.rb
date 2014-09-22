require 'rails_helper'

describe "Pre-launch page" do 
  
  describe "Index page" do

    it "should have the content 'evosano'" do
      visit '/pre_launch/' 
      expect(page).to have_content('evosano')
    end

    it "should have the main message content" do
      visit '/pre_launch'
      expect(page).to have_content('Twój prywatny trener online. Darmowy, na zawsze.')
    end
    it "should have the features content" do
      visit '/pre_launch'
      expect(page).to have_content('Plany treningowe')
      expect(page).to have_content('Baza ćwiczeń')
      expect(page).to have_content('Analiza postępów')
    end
    it "should have the pre call to action content" do
      visit '/pre_launch'
      expect(page).to have_content('Chcesz wiedzieć kiedy startujemy?')
    end
  it "should have field for email" do
    visit 'pre_launch'
    expect(page).to have_selector('input[type=email]')
  end

  it "should have button for posting email" do
    visit 'pre_launch'
    expect(page).to have_selector('button[type=submit]', :text => "Zapisz sir")
  end

  end
end
