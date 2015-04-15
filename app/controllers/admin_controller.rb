class AdminController < ApplicationController
  def index
    @users = User.all
  end

  def new
  	@user = User.new(:name => params[:user][:name], :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end

  def destroy
  	@user = User.find(params[:user])
  	@user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to admin_path }
      format.js { render 'render_table.js.haml'} 
    end
  end
end