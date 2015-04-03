require 'gmail'

class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
  end

  def send_message
    email = params[:email]
    Gmail.connect(:xoauth2, current_user.email, current_user.token.fresh_token) do |gmail|
      gmail.deliver do
        to  email[:to]
        cc  email[:cc]
        bcc email[:bcc]

        subject email[:subject]
        html_part do
          content_type 'text/html; charset=UTF-8'
          body email[:body]
        end
      end
    end

    flash[:notice] = "Message sent successfully"
    redirect_to email_index_path
  end

end