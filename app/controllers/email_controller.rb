require 'Gmail'

class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def new
    # Set filter values for _filter partial
    @filter_values = get_filter_values
  end

  def create
    # Create message with Mail object
    @message = Mail.new(msg_header)
    @message.html_part = msg_body
    @message.header["X-Bcc"] = @message.bcc

    # add attachments to message from file system
    current_user.add_attachments = files_param
    current_user.attachments.each do |attachment|
      @message.add_file attachment.path
    end

    # Clean up the current attachments
    current_user.clean_up_files

    email_handler
  end

  def email_handler
    if params['user_action'] == "Send"
      flash[:notice] = "Message sent successfully"
      begin
        gmail_encoded.deliver
      rescue
        true
      end
    else
      flash[:notice] = "Draft saved in Gmail account"
      gmail_encoded.create_draft
    end

    render json: { success: true, status: 'redirect', to: new_email_url }.to_json
  end

  def delete
    flash[:notice] = "Message has been deleted"
    redirect_to new_email_path
  end

  def email_list
    filters = params[:filters]
    render json: generate_email(filters).to_json
  end

  def user_list
    user_list = User.selectize
    render json: user_list
  end

  private

    def files_param
      params.require(:email).fetch(:files, {}).try(:permit!).values
    end

    def msg_header
      params[:email].select { |k,v| /to|cc|bcc|subject/ === k }
    end

    def msg_body
      content = params[:email][:body]
      Mail::Part.new do
        content_type 'text/html; charset=UTF-8'
        body content
      end
    end

    def gmail_encoded
      # Setup Gmail client
      Gmail.client_id = ENV['GOOGLE_ID']
      Gmail.client_secret = ENV['GOOGLE_SECRET']
      Gmail.refresh_token = current_user.refresh_token

      # Encode the Mail object into Gmail raw message
      raw = Base64.urlsafe_encode64 @message.to_s.sub("X-Bcc", "bcc")
      Gmail::Message.new(raw: raw)
    end

end