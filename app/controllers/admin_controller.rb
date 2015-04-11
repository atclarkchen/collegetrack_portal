class AdminController < ApplicationController
  def index
    authorize current_user, :edit_users?
    @users = policy_scope(User)
  end

  def new
    authorize current_user, :edit_users?
  	@user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
  	redirect_to admin_path
  end

  def destroy
    authorize current_user, :edit_users?
  	@user = User.find(params[:user])
  	@user.destroy
  	redirect_to admin_path
  end
end
