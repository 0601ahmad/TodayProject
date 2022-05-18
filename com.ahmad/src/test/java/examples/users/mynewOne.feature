Feature: Demo

  Background: 
    # in karate we use * instead of using gherkin keywords (given, when,t then)
    # karate we use url keyword to pass the endpoint url
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: get All users
    #in karate we use keyword path to pass the service name
    Given path 'users'
    # in karate we use method keyword to specify what is method type of this request
    When method Get
    # in karate we use status keyword to validate the response status code
    Then status 200
    # in karate we use print to print the value in console
    #in karate we use response keyowrd to store josn response
    * print response

  @test
  Scenario: create a user
    #in karate we send josn body in three double """
    Given path 'users'
    #in karate we use request keyword following with three double """ to sned a json body.
    And request
      """
       {
          "name": "James Bond",
          "username": "bond007",
          "email": "jaes.bond@gmail.com",
          "address": {
            "street": "001 main street",
            "suite": "Apt. 200",
            "city": "London",
            "zipcode": "95691"
          }
        }
      """
    And method post
    Then status 201
    * print response
    #in karate match keyword is == to assert.assertQeuals
    #in karate if we need to validate json resoponse values we need to write
    #response.jsonkey for example for name key we need to write response.name
    * match response.name == 'James Bond'
    * match response.address.city == 'London'
    * match response.username != 'bond008'
    * match response.email contains '.com'
    # * def name  = response.name
    # * match name == '#string'
    * def zipcode = response.address.zipcode
    * match zipocde =='#string'

  Scenario Outline: 
    Given path 'users'
    #in karate we use request keyword following with three double """ to sned a json body.
    And request
      """
       {
          "name": "<name>",
          "username": "<username>",
          "email": "<email>",
          "address": {
            "street": "<street>",
            "suite": "<suite>",
            "city": "<city>",
            "zipcode": "<zipcode>"
          }
        }
      """
    And method post
    Then status 201
    * print response
    #in karate match keyword is == to assert.assertQeuals
    #in karate if we need to validate json resoponse values we need to write
    #response.jsonkey for example for name key we need to write response.name
    * match response.name == 'James Bond'
    * match response.address.city == 'London'
    * match response.username != 'bond008'
    * match response.email contains '.com'
    # * def name  = response.name
    # * match name == '#string'
    * def zipcode = response.address.zipcode
    * match zipocde =='#string'

    Examples: 
      | name     | username    | email              | street  | suite | city       | zipocde    |
      | ahmad    | ahmad001    | ahmad@gmail.com    | 200west |   123 | westSca    | 95691-1234 |
      | farhad   | farhad002   | farhad@gmail.com   | 300east |   456 | sacramento | 6754-1234  |
      | ghafoori | ghafoori004 | ghafoori@gmail.com | 400east |   321 | Roseville  | 78954-5462 |
