Given /^I see the filters: (.*)$/ do |filters|
  step %{I add the filters: #{filters}}
end

Given /^I (?:|add|remove) the filters: (.*)$/ do |filters|
  options = { :Location => ["Oakland"], :Race => ["Asian", "Black", "White"], :Gender => ["Male", "Female"], :Year => ["2010", "2011", "2012"]}
  filters = filters.split(",")
  filters.each do |filter|
    if filter === "Oakland" || filter === "Student"
      next
    end
    page.all('#accordian ul li ul li a').each do |link|
      if link.text == filter
        click_link('change filters')
        find(:xpath, '..').find('h3').click
        link.click
        click_button("save_filter")
      end
    end
  end
end

Then /^(?:|I )click the x button on "(.*)"$/ do |filters|
  filters = filters.split(",")
  filters.each do |filter|
    page.all('.ui_fil').each do |elem|
      within(elem) do |el|
        if find('.left_fil').text == filter
          find('.x').click
        end
      end
    end
  end
end

Then /^the recipient fields should contain: (.*)$/ do |emails|
  within ('#email_fields_table') do
    emails.each do |email|
      expect(page).to have_content(email)
  end
end
