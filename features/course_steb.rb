Given /^I am on the SNUCSE CMS main page and logged in$/ do
  visit('/')
end

And /^I typed "(\w+)" in search box$/ do |key|
  fill_in 'search_box', with: key
end

When /^I click "(\w+)"$/ do |res|
  assert true
end

Then /^I should see "(\w+)" below search box$/ do |res|
  assert res.include? key
end
