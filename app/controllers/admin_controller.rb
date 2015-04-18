class AdminController < ApplicationController
  before_action :ensure_sign_in
  after_action :verify_authorized

  def index
    authorize current_user, :edit?
    @users = policy_scope(User)
  end

  def new
    authorize current_user, :edit?
  	@user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end

  def destroy
    authorize current_user, :edit?
  	@user = User.find(params[:user])
  	@user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end
end
