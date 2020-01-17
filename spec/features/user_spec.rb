require 'rails_helper'

feature "login" do
  scenario "Google認証できること" do
    visit new_user_session_path
    click_link "googleでログイン"
    sleep 1
    expect(current_path).to eq new_user_registration_path
  end
  scenario "Facebook認証できること" do
    visit new_user_session_path
    click_link "facebookでログイン"
    sleep 1
    expect(current_path).to eq new_user_registration_path
  end
end