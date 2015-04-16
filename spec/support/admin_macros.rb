module AdminMacros
 
  def login_user
    request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user
  end

  def login_admin
    request.env["devise.mapping"] = Devise.mappings[:admin]
    admin = FactoryGirl.create(:user, role: "Admin")
    sign_in admin
  end
end