class AdminController < ApplicationController
  def index
    @users = User.all
  end

  def new
  	@user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
  	redirect_to admin_path
  end

  def destroy
  	@user = User.find(params[:user])
  	@user.destroy
  	redirect_to admin_path
  end
end