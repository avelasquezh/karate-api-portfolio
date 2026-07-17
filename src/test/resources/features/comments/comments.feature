Feature: comments

  Background:
    * url baseUrl
    * configure logPrettyRequest = true
    * configure logPrettyResponse = true

    Scenario: GET all comments
        Given path '/comments'
        When method get
        Then status 200
        And match each response == read('classpath:schemas/comment-schema.json')
        

    Scenario: GET comments by postid
        Given path '/comments'
        And param postId = 1
        When method get
        Then status 200
        And match each response[*].postId == 1

    Scenario: GET filter example
        Given path '/posts/1'
        When method get
        Then status 200
        * def postId = response.id

        * path 'comments'
        * param postId = postId
        * method GET
        * status 200