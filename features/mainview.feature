Feature: Mainpage view
  #  @javascript
  Scenario: User tries to view calendar
    Given I am on the SNUCMS main page and see timeline
    When I click calendar_button
    Then I should see calendar

  #  @javascript
  Scenario: User tries to view timeline
    Given I am on the SNUCMS main page and see calendar
    When I click timeline_button
    Then I should see timeline
