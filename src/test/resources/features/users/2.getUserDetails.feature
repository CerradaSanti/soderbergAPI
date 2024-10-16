Feature: User data validation

  Background:
    * url 'https://reqres.in/api/users/2'

  Scenario: Get user details
    When method GET
    Then status 200
    * def responseUrl =
    """
    {
      "data": {
        "id": 2,
        "email": "janet.weaver@reqres.in",
        "first_name": "Janet",
        "last_name": "Weaver",
        "avatar": "https://reqres.in/img/faces/2-image.jpg"
      },
      "support": {
        "url": "https://reqres.in/#support-heading",
        "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
      }
    }
    """
    And match response == responseUrl

  Scenario: Additional structure validations
    When method GET
    Then status 200
    And match response.data == { id: #notnull, email: '#regex .+@.+', first_name: '#notnull', last_name: '#notnull', avatar: '#string' }

  Scenario: Validate response schema
    When method GET
    Then status 200
    * def schema =
    """
    {
      data: {
        id: '#number',
        email: '#regex .+@.+',
        first_name: '#string',
        last_name: '#string',
        avatar: '#string'
      },
      support: {
        url: '#string',
        text: '#string'
      }
    }
    """
    And match response == schema