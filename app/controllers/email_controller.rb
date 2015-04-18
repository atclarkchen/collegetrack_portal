class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
    @filter_values = SalesforceClient.first.get_filter_values
  end
  
  #TODO: Add method 'new', and ask user for new or edit draft

  def create_message
    # build and compose draft message for current user
    draft = current_user.create_draft
    draft.compose_draft(email_params)
    flash[:notice] = "Draft message saved successfully"

    if params[:send_msg]
      deliver_message(draft)
      flash[:notice] = "Message sent successfully"
    end

    redirect_to email_index_path
  end

  def delete_message
    flash[:notice] = "Message is deleted"
    redirect_to email_index_path
  end

  def email_list
    filters = params[:filters]
    render json: SalesforceClient.first.generate_email(filters).to_json
  end

  def deliver_message(draft)
    gmail = Gmail.connect(:xoauth2, current_user.email, current_user.token.fresh_token)
    message = gmail.compose do
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
      message.add_file load_from_s3(attachment)
    end

    # deliver and close the current session
    message.deliver!
    gmail.logout
  end

  def load_from_s3(attachment)
    {
      filename: attachment.file_file_name,
      content: open(attachment.file.url).read
    }
  end

  private

    def email_params
      params.require(:email).
        permit(:subject, :body, to: [], cc: [], bcc: [], files: [])
    end

end