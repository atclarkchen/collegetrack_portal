class EmailController < ApplicationController

  before_filter :ensure_sign_in

  def index
    @filter_values = SalesforceClient.first.get_filter_values
  end
  
  def send_message
    if params[:send_msg]
      send_email params[:message]
      flash[:notice] = "Message sent successfully"
    else
      save_draft params[:message]
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
    render json: SalesforceClient.first.generate_email(filters).to_json
  end
end