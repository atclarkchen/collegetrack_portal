class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def index
    @filter_values = get_filter_values
  end
  
  #TODO: Add method 'new', and ask user for new or edit draft

  def create_message
    # build and compose draft message for current user
    draft = current_user.build_draft
    draft.compose_draft(email_params)

    if params[:send_msg]
      # draft.deliver_message
      # flash[:notice] = "Message sent successfully"
    elsif params[:draft_msg]
      # save draft for the current user
      draft.save
      debugger
      flash[:notice] = "Draft message saved successfully"
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
        permit(:subject, :body, to: [], cc: [], bcc: [], files: [])
    end

end