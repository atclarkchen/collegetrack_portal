And /the Salesforce password is outdated/ do
  ENV.stub(:[]).with("SALESFORCE_PASSWORD").and_return("outdated")
end

When /^(?:|I )try to login as "(.+)"$/ do |user_email|
  set_omniauth(user_email)
  @current_user = User.find_by_email(user_email)
  click_link("Sign in with Google")
end