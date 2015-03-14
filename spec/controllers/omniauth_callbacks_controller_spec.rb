require 'spec_helper'

describe OmniauthCallbacksController do

  describe 'google_oauth2' do
    @user = double('fake user', :email => 'fake@email.com')
    User.should_receive(:find_for_google_oauth2).with()
  end

  describe 'sales_oauth' do

  end

end