Feature: Create a user test

  Background:
    * url 'https://reqres.in/api/users'

  Scenario: Create a user with a valid name and job
    Given request { "name": "John", "job": "developer" }
    When method POST
    Then status 201
    And match response.name == 'John'
    And match response.job == 'developer'
#Create an user without name (API ALLOWS IT)
  Scenario: Create an user without name (API ALLOWS IT)
    Given request { "job": "developer" }
    When method POST
    Then status 201
#    And match response.error == 'Missing name'
#  Create a user without name (API ALLOWS IT)
  Scenario: Create a user without name (API ALLOWS IT)
    Given request { "name": "John" }
    When method POST
    Then status 201
#    And match response.error == 'Missing job'

  Scenario: Create a user with empty request (API ALLOWS IT)
    Given request {}
    When method POST
    Then status 201
