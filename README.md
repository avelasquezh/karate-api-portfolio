# Karate API Portfolio

A professional API automation framework built with **Karate DSL**, **Java 17**, **Maven**, and **GitHub Actions**. This project demonstrates API testing best practices, a scalable framework structure, Continuous Integration, and maintainable test automation.

---

# Overview

This repository contains an API automation framework developed with **Karate DSL** following automation best practices.

Current objectives include:

- API functional testing
- Readable Gherkin scenarios
- Scalable project organization
- Continuous Integration with GitHub Actions
- Maintainable automation framework

The current implementation validates endpoints from the public API:

https://jsonplaceholder.typicode.com

---

# Technology Stack

| Technology | Version |
|------------|---------|
| Java | 17 |
| Maven | 3.x |
| Karate DSL | 1.4.1 |
| JUnit | 5 |
| GitHub Actions | Latest |
| Gherkin | Supported |

---

# Project Structure

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
│       │           ├── config
│       │           ├── features
│       │           │   ├── authentication
│       │           │   ├── comments
│       │           │   ├── posts
│       │           │   │   └── posts.feature
│       │           │   └── users
│       │           ├── helpers
│       │           ├── runners
│       │           │   └── PostsRunner.java
│       │           └── utils
│       │
│       └── resources
│           ├── config
│           ├── data
│           │   ├── posts
│           │   └── users
│           └── schemas
│
├── pom.xml
└── README.md
```

---

# Implemented Features

## API Testing

Current implementation includes:

- GET endpoint validation
- POST endpoint validation
- Negative testing
- HTTP status code validation
- Response body validation
- Response data type validation
- Collection size validation

---

## Gherkin Scenarios

The framework uses Gherkin syntax to improve readability and collaboration.

Example:

```gherkin
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
```

---

## Test Tags

Implemented tags:

- `@smoke`
- `@regression`
- `@negative`
- `@get`
- `@post`

---

# Prerequisites

Install:

- Java 17
- Maven
- Git

Verify installation:

```bash
java -version
mvn -version
git --version
```

---

# Installation

Clone the repository:

```bash
git clone https://github.com/avelasquezh/karate-api-portfolio.git
```

Go to the project directory:

```bash
cd karate-api-portfolio
```

Install dependencies:

```bash
mvn clean install
```

---

# Running the Tests

Execute the complete suite:

```bash
mvn test
```

Clean the project:

```bash
mvn clean
```

Clean and execute:

```bash
mvn clean test
```

---

# Executing by Tags

Run Smoke tests:

```bash
mvn test "-Dkarate.options=--tags @smoke"
```

Run Regression tests:

```bash
mvn test "-Dkarate.options=--tags @regression"
```

Run Negative tests:

```bash
mvn test "-Dkarate.options=--tags @negative"
```

Run GET scenarios:

```bash
mvn test "-Dkarate.options=--tags @get"
```

Run POST scenarios:

```bash
mvn test "-Dkarate.options=--tags @post"
```

Exclude a tag:

```bash
mvn test "-Dkarate.options=--tags ~@negative"
```

---

# Project Architecture

## config

Reserved for framework configuration classes as the project evolves.

---

## features

Contains all Gherkin feature files organized by API resource.

Current modules:

- authentication
- comments
- posts
- users

---

## helpers

Reserved for reusable helper classes.

---

## runners

Contains the JUnit runners responsible for executing feature files.

Current runner:

- `PostsRunner`

---

## utils

Reserved for shared utility classes.

---

## resources

Contains framework resources.

Current structure:

```text
resources
├── config
├── data
│   ├── posts
│   └── users
└── schemas
```

These directories have been prepared to organize test resources as the framework grows.

---

# GitHub Actions

The project includes a Continuous Integration workflow.

Workflow location:

```text
.github/workflows/maven.yml
```

Current pipeline:

- Checkout repository
- Configure Java 17
- Cache Maven dependencies
- Execute `mvn clean test`
- Upload Karate HTML reports as workflow artifacts

The workflow runs automatically on:

- Push
- Pull Request

It can also be executed manually using **workflow_dispatch**.

---

# Karate Reports

Karate automatically generates HTML reports after each execution.

Report location:

```text
target/karate-reports/
```

Main report:

```text
target/karate-reports/karate-summary.html
```

---

# Current Test Coverage

## Posts API

Implemented scenarios:

### GET /posts

- Validate HTTP 200
- Validate collection size
- Validate response structure

### GET /posts/{id}

- Validate HTTP 200
- Validate response content
- Validate response data types

### POST /posts

- Validate HTTP 201
- Validate response payload

### GET /posts/999

- Validate HTTP 404

Current validations include:

- HTTP status codes
- Response structure
- Data types
- Response content
- Collection size

---

# Roadmap

Planned framework improvements:

- Environment configuration using `karate-config.js`
- External JSON request payloads
- JSON Schema validation
- Authentication support
- Reusable feature calls (`call`, `callonce`)
- Allure Report integration
- Parallel execution
- Docker support
- Multi-environment execution

---

# Author

**Arley Velásquez**

QA Automation Engineer

GitHub:

https://github.com/avelasquezh

---

# License

This project is intended for educational purposes and as a professional automation testing portfolio.