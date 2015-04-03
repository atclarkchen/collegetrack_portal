Then /^(?:|I )should see the following fields:(.*)$/ do |fields|
  trim_fields = fields.gsub(/,/, ' ')
  trim_fields.split.each do |name|
    field_id = "email_" + name
    expect(page).to have_field field_id
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