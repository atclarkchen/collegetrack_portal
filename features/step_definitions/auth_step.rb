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

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /the following users exist/ do |user_table|
  user_table.hashes.each do |user|
    User.create(user)
  end
end

Given /^(?:|I )am an (un)?authorized user$/ do |authorized|
	if authorized

	end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

When /^(?:|I )try to login as "(.+)"$/ do |user_email|
	set_omniauth(user_email)
	click_link("Sign in with Google")
  if User.find_by_email(user_email).nil?
    steps %Q{Then I should be rejected}
  else
    visit email_index_path
  end
end

Then /I should be rejected/ do
	steps %Q{
    Then I should be on the login page
    And I should see "authorized"
  }
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end