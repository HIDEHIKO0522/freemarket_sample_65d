require 'rails_helper'

describe SignupController do

  describe 'GET #registration' do
    it "renders the :registration template" do
      get :registration
      expect(response).to render_template :registration
    end
  end  

  describe 'GET #sms_authentication' do
    it "renders the :sms_authentication template" do
      get :sms_authentication
      expect(response).to render_template :sms_authentication
    end 
  end

  describe 'GET #address' do
    it "renders the :address template" do
      get :address
      expect(response).to render_template :address
    end
  end

  describe 'GET #card' do
    it "renders the :card template" do
      get :card
      expect(response).to render_template :card
    end
  end

end