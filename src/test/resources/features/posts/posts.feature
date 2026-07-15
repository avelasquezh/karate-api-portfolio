Feature: Posts API

  Background:
    * url baseUrl
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true
  
  @get
  Scenario: GET all posts should return 100 items
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match response[0] == { userId: '#number', id: '#number', title: '#string', body: '#string' }

  @smoke @get
  Scenario: GET /posts should return 100 posts
    Given path 'posts'
    When method GET
    Then status 200
    And match response == '#[100]'

  @regression @get
  Scenario: GET /posts/{id} should return a valid post
    Given path 'posts', 3
    When method GET
    Then status 200

    And match response.id == 3
    And match response contains
      """
      {
        id: '#number',
        userId: '#number',
        title: '#string',
        body: '#string'
      }
      """

  @regression @post
  Scenario: POST /posts should create a new post

    * def payload = read('classpath:data/posts/new-post.json')
    * set payload.title = 'Modified title during execution'
    
    Given path 'posts'
    And request payload
    When method POST
    Then status 201

  @negative @get
  Scenario: GET /posts/999 should return 404

    Given path 'posts', 999
    When method GET
    Then status 404

  @callExample
  Scenario: callPosts
    * def result = call read('classpath:features/posts/create-post.feature')
    * print result
    * match result.createdPost.id == '#number'