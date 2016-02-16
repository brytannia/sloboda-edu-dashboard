require 'spec_helper'

describe UsersController, 'creating a new user' do
  render_views
  fixtures :users

  it 'should create a new user' do
    User.any_instance.stub(:valid?).returns(true)
    post 'create'
    response.should redirect_to(root_path)
  end
end
