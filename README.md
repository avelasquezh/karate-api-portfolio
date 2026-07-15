# Karate API Portfolio

A professional API automation framework built with **Karate DSL**, **Java 17**, **Maven**, **JUnit 5**, and **GitHub Actions**.

This repository has been developed as a learning project and professional portfolio to demonstrate API test automation best practices, maintainable framework architecture, reusable test design, contract validation, Continuous Integration, and scalable project organization.

The framework currently automates REST APIs exposed by:

> https://jsonplaceholder.typicode.com

---

# Overview

The purpose of this project is to build a production-oriented API automation framework while progressively incorporating advanced Karate DSL features.

Instead of creating isolated examples, every implementation is integrated into the framework architecture following good automation practices.

Current implementation includes:

- Functional API testing
- REST endpoint validation
- Positive and negative scenarios
- Gherkin-based test definition
- Externalized request payloads
- Contract validation using JSON Schema
- Scenario Outline parameterization
- Reusable features with `call`
- Environment configuration using `karate-config.js`
- Maven build automation
- Continuous Integration with GitHub Actions
- HTML reporting

---

# Technology Stack

| Technology | Version |
|------------|---------|
| Java | 17 |
| Maven | 3.x |
| Karate DSL | 1.4.1 |
| JUnit | 5 |
| Gherkin | Supported |
| GitHub Actions | Latest |

---

# Framework Architecture

The project follows a modular organization that separates test logic, reusable data, configuration, schemas, and execution components.

```text
karate-api-portfolio
│
├── .github
│   └── workflows
│       └── maven.yml
│
├── src
│   └── test
│       ├── java
│       │   └── com
│       │       └── portfolio
│       │           └── runners
│       │               ├── PostsRunner.java
│       │               └── UsersRunner.java
│       │
│       └── resources
│           ├── config
│           ├── data
│           │   ├── posts
│           │   │   ├── new-post.json
│           │   │   └── update-post.json
│           │   └── users
│           │
│           ├── features
│           │   ├── authentication
│           │   ├── comments
│           │   ├── posts
│           │   │   ├── posts.feature
│           │   │   └── create-post.feature
│           │   └── users
│           │       └── users.feature
│           │
│           ├── schemas
│           │   └── post-schema.json
│           │
│           ├── karate-config.js
│           └── logback-test.xml
│
├── pom.xml
└── README.md
```

---

# Project Organization

The framework separates responsibilities into independent modules.

This organization simplifies maintenance, encourages code reuse, and allows the project to grow without affecting existing tests.

## runners

Contains the JUnit entry points responsible for executing Karate feature files.

Current runners:

- PostsRunner
- UsersRunner

Each runner is responsible for executing a specific API module.

Example:

```java
return Karate.run("classpath:features/posts/posts.feature");
```

---

## features

Contains all automated scenarios written in Gherkin.

Features are organized by API resource instead of by HTTP method.

Current modules:

- authentication
- comments
- posts
- users

This organization allows each API resource to evolve independently.

---

## data

Stores external test data.

Instead of hardcoding payloads inside feature files, request bodies are stored as JSON documents.

Current structure:

```text
data
├── posts
│   ├── new-post.json
│   └── update-post.json
└── users
```

Benefits:

- Better readability
- Easier maintenance
- Reusable payloads
- Separation between test logic and test data

---

## schemas

Contains reusable JSON schemas used to validate API contracts.

Instead of validating every field manually inside scenarios, the response structure can be compared against a reusable schema.

Current schema:

```text
schemas
└── post-schema.json
```

Benefits:

- Centralized contract validation
- Easier maintenance
- Detects API contract changes
- Reusable across multiple scenarios

---

## config

Reserved for future framework configuration files.

As the framework evolves, this directory can contain additional configuration resources without modifying the project structure.

---

# Maven Configuration

Project dependencies and build configuration are managed through Maven.

Current configuration includes:

- Java 17
- Karate DSL 1.4.1
- Maven Surefire Plugin
- Test resource configuration

The project explicitly defines two test resource directories.

```xml
src/test/java
src/test/resources
```

This configuration allows Maven to copy both Java classes and Karate resources into the test classpath during execution.

The Surefire plugin is configured to execute every runner that matches:

```text
**/*Runner.java
```

This allows new API modules to be incorporated simply by creating a new Runner.

---

# Environment Configuration

The project uses `karate-config.js` as the central configuration file.

Karate automatically executes this file before every scenario.

Current environments:

- dev
- qa
- prod

Current implementation:

```javascript
config.baseUrl
```

The base URL is selected according to the execution environment.

Example:

```gherkin
* url baseUrl
```

This avoids hardcoding URLs inside feature files and prepares the framework for multi-environment execution.

Example commands:

```bash
mvn test
```

Default environment:

```text
dev
```

Specific environment:

```bash
mvn test -Dkarate.env=qa
```

```bash
mvn test -Dkarate.env=prod
```

Currently, only the **dev** environment points to an available API.

---

# API Testing Capabilities

The framework currently supports:

- GET requests
- POST requests
- Positive testing
- Negative testing
- HTTP status validation
- Response body validation
- Response data type validation
- Response collection validation
- JSON contract validation

---

# External Test Data

Karate allows request bodies to be loaded from external files.

Current implementation:

```gherkin
* def payload = read('classpath:data/posts/new-post.json')
```

The payload is then used as the request body.

```gherkin
Given request payload
```

Advantages:

- Eliminates duplicated JSON
- Easier maintenance
- Cleaner feature files
- Promotes payload reuse

---

# JSON Schema Validation

Instead of validating every field manually, the framework validates API contracts using external schemas.

Current implementation:

```gherkin
And match response == read('classpath:schemas/post-schema.json')
```

This approach verifies that the response structure matches the expected contract.

Benefits:

- Detects contract changes
- Improves maintainability
- Encourages schema reuse
- Simplifies feature files

---

# Reusable Features

Karate allows complete scenarios to be reused through the `call` keyword.

Current implementation:

```gherkin
* def result = call read('classpath:features/posts/create-post.feature')
```

The called feature executes independently and returns its variables to the calling scenario.

This approach reduces duplicated logic and promotes modular test design.

---

# Scenario Outline

Parameterized testing is implemented using `Scenario Outline`.

Example:

```gherkin
Scenario Outline: GET Validate multiple posts id

Examples:
| id |
| 1  |
| 2  |
| 3  |
| 50 |
|100 |
```

A single scenario is executed multiple times using different input values.

Benefits:

- Less duplicated code
- Better readability
- Easier maintenance
- Higher test coverage

---

# Test Tags

Current tags implemented in the project:

- `@smoke`
- `@regression`
- `@negative`
- `@get`
- `@post`
- `@callExample`
- `@readExample`

Tags allow selective execution of scenarios during local development or CI pipelines.

---

# Running the Framework

## Execute all tests

```bash
mvn clean test
```

---

## Execute a specific Runner

Posts API

```bash
mvn test -Dtest=PostsRunner
```

Users API

```bash
mvn test -Dtest=UsersRunner
```

---

## Execute by tag

Smoke tests

```bash
mvn test "-Dkarate.options=--tags @smoke"
```

Regression

```bash
mvn test "-Dkarate.options=--tags @regression"
```

GET

```bash
mvn test "-Dkarate.options=--tags @get"
```

POST

```bash
mvn test "-Dkarate.options=--tags @post"
```

Negative

```bash
mvn test "-Dkarate.options=--tags @negative"
```

Exclude a tag

```bash
mvn test "-Dkarate.options=--tags ~@negative"
```
# Logging Configuration

To simplify debugging during test execution, the framework enables formatted request and response logging.

Current configuration:

```gherkin
* configure logPrettyRequest = true
* configure logPrettyResponse = true
```

These settings automatically print the complete HTTP communication in a human-readable format.

The following information is displayed during execution:

- HTTP method
- Endpoint
- Request headers
- Request body
- Response status
- Response headers
- Response body
- Response time

This configuration is especially useful during framework development, debugging, and API contract verification.

---

# Test Reports

Karate automatically generates HTML reports after every execution.

Report location:

```text
target/karate-reports/
```

Main report:

```text
target/karate-reports/karate-summary.html
```

The report provides:

- Executed scenarios
- Passed scenarios
- Failed scenarios
- Execution time
- Error details
- Embedded request and response information

The HTML report can be opened directly in any web browser.

---

# Continuous Integration

The project includes a GitHub Actions workflow that automatically executes the API test suite.

Workflow location:

```text
.github/workflows/maven.yml
```

Current pipeline includes:

1. Checkout repository
2. Configure Java 17 (Temurin)
3. Cache Maven dependencies
4. Execute automated tests
5. Upload Karate HTML reports as workflow artifacts

Execution command:

```bash
mvn clean test
```

The workflow is triggered automatically on:

- Push to `main`
- Push to `develop`
- Pull Request targeting `main`

It can also be executed manually using:

```text
workflow_dispatch
```

This allows the framework to be executed locally as well as in a Continuous Integration environment without additional configuration.

---

# Current Test Coverage

## Posts API

Current automated scenarios include:

### GET /posts

- Validate HTTP 200
- Validate collection size
- Validate first element structure
- Validate response contains 100 posts

### GET /posts/{id}

- Validate HTTP 200
- Validate returned identifier
- Validate complete response schema

### POST /posts

- Create a new resource
- Load request body from an external JSON file
- Validate HTTP 201 response

### Negative Testing

- Validate `GET /posts/999`
- Verify HTTP 404 response

### Reusable Features

The framework demonstrates feature reuse by invoking an independent feature using:

```gherkin
call read(...)
```

The returned object is then validated by the calling scenario.

### Parameterized Testing

The project validates multiple resource identifiers using a single `Scenario Outline`.

Current dataset:

- 1
- 2
- 3
- 50
- 100

This avoids duplicated scenarios while improving maintainability.

---

## Users API

Current implementation includes:

### GET /users

- Validate HTTP 200
- Validate collection size
- Validate every user structure
- Validate nested objects
- Validate data types

### GET /users/{id}

- Validate HTTP 200
- Validate returned identifier
- Validate user information

### Negative Testing

- Validate HTTP 404 for non-existing resources

The Users module follows the same architectural principles adopted for the Posts module, allowing both APIs to evolve consistently.

---

# Framework Design Principles

The project follows several principles intended to improve scalability and maintainability.

## Separation of Responsibilities

The framework separates:

- Test execution
- Test scenarios
- Test data
- Configuration
- Contract schemas

Each concern is stored in an independent directory.

---

## Externalized Test Data

Request payloads are stored outside feature files.

Benefits include:

- Easier maintenance
- Reduced duplication
- Better readability
- Improved reusability

---

## Reusable Test Logic

Common functionality can be extracted into reusable feature files and invoked with `call`.

This minimizes duplicated automation logic and simplifies future maintenance.

---

## Contract Validation

Instead of validating individual fields in every scenario, reusable JSON schemas define the expected API structure.

This approach quickly detects unexpected contract changes introduced by backend implementations.

---

## Environment Independence

Application URLs are not hardcoded inside feature files.

Instead, they are provided through `karate-config.js`, making the framework ready for multiple execution environments.

---

## Modular Architecture

Every API resource can have:

- Its own feature file
- Independent runner
- Dedicated payloads
- Independent schemas

This organization supports incremental framework growth without requiring structural changes.

---

# Current Project Status

The framework currently includes:

- Maven project structure
- Karate DSL integration
- Java 17 configuration
- JUnit 5 runners
- GitHub Actions pipeline
- Environment configuration
- External JSON payloads
- JSON Schema validation
- Scenario Outline
- Request and response logging
- HTML reporting
- Feature reuse with `call`
- Automated testing for Posts and Users APIs

The project has been intentionally organized to facilitate the addition of new API resources while maintaining a consistent architecture.

---

# Future Improvements

The following capabilities are planned for future iterations:

- Feature reuse using `callonce`
- Additional reusable helper features
- Expanded contract validation for new resources
- Authentication workflows
- Additional API modules (Comments, Albums, Todos)
- Parallel test execution
- Allure Report integration
- Docker-based execution
- Performance-oriented API testing

These improvements will be incorporated incrementally while preserving the current project architecture.

---

# Repository

GitHub:

```text
https://github.com/avelasquezh/karate-api-portfolio
```

Clone the project:

```bash
git clone https://github.com/avelasquezh/karate-api-portfolio.git
```

Install dependencies:

```bash
mvn clean install
```

Run all tests:

```bash
mvn clean test
```

---

# Learning Objectives

This repository is intended to demonstrate practical knowledge of:

- Karate DSL
- API functional testing
- REST API automation
- Maven project management
- JUnit integration
- JSON Schema validation
- Data-driven testing
- Reusable test design
- Continuous Integration with GitHub Actions

The project is continuously expanded as new Karate capabilities are incorporated and validated.

---

# Author

**Arley Velásquez**

QA Automation Engineer

GitHub:

```text
https://github.com/avelasquezh
```

---

# License

This repository is intended for educational purposes and as a professional API automation portfolio demonstrating modern automation practices using Karate DSL.