package com.portfolio.runners;
import com.intuit.karate.junit5.Karate;

class CommentsRunner {
    @Karate.Test
    Karate testPosts() {
        return Karate.run("classpath:features/comments/comments.feature");
    }
}