require 'spec_helper'

describe 'users controller' do
  it 'allow sign up and see the main page' do
    post user_registration_path, user: attributes_for(:user)
    expect(response).to redirect_to root_url
  end
end
