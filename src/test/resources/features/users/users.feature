Feature: Users api 

    Background:
        * url baseUrl
        * configure logPrettyRequest = true
        * configure logPrettyResponse = true

    @get-users
    Scenario: GET /users should return all users
        Given path '/users'
        When method get
        Then status 200
        And match response == '#[10]'
       
    @get
    Scenario: GET /users/{id} should return a valid user
        Given path 'users', 1
        When method GET
        Then status 200
        And match response.id == 1
        And match response.username == '#string'
        And match response.address.city == '#string'
        And match response.company.name == '#string'

    @get
    Scenario: GET /users/{id} should return 404 for a nonexistent user
        Given path 'users', 999
        When method GET
        Then status 404

    @get
    Scenario: GET /users should validate every user schema
        Given path 'users'
        When method GET
        Then status 200
        And match each  response == 
        """
        {
            id: '#number',
            name: '#string',
            username: '#string',
            email: '#string',
            address:
            {
                street: '#string',
                suite: '#string',
                city: '#string',
                zipcode: '#string',
                geo:
                {
                    lat:'#string',
                    lng:'#string'
                }
            }, 
            phone: '#string',
            website: '#string',
            company: 
            {
                name: '#string',
                catchPhrase: '#string',
                bs: '#string'
            }
        }
        """