Feature: create-post
    
    Scenario: create post
        * url baseUrl
        * def payload = read('classpath:data/posts/new-post.json')
        Given path 'posts'
        And request payload
        When method post
        Then status 201
        * def createdPost = response