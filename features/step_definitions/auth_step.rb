require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )am logged into as "(.+)"$/ do |user_email|
  steps %Q{
    When I try to login as "#{user_email}"
  }
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create(user)
  end
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  expect(page).to have_content(text)
end

When /^(?:|I )try to login as "(.+)"$/ do |user_email|
	set_omniauth(user_email)
  @current_user = User.find_by_email(user_email)
	click_link("Sign in with Google")
end

Then /I should be rejected/ do
	steps %Q{
    Then I should be on the login page
  }
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  expect(current_path).to eq path_to(page_name)
end