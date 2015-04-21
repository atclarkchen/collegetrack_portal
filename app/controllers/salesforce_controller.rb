class SalesforceController < ApplicationController
  before_action :ensure_sign_in
  after_action :verify_authorized

  def reset_salesforce
    authorize current_user, :edit?
  end

  def save_password
    authorize current_user, :edit?
    @password = params[:password][:password]
    @confirm_password = params[:confirm_password][:confirm_password]
    @security_token = params[:token][:token]
    if @password == @confirm_password
      ENV['SALESFORCE_PASSWORD'] = @password
      ENV['SALESFORCE_SECURITY_TOKEN'] = @security_token
      flash[:notice] = "Salesforce password successfully updated."
    end
    redirect_to root_path
  end
end
