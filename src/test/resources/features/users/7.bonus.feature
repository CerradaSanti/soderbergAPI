Feature: Validate pagination and user consistency between pages

  Scenario: Validate pagination and user consistency between 1 and 2 pages
  # Validate 1
    Given url 'https://reqres.in/api/users?page=1'
    When method GET
    Then status 200
    And match response.per_page == 6
    #    Reusable file
    * def userSchema = read('classpath:userSchema.json')

    And match each response.data == userSchema
    * def page1Ids = response.data.map(function(item) { return item.id; })
    * print page1Ids

  # Validate 2
    Given url 'https://reqres.in/api/users?page=2'
    When method GET
    Then status 200
    And match response.per_page == 6
    And match each response.data == userSchema
    * def page2Ids = response.data.map(function(item) { return item.id; })
    * print page2Ids

  # Validate that there are no duplicate IDs between the two pages.
    * def intersection = page1Ids.filter(function(id) { return page2Ids.indexOf(id) !== -1 })
    * match intersection == []

  # Validate that the number of users on the page matches per_page
    And match response.per_page == response.data.length