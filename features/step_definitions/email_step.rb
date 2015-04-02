Given /^I see the filters: (.*)$/ do |filters|
  visit '/email/index'
  step %{I add the filters: #{filters}}
end

Given /^I (?:|add|remove) the filters: (.*)$/ do |filters|
  filters = filters.split(",")
  filters.each do |filter|
    click_link(filter)
  end
  click_button("save_filter")
end

Then /^the recipient fields should contain: (.*)$/ do |emails|
  emails = emails.split(" ")
  puts find_field("email_bcc")
  expect(page).to have_field('email_bcc', with: emails.join(", "))
end
