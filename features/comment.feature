Feature: comment management
  #  @javascript
  Scenario: user write comment
    Given I see specific schedule modal
    When I fill textbox and click comment button
    Then comment will be appear

  Scenario: user delete comment
    Given I see specific schedule modal
    And I see my comment
    When I click x button
    Then comment will be disappear
