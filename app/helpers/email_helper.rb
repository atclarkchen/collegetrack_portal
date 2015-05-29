module EmailHelper
  
  def ensure_sign_in
    if current_user.blank?
      redirect_to root_path
    end
  end

end