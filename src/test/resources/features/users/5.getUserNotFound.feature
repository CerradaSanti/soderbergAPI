Feature: Validate behavior for non-existent user

  Background:
    * url 'https://reqres.in/api/users'

  Scenario: Validate response when a user does not exist
    Given path 'users/23'
    When method GET
    Then status 404
    And match response == {}

  Scenario: Validate response with invalid ID
    Given path 'users/65476uherthgff'
    When method GET
    Then status 404
    And match response == {}