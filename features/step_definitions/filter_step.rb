Given /^I see the filters: (.*)$/ do |filters|
  sleep 3
  step %{I add the filters: #{filters}}
end

Given /^I (?:|add|remove) the filters: (.*)$/ do |filters|
  filters = filters.split(",").reject { |f| f == "Student" }
  click_link('change filters')
  page.all('#accordian ul li h3').each do |category|
    category.click
    page.all('#accordian ul li ul li a').each do |link|
      if filters.include?(link.text)
        link.click
      end
    end
  end
  click_button("save_filter")
  sleep 3
end

Then /^(?:|I )click the x button on "(.*)"$/ do |filters|
  filters = filters.split(",")
  page.all('#filters .ui_fil').each do |filter|
    if filters.include?(filter.find('.left_fil').text)
      filter.find('.x').click
    end
  end
  sleep 3
end

Then /^the recipient fields should contain: (.*)$/ do |emails|
  emails = emails.split(", ")
  count = 0
  page.all('.filter_box').each do |elem|
    if emails.include?(elem.find('.left_fil').text)
      count = count + 1
    end
  end
  expect(count).to eq(emails.count)
end
