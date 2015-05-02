require 'mail'

include Mail::Matchers

# Try mock up Mail sending
Mail.defaults do
  delivery_method :test
end

Then /^(?:|I )should see the following fields:(.*)$/ do |fields|
  trim_fields = fields.gsub(/,/, ' ')
  trim_fields.split.each do |name|
    field_id = "email_" + name
    expect(page).to have_field field_id
  end
end

Then /^(?:|I )should see the following links:(.*)$/ do |links|
  trim_links = links.gsub(/[,_]/, ' ')
  trim_links.split.each do |name|
    steps %Q{Then I should see "#{name}"}
  end
end

Then /^(?:|I )should see the following buttons:(.*)$/ do |buttons|
  trim_buttons = buttons.gsub(/[,_]/, ' ')
  trim_buttons.split.each do |name|
    expect(page).to have_button name
  end
end

And /^I compose the following email:$/ do |email_table|
  @mail = Mail.new(email_table.rows_hash)
  @mail.from = @current_user.email
end

When /^I press "(.*?)"$/ do |button|
  if button != "Send"
    click_button button
  else
    Mail::TestMailer.deliveries.clear
    @mail.deliver
  end
end

When /^I follow "(.*?)"$/ do |link|
  click_link link
end

Then /^all fields on the email page should be empty$/ do
  sleep 5
  expect(page.find('#email_to').value).to      be_blank
  expect(page.find('#email_cc').value).to      be_blank
  expect(page.find('#email_bcc').value).to     be_blank
  expect(page.find('#email_subject').value).to be_blank
  expect(page.find('#email_body').value).to    be_blank
end