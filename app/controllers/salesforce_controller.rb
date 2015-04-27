class SalesforceController < ApplicationController
  include SalesforceClient

  before_action :ensure_sign_in
  after_action :verify_authorized, :except => :reset_salesforce

  def reset_salesforce
    begin
      connect_salesforce
    rescue
      authorize current_user, :edit?
    else
      flash[:notice] = "Your Salesforce password is already up to date."
      redirect_to email_index_path
    end
  end

  def save_password
    begin
      connect_salesforce
    rescue
      authorize current_user, :edit?
      @password = params[:password][:password]
      @confirm_password = params[:confirm_password][:confirm_password]
      @security_token = params[:token][:token]
      if @password == @confirm_password
        ENV['SALESFORCE_PASSWORD'] = @password
        ENV['SALESFORCE_SECURITY_TOKEN'] = @security_token
        flash[:notice] = "Salesforce password successfully updated."
      end
    ensure
      redirect_to root_path
    end
  end
end
