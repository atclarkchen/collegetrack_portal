require 'Gmail'

class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def new
    # TODO: need to DRY out
    @filter_values = get_filter_values
  end

  def create
    draft = current_user.create_draft(message_params)
    draft.add_attachments = files_params

    send_draft(draft)
    flash[:notice] = "Message sent successfully"

    render json: { success: true, status: 'redirect', to: new_email_url }.to_json
  end

  def send_draft(draft)
    Gmail.client_id = ENV['GOOGLE_ID']
    Gmail.client_secret = ENV['GOOGLE_SECRET']
    Gmail.refresh_token = current_user.token.refresh_token

    message = Mail.new do
      to   draft.to
      cc   draft.cc
      bcc  draft.bcc

      subject draft.subject
      html_part do
        content_type "text/html; charset=UTF-8"
        body  draft.body
      end
    end

    # add attachments to message from S3
    draft.attachments.each do |attachment|
      message.add_file attachment.read_from_s3
    end

    # Mail object does not set X-Bcc header
    # Also need to substitue regular bcc to X-Bcc
    message.header["X-Bcc"] = draft.bcc
    raw = Base64.urlsafe_encode64 message.to_s.sub("X-Bcc", "Bcc")

    gmail = Gmail::Message.new(raw: raw)
    gmail.create_draft
  end

  def delete
    flash[:notice] = "Message is deleted"
    current_user.delete_draft
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

    def files_params
      files = params.require(:email).fetch(:files, {}).try(:permit!)
      files.values
    end

    def strong_params
      params.require(:email).
             permit(:subject, :body, to: [], cc: [], bcc: [])
    end

    def message_params
      message = strong_params
      message.each do |key, val|
        message[key] = val.compact.reject(&:empty?).join(', ') if val.class == Array
      end
    end
end