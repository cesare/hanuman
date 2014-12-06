require 'rails_helper'

feature 'signing in with GitHub account', type: :feature do
  background do
    setup_omniauth provider: :github, uid: '1234', name: 'Test User'
  end

  scenario 'signs in and creates an account' do
    visit '/auth/github'
    expect(page.current_path).to eq root_path

    user = User.find_by(provider: 'github', uid: '1234')
    expect(user).to be_present
    expect(user.name).to eq 'Test User'

    person = user.person
    expect(person).to be_present
  end
end
