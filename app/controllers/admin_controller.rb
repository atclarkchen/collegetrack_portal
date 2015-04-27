class AdminController < ApplicationController
  before_action :ensure_sign_in
  after_action :verify_authorized

  def index
    authorize current_user, :edit?
    @users = policy_scope(User).sort { |a, b| 
      if a[:name] == ""
        1
      elsif b[:name] == ""
        -1
      else
        a[:name] <=> b[:name]
      end
    }
    @full_name = current_user['name']
    @user_email = current_user['email']
  end

  def new
    authorize current_user, :edit?
  	@user = User.new(:name => '', :email => params[:user][:email], :role => params[:user][:role], :password => 'password')
  	@user.save!
    @users = User.all
    render "_user_table.html.haml", layout: false
  end

  def destroy
    authorize current_user, :edit?
  	@user = User.find_by_email(params[:email])
  	@user.destroy
    @users = User.all
    render "_user_table.html.haml", layout: false
  end
end
