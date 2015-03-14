module OmniAuthHelper
  def set_omniauth(user_email, opts = {})
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {
      :uid => "12345",
      :email => user_email,
      :password => "password"
    }) 
  end
end

World(OmniAuthHelper)
