module OmniAuthHelper
  def set_omniauth(user_email, opts = {})
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, {
      :uid => "12345",
      :info => {
        :email => user_email,
      }
    }) 
  end

end

World(OmniAuthHelper)
