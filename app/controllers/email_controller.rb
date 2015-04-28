class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  # TODO: Rather than asking user, if the user has a draft,
  #       just render the page with the contents of draft

  def index
    # TODO: Ask user if he/she wants to continue on existing draft
    # TODO: Use AJAX with JSON to update _email_form rather than render whole page
    if current_user.draft.presence # && user wants to continue on existing draft
      # redirect_to edit_email_path
    end

    # otherwise always redirect to /email/new
    redirect_to new_email_path
  end

  def new
    # TODO: need to DRY out
    @filter_values = get_filter_values
    @full_name = current_user['name']
    @user_email = current_user['email']
  end

  def edit
    # TODO: need to DRY out
    @filter_values = get_filter_values
    @full_name = current_user['name']
    @user_email = current_user['email']
  end

  def update
    # update draft message of the current user
    # This will be called only if user press 'Draft'
    # after modifying the PREVIOUS draft
  end

  def create
    draft = current_user.create_draft(message_params)
    draft.add_attachments = files_params
    flash[:notice] = "Draft message saved successfully"

    if params[:send_msg]
      send_draft(draft)
      flash[:notice] = "Message sent successfully"
    end
  end

  def send_draft(draft)
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
    # draft.attachments.each do |attachment|
    #   message.add_file load_from_s3(attachment)
    # end

    # deliver and close the current session
    message.deliver!
    gmail.logout
  end

  def destroy
    flash[:notice] = "Message is deleted"
    redirect_to new_email_path
  end

  def email_list
    filters = params[:filters]
    render json: generate_email(filters).to_json
  end

  # def load_from_s3(attachment)
  #   {
  #     filename: attachment.file_file_name,
  #     content: open(attachment.file.url).read
  #   }
  # end

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
        message[key] = val.compact.reject(&:empty?).join(", ") if val.class == Array
      end
    end
end