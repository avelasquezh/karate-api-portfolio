package com.portfolio.runners;

//import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

class PostsRunner {

    @Karate.Test
    Karate testPosts() {
        return Karate.run("classpath:features/posts/posts.feature");
    }
}