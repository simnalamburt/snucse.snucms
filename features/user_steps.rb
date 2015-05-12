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
  page.should have_selector?("a[herf='/users/edit']")
end

When /^I want to log in, I fill in "(.*)" with "(.*?)"$/ do |email, pwd|
  fill_in 'user_email', with: email
  fill_in 'user_password', with: pwd
  click_button 'login_button'
end

Given /^I am on the SNUCSE CMS main page$/ do
  visit '/'
  #  assert_select 'a', :text => '/users/edit'
end

When /^I press "Logout" button$/ do
  click_button 'logout_button'
end

Then /^I should go to SNUCSE CMS landing page$/ do
  assert page.has_content?('login')#고치기
end

When /^I press "Edit" button$/ do
  click_button 'edit_button'
end

Then /^I should be on the modify information page$/ do
  visit '/users/edit'
end

When /^I fill in "(\w+)" and "(\w+)" and "(\w+)"$/ do |curpwd, newpwd, newpwdc|
  fill_in 'user_current_password', with: curpwd
  fill_in 'user_password', with: newpwd
  fill_in 'user_password_confirmation', with: newpwdc
end

And /^I press "Modify"$/ do
  click_button 'update_button'
end

When /^I press "Remove account" link$/ do
  click_link 'delete_account_link'
end

Then /^I should see "will you really want to remove account" and "yes" and "no".$/ do
  assert page.has_content?(gcg)
end

And /^I press "Yes"$/ do
  assert page.has_content?(gcg)
end



