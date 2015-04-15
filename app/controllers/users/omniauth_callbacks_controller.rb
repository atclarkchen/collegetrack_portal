class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    @auth = request.env["omniauth.auth"]['credentials']

    if @user
      sign_in @user, :event => :authentication
      set_access_token
      if sales_auth
        popup(email_index_path)
      else
        flash[:notice] = "Your Salesforce password is outdated or incorrect. Please fix this and try again."
        redirect_to reset_salesforce_path
      end
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:notice] = "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
      popup(root_path)
    end
  end

  def sales_auth
    begin
      client = Restforce.new :host => "test.salesforce.com"
      client.authenticate!
      return true
    rescue
      return false
    end
  end

  def failure
    popup(root_path)
  end

  def popup(path)
    @after_sign_in_url = path
    if request.env['omniauth.params']['popup']
      render 'callback', :layout => false
    else
      redirect_to @after_sign_in_url
    end
  end

  def set_access_token
    @user.create_token(
      access_token:   @auth['token'],
      refresh_token:  @auth['refresh_token'],
      expires_at:     Time.at(@auth['expires_at']).to_datetime)
  end

end