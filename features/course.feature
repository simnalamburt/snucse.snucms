Feature: Course Management

  #  @javascript
  Scenario: User tries to search and add "System Programing" in his/her course list
    Given I am on the SNUCSE CMS main page and logged in
    And I typed "s" in search box
    When I click "System Programing"
    Then I see "System Programing" in my course list

  #  @javascript
  Scenario: User tries to delete some course
    Given I am on the SNUCSE CMS main page and logged in
    And I already added course "시스템 프로그래밍"
    When I get point some course name
    Then I should be see trash can icon
    When I click trash can icon
    Then I should be see the course deleted in course list
    And alarm related to the course deleted.
