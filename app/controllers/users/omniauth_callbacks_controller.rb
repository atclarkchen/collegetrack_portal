class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if not @user.nil?
      #flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in @user, :event => :authentication
      @after_sign_in_url = email_index_path
      if sales_auth
        if request.env['omniauth.params']['popup']
          render 'callback', :layout => false
        else
          redirect_to @after_sign_in_url
        end
      else
        flash[:notice] = "Your salesforce account is invalid or not authorized. Please contact an admin."
        redirect_to root_path
      end
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      flash[:notice] = "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
      redirect_to root_path
    end
  end

  def sales_auth()
    begin
      client = Databasedotcom::Client.new("databasedotcom.yml")
      client.authenticate :username => "shinyenhuang@gmail.com", :password => "an1me3den9aQZyynyh0E5dJD7kRyYLUNHc"
      return true
    rescue
      return false
    end
  end
end