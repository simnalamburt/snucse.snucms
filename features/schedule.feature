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

  Scenario: delete schedule
    Given I am on SNUCMS main page and see calendar
    When I click x button on calendar
    Then schedule should be deleted

  Scenario: try to edit schedule
    Given I am on SNUCMS main page and see calendar
    When I click schedule and click edit button
    Then edit modal will be appear

  Scenario: edit schedule
    Given I see schedule edit modal
    When I fill boxes in modal and click save button
    Then schedule will be shown in calandar

