# Karate API Portfolio

A professional API automation framework built with **Karate DSL**, **Java 17**, **Maven**, and **GitHub Actions**. This project demonstrates API testing best practices, scalable framework architecture, Continuous Integration, and maintainable test design.

---

# Table of Contents

- [Overview](#overview)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Features Implemented](#features-implemented)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the Tests](#running-the-tests)
- [Executing by Tags](#executing-by-tags)
- [Project Architecture](#project-architecture)
- [GitHub Actions CI](#github-actions-ci)
- [Karate Reports](#karate-reports)
- [Current Test Coverage](#current-test-coverage)
- [Roadmap](#roadmap)

---

# Overview

This repository contains an API automation framework developed using **Karate DSL** following good automation practices.

Current objectives include:

- API functional testing
- Scalable project architecture
- Continuous Integration
- Readable Gherkin scenarios
- Easy maintenance
- Portfolio demonstration

The framework currently validates the public API:

https://jsonplaceholder.typicode.com

---

# Technology Stack

| Technology | Version |
|------------|----------|
| Java | 17 |
| Maven | 3.x |
| Karate | 1.4.1 |
| JUnit | 5 |
| GitHub Actions | Latest |
| Gherkin | Supported |

---

# Project Structure

```
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
│       │           │
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
├── target
│
├── pom.xml
└── README.md
```

---

# Features Implemented

## API Testing

- GET all posts
- GET post by id
- POST create post
- Negative testing
- Status code validation
- Response body validation
- Data type validation

---

## Gherkin

The framework follows the Gherkin syntax.

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

## Tags

Current tags include:

- @smoke
- @regression
- @negative
- @get
- @post

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

Clone repository

```bash
git clone https://github.com/avelasquezh/karate-api-portfolio.git

cd karate-api-portfolio
```

Install dependencies

```bash
mvn clean install
```

---

# Running the Tests

Execute all tests

```bash
mvn test
```

Clean project

```bash
mvn clean
```

Clean and execute

```bash
mvn clean test
```

---

# Executing by Tags

Karate supports executing scenarios using tags.

Examples:

Smoke tests

```bash
mvn test "-Dkarate.options=--tags @smoke"
```

Regression

```bash
mvn test "-Dkarate.options=--tags @regression"
```

Negative

```bash
mvn test "-Dkarate.options=--tags @negative"
```

GET scenarios

```bash
mvn test "-Dkarate.options=--tags @get"
```

POST scenarios

```bash
mvn test "-Dkarate.options=--tags @post"
```

Exclude a tag

```bash
mvn test "-Dkarate.options=--tags ~@negative"
```

---

# Project Architecture

The framework separates responsibilities into different modules.

## config

Configuration classes.

Future usage:

- Environment variables
- Global configuration
- Authentication

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

Reusable helper classes.

Future examples:

- Token generation
- Date utilities
- Common request builders

---

## runners

JUnit runners responsible for executing feature files.

Current runner:

- PostsRunner

---

## utils

Reusable utility classes.

---

## resources

Project resources.

### config

Configuration files.

### data

Future request payloads.

Example:

```
resources/data/posts/create-post.json
```

### schemas

Future JSON Schema validations.

Example:

```
resources/schemas/post-schema.json
```

---

# GitHub Actions CI

The project includes a Continuous Integration pipeline.

Workflow location

```
.github/workflows/maven.yml
```

The pipeline automatically:

- Checks out the repository
- Installs Java 17
- Restores Maven cache
- Executes all Karate tests
- Uploads Karate HTML reports as workflow artifacts

Workflow triggers:

- Push
- Pull Request
- Manual execution (workflow_dispatch)

---

# Karate Reports

Karate automatically generates HTML reports after every execution.

Location:

```
target/karate-reports/
```

Main report:

```
target/karate-reports/karate-summary.html
```

---

# Current Test Coverage

## Posts API

### GET

- Retrieve all posts
- Validate response size
- Validate object structure

### GET by ID

- Validate status code
- Validate response body
- Validate data types

### POST

- Create new post
- Validate request payload
- Validate response

### Negative

- Validate 404 response

---

# Future Enhancements

The framework is planned to evolve with:

- Environment management (`karate-config.js`)
- External JSON payloads
- JSON Schema validation
- Authentication workflows
- Reusable feature calls (`call`, `callonce`)
- Dynamic test data
- Parallel execution
- Docker support
- Allure Reports
- API performance assertions
- GitHub Pages report publication
- Multi-environment execution (DEV / QA / PROD)

---

# Author

**Arley Velásquez**

QA Automation Engineer

GitHub:

https://github.com/avelasquezh

---

# License

This project is intended for educational and portfolio purposes.