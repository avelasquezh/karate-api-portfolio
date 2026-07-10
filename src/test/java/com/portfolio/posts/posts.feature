Feature: Posts API

  Background:
    * url 'https://jsonplaceholder.typicode.com'

  Scenario: GET all posts should return 100 items
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match response[0] == { userId: '#number', id: '#number', title: '#string', body: '#string' }

  Scenario: GET all posts should return 100 items
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match response[0] == { userId: '#number', id: '#number', title: '#string', body: '#string' }

  Scenario: GET all posts should return 100 items
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match response[0] == { userId: '#number', id: '#number', title: '#string', body: '#string' }

  Scenario: GET all posts should return 100 items
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match response[0] == { userId: '#number', id: '#number', title: '#string', body: '#string' }