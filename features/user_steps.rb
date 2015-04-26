Given /^I am on the SNUCSE CMS landing page$/ do
  visit '/'
end

When /^I want to sign up, I fill in "(.*)", "(\w+)" with "(\w+)"$/ do |email, pwd, pwdc|
  fill_in 'user_email', with: email
  fill_in 'user_password', with: pwd
  fill_in 'user_password_confirmation', with: pwdc
  send_form 'new_user'
end

Then /^I should be on the SNUCSE CMS main page$/ do
  assert page.has_content? 'Principle and Practice'
end

When /^I want to log in, I fill in "(.*)" with "(.*?)"$/ do |email, pwd|
  fill_in 'user_email', with: email
  fill_in 'user_password', with: pwd
  # send_form 'new_user'
end
