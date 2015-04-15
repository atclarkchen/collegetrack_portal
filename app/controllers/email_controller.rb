class EmailController < ApplicationController

  before_filter :ensure_sign_in
  include SalesforceClient

  def index
    @filter_values = get_filter_values
  end
  
  def send_message
    if params[:send_msg]
      send_email params[:email]
      flash[:notice] = "Message sent successfully"
    else
      save_draft params[:email]
      flash[:notice] = "Message saved in your Gmail Draftbox"
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
end