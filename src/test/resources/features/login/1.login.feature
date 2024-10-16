Feature: Login

  Background:

    * url 'https://reqres.in/api/login'

  Scenario: Successfull login
    Given request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
    When method POST
    Then status 200
    And match response.token != null

  Scenario: Failed login - Missing Password
    Given request { "email": "eve.holt@reqres.in" }
    When method POST
    Then status 400
    And match response.error == "Missing password"

  Scenario:Failed login - Missing Email
    Given request { "password": "cityslicka" }
    When method POST
    Then status 400
    And match response.error == "Missing email or username"

  Scenario: Headers validation
    Given request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
    When method POST
    Then status 200
    And match response.token != null
#    * print responseHeaders

    And match responseHeaders['Content-Type'][0] == 'application/json; charset=utf-8'
    And match responseHeaders['Date'] != null

