class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_one :token, dependent: :destroy
  has_one :draft, dependent: :destroy
  has_many :attachments, through: :draft

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    @user = User.where(:email => data["email"]).first
    @user
  end

  def admin?
    self.role == 'Admin'
  end

  def generate_draft(email_params)
    # Return list of files
    files = email_params.delete(:file)
    self.create_draft email_params
    self.draft.add_attachments files
  end
end