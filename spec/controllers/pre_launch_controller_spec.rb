require 'rails_helper'

RSpec.describe PreLaunchController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(flash[:errors]).not_to be_present
      expect(flash[:success]).not_to be_present
    end
  end
  
  describe "POST subscribe" do

    context "when email is valid" do
      let(:user) { build :user} 
      before :each do
        post :subscribe, email: user.email
      end

      it 'should call :create on :user' do
        allow(User).to receive(:create).and_return(User.new(email: user.email))
        expect(User).to receive(:create).with(email: user.email)
        post :subscribe, email: user.email
      end

      it "it should setup flash success message" do
        expect(flash[:success]).to eq 'Dziękujemy! Niedługo poznasz więcej szczegółów!'
      end

      it 'it should render action :subscribe' do
        expect(flash[:errors]).not_to be_present
        expect(response).to render_template :subscribe
      end

      it 'flash[:errors] should not be present' do
        expect(flash[:errors]).not_to be_present
      end
    end


    context "when email pattern do not match regex" do 

      it 'it should setup flash error' do
        post :subscribe, email: "dupa"
        expect(flash[:errors]).to be_present 
        expect(flash[:success]).not_to be_present
      end

      it 'it should render index template' do 
        post :subscribe, email: "dupa"
        expect(response).to render_template :index
      end

    end

    context "when email is empty" do 
      it 'should setup flash error' do 
        post :subscribe, email: ''
        expect(flash[:errors]).to be_present
        expect(flash[:success]).not_to be_present
      end

      it 'it should render index tempalte' do
        post :subscribe, email: ''
        expect(response).to render_template :index
      end
    end

    context 'when parameter is not an email' do
      it 'it should setup flash errors' do
        post :subscribe, dupa: 'dupa'
        expect(flash[:errors]).to be_present
        expect(flash[:succes]).not_to be_present
      end 

      it 'it should render index tempalte' do
        post :subscribe, dupa: 'dupa'
        expect(response).to render_template :index
      end
    end
  end
end
