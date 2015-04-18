Given /^(?:|I )am on login page/ do
	visit path_to(root_path)
end

And /the Salesforce password is outdated/ do
   SalesforceClient.create! :password => "asdf", :security_token => "asdf"
end

When(/^I try to login as "(.*?)"$/) do |user_email	|
	set_omniauth(user_email)
    @current_user = User.find_by_email(user_email)
	click_link("Sign in with Google")
end