And /I click the admin tab/ do
  click_link("Admin")
end

And /^(?:|I )fill in '(.+)' with "(.+)"$/ do |field, user_name|
  fill_in field, :with => user_name
end

And /^I click '\+' to add a new user$/ do
  click_button "+"
end

And /I click "X" to remove user "(.+)"$/ do |user_name|
  page.all('tbody tr').each do |row|
    within(row) do |entry|
      if find('td:nth-child(1)').text() == user_name
        click_button "X"
      end
    end
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end