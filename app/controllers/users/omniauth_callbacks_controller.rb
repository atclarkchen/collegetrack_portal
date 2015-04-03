class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    @auth = request.env["omniauth.auth"]['credentials']

    if @user
      sign_in @user, :event => :authentication
      if @user.token.blank?
        set_access_token
      else
        update_access_token
      end

      if sales_auth
        popup(email_index_path)
      else
        flash[:notice] = "Your salesforce account is invalid or not authorized. Please contact an admin."
        redirect_to root_path
      end
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:notice] = "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
      popup(root_path)
    end
  end

  def sales_auth
    begin
      client = Databasedotcom::Client.new
      client.authenticate :username => "shinyenhuang@gmail.com", :password => "an1me3den9aQZyynyh0E5dJD7kRyYLUNHc"
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

  def update_access_token
    @user.token.update_attributes(
      access_token:   @auth['token'],
      refresh_token:  @auth['refresh_token'],
      expires_at:     Time.at(@auth['expires_at']).to_datetime)
  end

end