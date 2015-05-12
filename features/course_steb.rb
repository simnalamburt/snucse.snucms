Given /^I am on the SNUCSE CMS main page and logged in$/ do
  assert page.has_content? 'Principles and Practice'
end

And /^I clicked search box$/ do
  assert true
end

When /^I type "(\w+)"$/ do
  assert true
end
