require 'spec_helper'

feature 'User signs up' do
  before :each do
    @user = attributes_for(:user)
  end

  scenario 'with valid data' do
    before_count = User.count
    sign_up_with @user
    expect(User.count).not_to eq(before_count)
    expect(URI.parse(current_url).path).to eq root_path
  end

  def sign_up_with(params)
    visit new_user_registration_path
    fill_in 'First name', with: params[:first_name]
    fill_in 'Last name', with: params[:last_name]
    fill_in 'Email', with: params[:email]
    fill_in 'Password', with: params[:password]
    fill_in 'Password confirmation', with: params[:password]
    click_button 'Sign up'
  end
end

feature 'User logs in and visit pages' do
  before :each do
    @user = attributes_for(:user)
    create @user
  end

  scenario 'with valid email and password' do
    log_in_with @user[:email], @user[:password]

    expect(URI.parse(current_url).path).to eq root_path

    visit user_path(id: @user[:id])
    expect(URI.parse(current_url).path).to eq user_path(id: @user[:id])
  end

  def create(params)
    User.create(params).save
  end
end

feature 'Admin logs in and visit admin panel' do
  before :each do
    @admin = attributes_for(:user, :admin)
    create @admin
  end

  scenario 'with valid email and password' do
    log_in_with @admin[:email], @admin[:password]

    expect(URI.parse(current_url).path).to eq root_path

    visit admin_root_path
    expect(URI.parse(current_url).path).to eq admin_root_path
  end

  def create(params)
    User.create(params).save
  end
end

feature 'User without access' do
  scenario 'visit root path' do
    visit root_path
    expect(URI.parse(current_url).path).to eq new_user_session_path
  end

  scenario 'visit admin' do
    visit admin_root_path
    expect(URI.parse(current_url).path).to eq new_user_session_path
  end
end

def log_in_with(email, password)
  visit user_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end
