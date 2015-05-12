Feature: User
  #  @javascript
  Scenario: User tries to signup
    Given I am on the SNUCSE CMS landing page
    When I want to sign up, I fill in "mysnumail@snu.ac.kr", "password" with "password"
    Then I should be on the SNUCSE CMS main page

  #  @javascript
  Scenario: User tries to login
    Given I am on the SNUCSE CMS landing page
    When I want to log in, I fill in "mysnumail@snu.ac.kr" with "password"
    Then I should be on the SNUCSE CMS main page

  #  @javascript
  Scenario: User tries to logout
    Given I am on the SNUCSE CMS main page
    When I press "Logout" button
    Then I should go to SNUCSE CMS landing page

  #  @javascript
  Scenario: User tries to modify info
    Given I am on the SNUCSE CMS main page
    When I press "Edit" button
    Then I should be on the modify information page
    When I fill in "current password" and "new password" and "confirm new password"
    And I press "Modify"
    Then I should be on the SNUCSE CMS main page

  # @javascript
  Scenario: User tries to remove user
    Given I am on the SNUCSE CMS main page
    When I press "Edit" button
    Then I should be on the modify information page
    When I press "Remove account" link
    Then I should see "will you really want to remove account?" and "yes" and "no".
    And I press "Yes"
    Then I should be on SNUCSE CMS landing page
