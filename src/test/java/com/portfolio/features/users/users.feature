Feature: Users api 

Background:
    * url 'https://jsonplaceholder.typicode.com'
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

@get-users
Scenario: Get complet users collection
    Given path '/users'
    When method get
    Then status 200
    And match response[0] == {id: '#number', name: '#string', username: '#string', email: '#string', address: '#object', phone: '#string', website: '#string', company: '#object' }
    * print response

Scenario: Get partial users collection
    Given path '/users'
    When method get
    Then status 200
    And match response == '#[10]'
    And match response[0] == {id: '#number', name: '#string', username: '#string', email: '#string', address: '#object', phone: '#string', website: '#string', company: '#object' }
    * print response