class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def index
    @filter_values = get_filter_values
  end
  
  def create_message
    # TODO: Remove empty email from all recipient fields
    # Create a draft message for the current user
    draft = current_user.create_draft message_params
    file_params['file'].each do |file|
      draft.attachments.create(file: file)
    end
    # if params[:send_msg]
    #   send_email params[:email]
    #   flash[:notice] = "Message sent successfully"
    # else
    #   save_draft params[:email]
    #   flash[:notice] = "Message saved in your Gmail Draftbox"
    # end

    redirect_to email_index_path
  end

  def delete_message
    flash[:notice] = "Message is deleted"
    redirect_to email_index_path
  end

  def email_list
    filters = params[:filters]
    render json: generate_email(filters).to_json
  end

  private

    def message_params
      params.require(:message).
        permit(:subject, :body, :to, :cc, :bcc)
    end

    def file_params
      params.permit(file: [])
    end
end