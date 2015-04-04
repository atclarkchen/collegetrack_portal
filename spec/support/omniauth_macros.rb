module OmniauthMacros
 
  def google_hash
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {
      :uid => "12345",
      :info => {
        :email => "fake@gmail.com"
      },
      :credentials => {
        :token => "token",
        :secret => "secret",
        :expires_at => Time.now + 1.week
      }
    })
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    request.env['omniauth.params'] = request.params
  end
end