Feature: Schedule management
  # @javascript
  Scenario: add schedule
    Given I am on SNUCMS main page and see calendar
    When I click empty space in specific date and fill course, schedule type, name, content
    And I click add button
    Then I should see added schedule in calendar

  Scenario: view schedule
    Given I am on SNUCMS main page and see calendar
    When I click schedule
    Then I should see modal about schedule
