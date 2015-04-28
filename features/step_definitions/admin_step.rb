And /I click the admin tab/ do
  click_link("Admin")
end

And /^(?:|I )fill in '(.+)' with "(.+)"$/ do |field, email|
  fill_in field, :with => email
end

And /^I click '\+' to add a new user$/ do
  click_button "+"
end

And /I click "X" to remove user "(.+)"$/ do |email|
  page.all('tbody tr').each do |row|
    within(row) do |entry|
      if find('td:nth-child(2)').text() == email
        click_button "X"
        click_button "Yes"
        click_button "OK"
      end
    end
  end
  click_button "Yes"
  click_button "OK"
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end