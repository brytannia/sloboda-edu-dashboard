# require 'rails_helper'
require 'spec_helper'

describe 'user registration' do
  it 'allows new users to register with an email address and password' do
    visit '/users/sign_up'

    fill_in 'First name',            with: Faker::Name.first_name
    fill_in 'Last name',             with: Faker::Name.last_name
    fill_in 'Email',                 with: Faker::Internet.email
    fill_in 'Password',              with: '12121212'
    fill_in 'Password confirmation', with: '12121212'

    click_button 'Sign up'

    expect(subject).to redirect_to root_path
  end
end
