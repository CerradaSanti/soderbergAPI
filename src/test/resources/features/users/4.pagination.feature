Feature: Validate pagination handling and the integrity of data across page

  Background:
    * url 'https://reqres.in/api/'

  Scenario: Validate pagination on page 2
    Given path 'users?page=2'
    When method GET
    Then status 200
    And match response.page == 2
    And match response.per_page == 6
    And match response.total_pages == 2
    And match response.data == '#[6]'


  Scenario: Validate that users on page 1 and 2 are unique
    Given path 'users?page=1'
    When method GET
    Then def page1Users = response.data

    Given path 'users?page=2'
    When method GET
    Then def page2Users = response.data

    * assert !karate.match(page1Users, page2Users).pass

  Scenario: Validate access to a non-existent page
    Given path 'users?page=999'
    When method GET
    Then status 200
    And match response.data == '#[0]'