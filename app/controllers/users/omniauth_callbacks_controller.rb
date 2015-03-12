class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        #flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in @user, :event => :authentication
        redirect_to email_index_path
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        flash[:notice] = "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
        redirect_to root_path
      end
  end
end