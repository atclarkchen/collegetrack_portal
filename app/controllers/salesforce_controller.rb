class SalesforceController < ApplicationController
  before_action :ensure_sign_in
  after_action :verify_authorized

  def reset_salesforce
    @client = SalesforceClient.first
    authorize @client, :reset?
  end

  def save_password
    @client = SalesforceClient.first
    authorize @client, :reset?
    @password = params[:password][:password]
    @confirm_password = params[:confirm_password][:confirm_password]
    @security_token = params[:token][:token]
    if @password == @confirm_password
      SalesforceClient.first.change_password(@password, @security_token)
      flash[:notice] = "Salesforce password successfully updated."
    end
    redirect_to root_path
  end
end
