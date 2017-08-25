# portier_idp
prototype of an idp using portiers custom protocol, for testing and bootstrapping your custom solution.

## Background

[Portier](https://portier.github.io/) allows sites to enable user logins without storing or checking passwords, by doing that job for them. User enter an email address, and portier confirms that the user controls that email address by sending a code to them. That works for all addresses. But more comfortable is the special threatment it gives Gmail: There, user could log into their account instead. That uses [OpenID Connect](https://developers.google.com/identity/protocols/OpenIDConnect). Now, this IdP (Identity Provider) is software that user with custom (email) domains can run on their server to have a login via password as well. And it could be extended to use additional login methods, and extensions like 2FA.

portier_idp implements the exact OIDC protocol that the portier broker (since version 0.2.0) uses to confirm an identity.

## Installation

Make sure you have a reasonable new version of ruby installed, sqlite3 (including the dev headers), and the bundler gem (`gem install bundler`). Then:

```
git https://github.com/onli/portier_idp.git
cd portier_idp
bundle install
```

Note: portier_idp has to serve files under `/.well-known/`, that might be problematic if you want to mix it with other web services.

## Important: Configuration

Set the url where this software will be served from in `confing.ini`.

Your webserver has to run under `https` to be accepted by a portier broker. You most likely want to run this software behind an apache or nginx proxy.

portier_idp has some very basic user management, a method to add email addresses and their password. Go to `/users` to add email addresses and passwords. You need to secure these endpoints manually for now, for example with basic http authentication:

 * GET `/users`
 * POST `/addUser`
 * POST `/removeUser`
 
 ## Start
 
 ```
 bundle exec rackup -E development -p 9292
 ```
