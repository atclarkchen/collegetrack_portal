class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def index
    @filter_values = get_filter_values
  end
  
  def create_message
    # Create and compose draft message for current user
    draft = current_user.create_draft
    draft.save_draft(email_params)
    flash[:notice] = "Draft message saved successfully"

    if params[:send_msg]
      draft.deliver_message
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
    render json: generate_email(filters).to_json
  end

  private

    def email_params
      params.require(:email).
        permit(:subject, :body, :to, :cc, :bcc, file: [])
    end

end