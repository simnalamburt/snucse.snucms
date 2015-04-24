Feature: User
  @javascript
  Scenario: User tries to signup
    Given I am on the SNUCSE CMS landing page
    When I want to sign up, I fill in "SnuEmail" with "mysnumail@snu.ac.kr"
    And I fill in "password" with "MyPassword"
    And I fill in "password confirm" with "MyPassword"
    And I press "Sign up"
    Then I should be on the SNUCSE CMS landing page
    And I should see "환영합니다! 등록하신 스누메일로 인증 메일이 전송되었습니다. 확인해 주세요."

  @javascript
  Scenario: User tries to login
    Given I am on the SNUCSE CMS landing page
    When I want to log in, I fill in "SNU Email" with "mysnumail@snu.ac.kr"
    And I fill in "password" with "MyPassword"
    And I press "Login"
    Then I should go to SNUCSE CMS main page.

  @javascript
  Scenario: User tries to logout
    Given I am on the SNUCSE CMS main page and logged in
    When I follow "Modify info" button
    Then I should be on the modify information page
    When I fill in "current password" with "MyPassword"
    And I fill in "new password" with "MyNewPassword"
    And I fill in "confirm new password" with "MyNewPassword"
    And I press "Modify"
    Then I should be on SNUCSE CMS main page

  @javascript
  Scenario: User tries to modify info
    Given I am on the SNUCSE CMS main page and logged in
    When I follow "Modify info" button
    Then I should be on the modify information page
    When I fill in "current password" with "MyPassword"
    And I fill in "new password" with "MyNewPassword"
    And I fill in "confirm new password" with "MyNewPassword"
    And I press "Modify"
    Then I should be on SNUCSE CMS main page

  @javascript
  Scenario: User tries to remove user
    Given I am on the SNUCSE CMS main page and logged in
    When I follow "Modify info" button
    Then I should be on the modify information page
    When I press "Remove account" link
    Then I should see "will you really want to remove account?" and "yes" and "no".
    And I press "Yes"
    Then account will be deleted
    And I should be on SNUCSE CMS landing page
