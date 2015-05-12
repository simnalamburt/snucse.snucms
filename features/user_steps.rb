Given /^I am on the SNUCSE CMS landing page$/ do
  visit '/'
end

When /^I want to sign up, I fill in "(.*)", "(\w+)" with "(\w+)"$/ do |email, pwd, pwdc|
  fill_in 'signup_email', with: email
  fill_in 'signup_password', with: pwd
  fill_in 'signup_password_confirmation', with: pwdc
  click_button 'signup_button'
end

Then /^I should be on the SNUCSE CMS main page$/ do
  assert page.has_content? 'Signed in successfully'
end

When /^I want to log in, I fill in "(.*)" with "(.*?)"$/ do |email, pwd|
  fill_in 'user_email', with: email
  fill_in 'user_password', with: pwd
  click_button 'login_button'
end

When /^I press "Logout" button$/
end
