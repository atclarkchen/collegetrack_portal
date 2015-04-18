Given /^I see the filters: (.*)$/ do |filters|
  step %{I add the filters: #{filters}}
end

Given /^I (?:|add|remove) the filters: (.*)$/ do |filters|
  filters = filters.split(",")
  filters.each do |filter|
    if filter === "Oakland" || filter === "Student"
      next
    end
    sleep 10
    click_link('change filters')
    page.all('#accordian ul li ul li h3').each do |category|
      puts category.text
      if category.text == filter
        category.click
        find(:xpath, '..').find('a').click
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
  emails = emails.split(", ")
  page.all('.filter_box').each do |elem|
    emails.each do |email|
      if elem.find('.left_fil').text == email
        emails.delete(email)
      end
    end
  end
  expect(emails.count).to eq(0)
end
