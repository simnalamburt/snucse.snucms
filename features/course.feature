Feature: Course Management
  @javascript
  Scenario: User tries to search "시프"
    Given I am on the SNUCSE CMS main page and logged in
    And I clicked search box
    When I type "시프"
    Then I should see "시스템 프로그래밍" below search box

  @javascript
  Scenario: User tries to add "시스템 프로그래밍" in his/her course list
    Given I am on the SNUCSE CMS main page and logged in
    And I typed "시프" in search box
    And I see "시스템 프로그래밍" in search result list
    When I click "시스템 프로그래밍"
    Then I see "시스템 프로그래밍" in my course list

  @javascript
  Scenario: User tries to delete some course
    Given I am on the SNUCSE CMS main page and logged in
    And I already added course "시스템 프로그래밍"
    When I get point some course name
    Then I should be see trash can icon
    When I click trash can icon
    Then I should be see the course deleted in course list
    And alarm related to the course deleted.
