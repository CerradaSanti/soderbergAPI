Feature: Chained request

  Background:
    * url 'https://reqres.in/api/'

  Scenario: Get a list of users and verify a specific user
    Given path 'users?page=1'
    When method GET
    Then match 0 != response.data.length
    And def userId = response.data[0].id
    And def userData = response.data[0]

    Given path 'users/' + userId
    When method GET
    Then status 200
    And match response.data == userData
    And match response.data.id == userId
    And match response.data.email == userData.email
    And match response.data.first_name == userData.first_name
    And match response.data.last_name == userData.last_name
    And match response.data.avatar == userData.avatar

#    Reusable file
    * def userSchema = read('classpath:userSchema.json')

    And match userData == userSchema
