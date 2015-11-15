[![Build Status](https://travis-ci.org/raelcun/Hapi-API-Base.svg?branch=master)](https://travis-ci.org/raelcun/Hapi-API-Base)
[![Coverage Status](https://coveralls.io/repos/raelcun/Hapi-API-Base/badge.svg?branch=master&service=github)](https://coveralls.io/github/raelcun/Hapi-API-Base?branch=master)
[![Dependency Status](https://david-dm.org/raelcun/hapi-api-base.svg)](https://david-dm.org/raelcun/hapi-api-base)
[![DevDependency Status](https://david-dm.org/raelcun/hapi-api-base/dev-status.svg)](https://david-dm.org/raelcun/hapi-api-base#info=devDependencies)

# Hapi API Base

Hapi is a robust framework for rapidly buidling RESTful interfaces. This example project is a great starting point for creating a RESTful API. The built-in features include:
* 100% Code Coverage
* User Authentication
  * JWT Tokens
  * Admin and User Scopes
  * Add/Remove Users
* SSL Enabled
* Mongoose Models
* Logging
* Gulp for Building and Testing
* Vagrant Box for Testing

## 100% Code Coverage

All code paths have been tested to make sure the API is as stable as possible.

## Authentication

[JSON Web Tokens](https://github.com/auth0/node-jsonwebtoken) are used to securely manage user sessions. Each token is assigned to a specific ip and host and validated upon each request. Every request, the ip and host in the token are validated against the ip and host that the current request came from. I also check to make sure that the username and scope specified in the token are valid users to cut down. 15 minutes after being issued, the token expires. To keep the token alive without having to login again, you can hit the `refreshToken` endpoint, providing a valid token, to receive a new token with 15 more minutes before expiration.

`Admin` and `User` scopes are already set up to access different resources. For example, anyone can hit the `login` endpoint, but only an `admin` can delete a user. More scopes can be added very easily.

There are two endpoints already set up to create and delete users from the database. These endpoints can only be accessed by an admin user.

## SSL Enabled

The certificate provided is self signed and should only be used for testing purposes. Make sure you replace this certificate with one from a CA for production.

## Mongoose Models

[Mongoose](https://github.com/Automattic/mongoose) is a MongoDB ORM designed to provide a modeling and management layer on top of the basic Mongo driver. Mongoose was used because it works well for small projects, but is flexible enough to work on very large projects as well. Data accessor functions are provided as static functions defined on the user model. In my opinion, the controller should always go through an interface (sometimes called a DAO) such as the functions defined on the model to avoid directly querying the database. This makes it much easier to test and change if necessary.

## Logging

[Good](https://github.com/hapijs/good) is used as a plugin to Hapi to log internal events such as requests, responses, and errors to the console.

[Winston](https://github.com/winstonjs/winston) is used to pipe all log output, with the exception of the Good logs, to a Mongo database as well as print out the logs to the console.

## Gulp for Building and Testing

[Gulp](https://github.com/gulpjs/gulp) is an alternative to the popular Grunt build system that is focused on streams. The following commands can be used to control gulp:

**Build the Project**

```shell
gulp coffee
```

**Build and Watch the Project Directory for Changes**
```shell
gulp
```

**Run Tests, Outputting to the Command Line**
```shell
gulp test:console
```

**Run Tests, Outputting to HTML**
```shell
gulp test:html
```