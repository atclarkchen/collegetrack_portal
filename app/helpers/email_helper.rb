module EmailHelper

  def ensure_sign_in
    if current_user.blank?
      redirect_to root_path
    end
  end

  def send_email(email)
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

        # add_file email[:attachment]
      end
    end
  end

  def save_draft(email)
    # Create Mail object with form data
    # Create Draft model with mail.to_s
    # Add attachment(s) to the current Draft model

    Gmail.connect(:xoauth2, current_user.email, current_user.token.fresh_token) do |gmail|
      draft = gmail.compose do
        to  email[:to]
        cc  email[:cc]
        bcc email[:bcc]
        subject email[:subject]

        html_part do
          content_type 'text/html; charset=UTF-8'
          body email[:body]
        end
        # add_file email[:attachment]
      end
      debugger
      true
    end
  end

end