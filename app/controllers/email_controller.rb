class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

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

    @email = Draft.new
  end

  def edit
    # TODO: need to DRY out
    @filter_values = get_filter_values
    @full_name = current_user['name']
    @user_email = current_user['email']

    @draft = current_user.draft
  end

  def update
    # update draft message of the current user
    # This will be called only if user press 'Draft'
    # after modifying the PREVIOUS draft
  end

  def create
    # build and compose draft message for current user
    debugger
    draft = current_user.create_draft
    draft.compose_draft(string_params)
    flash[:notice] = "Draft message saved successfully"

    if params[:send_msg]
      deliver_message(draft)
      flash[:notice] = "Message sent successfully"
    end

    redirect_to email_index_path
  end

  def destroy
    flash[:notice] = "Message is deleted"
    redirect_to new_email_path
  end

  def email_list
    filters = params[:filters]
    render json: generate_email(filters).to_json
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

    def file_params
      files = params.require(:email).fetch(:files, nil).try(:permit!)

    end

    def email_params
      params.require(:email).permit(:subject, :body, to: [], cc: [], bcc: []).
                            merge(file_params)
      # params.require(:email).
      #        permit(:subject, :body, to: [], cc: [], bcc: []).
      #        merge(params.require(:email).permit!(:files))
    end

    def string_params
      email = email_params
      email.each do |key, val|
        if val.class == Array
          email[key] = val.compact.reject(&:empty?).join(", ")
        end
      end
    end
end