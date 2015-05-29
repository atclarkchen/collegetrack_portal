class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one  :token, dependent: :destroy
  has_many :attachments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    @user = User.where("email=?", data["email"]).first
    @user
  end

  def admin?
    self.role == 'Admin'
  end

  def set_user_name(name)
    self.update_attributes(:name => name.titleize) unless @user == name
  end

  def self.selectize
    select(:email, :name).as_json.map{|r| r.select{|k,v| k != "id"}}
  end

  def set_token(param)
    if self.token.present?
      self.token.update_attributes(param)
    else
      self.create_token(param)
    end
  end

  def refresh_token
    token.refresh_token
  end

end