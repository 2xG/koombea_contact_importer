require 'rails_helper'

RSpec.feature 'Sign up new user' do

  scenario 'A user enters homepage for the first time' do
    skip 'segmentation fault issue'
    visit '/'

    expect(page).to have_content("Sign-Up")
  end
end