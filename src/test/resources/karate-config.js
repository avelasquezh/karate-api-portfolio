function fn(){

    var env = karate.env;
    if(!env){
        env='dev';
    }

    var config={};
    if(env=='dev'){
        config.baseUrl='https://jsonplaceholder.typicode.com';
    }

    if(env=='qa'){
        config.baseUrl='https://qa.jsonplaceholder.typicode.com';
    }

    if(env=='prod'){
        config.baseUrl='https://prod.jsonplaceholder.typicode.com';
    }
    return config;
}