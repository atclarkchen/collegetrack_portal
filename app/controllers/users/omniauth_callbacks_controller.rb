class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  include SalesforceClient

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    @auth = request.env["omniauth.auth"]['credentials']
    warn_with_redirect and return unless @user
    sign_in @user, :event => :authentication
    set_access_token
    check_auth_or_redirect
  end

  def check_auth_or_redirect
    if sales_auth
      flash[:notice] = "Authenticated successfully."
      popup(email_index_path)
    else
      flash[:error] = "Your Salesforce account is invalid or outdated. Please update your password or contact an admin."
      redirect_to reset_salesforce_path
    end
  end

  def warn_with_redirect
    session["devise.google_data"] = request.env["omniauth.auth"]
    flash[:error] = "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
    popup(root_path)
  end

  def sales_auth
    begin
      connect_salesforce
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