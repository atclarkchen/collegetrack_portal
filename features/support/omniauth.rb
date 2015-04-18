module OmniAuthHelper
  def set_omniauth(user_email, opts = {})
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {
      :uid  => "12345",
      :info => {:email => user_email},
      :credentials => {
        token: "access_token_for_test",
        refresh_token: nil,
        expires_at: Time.now + 3600 # An hour after from now
      }
    }) 
  end
end

World(OmniAuthHelper)
