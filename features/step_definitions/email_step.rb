Then /^(?:|I )should see the following fields:(.*)$/ do |fields|
  trim_fields = fields.gsub(/,/, ' ')
  trim_fields.split.each do |name|
    field_id = "message_" + name
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
  email_table.rows_hash.each do |field|
    field_id = "email_" + field.first
    fill_in field_id, :with => field.second
  end
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

When /^I follow "(.*?)"$/ do |link|
  click_link link
end

Then /^all fields on the email page should be empty$/ do
  expect(find_field('message_to').value).to      be_blank
  expect(find_field('message_cc').value).to      be_blank
  expect(find_field('message_bcc').value).to     be_blank
  expect(find_field('message_subject').value).to be_blank
  expect(find_field('message_body').value).to    be_blank
end