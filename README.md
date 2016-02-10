LeSSL
=====

[![Gem Version](https://badge.fury.io/rb/le_ssl.svg)](https://badge.fury.io/rb/le_ssl)

LeSSL is a simple gem to authorize for domains and obaining certificates from the Let's Encrypt CA. Now it's very easy to get free and trusted SSL certificates!

Compatibility
-------------

Rails 4+

Installation
------------

Install from Rubygems:

```
$ gem install le_ssl
```

or add it to your Gemfile:

```ruby
gem 'le_ssl'
```

And then run `bundle install` and you are ready to go.

Getting Started
---------------

Create an instance of the LeSSL Manager:

```ruby
private_key = OpenSSL::PKey::RSA.new(4096)
manager = LeSsl::Manager.new(email: 'john@example.com', agree_terms: true, private_key: private_key)
```
It's recommended to store the contact email and the private key in environment variables because you are just allowed to obain certificates for domains you are authorized for.

If you have `CERT_ACCOUNT_EMAIL` and `CERT_ACCOUNT_PRIVATE_KEY` set, you don't have to pass them to the initializer.

```ruby
# Example
manager = LeSsl::Manager.new(agree_terms: true)  # Accepting the terms is enough
```

The manager registers automatically a new account on the Let's Encrypt servers.

Authorize for a domain now:

**Important! Every domain you want to be authorized for must have a valid A record which points to your server IP!**

```ruby
manager.authorize_for_domain('example.com')
manager.authorize_for_domain('www.example.com')
```

If you domain is properly set up you should now be authorized for the domain. Be also sure that your Rails server is running.

Obaining a SSL certificate:

```ruby
manager.request_certificate('www.example.com', 'example.com')
```

This puts the public and private keys into `config/ssl`. Now you just have to configure your webserver to use these certificates and you should be ready for encrypted HTTP.

**Note that you have to authorize seperately for subdomains (e.g. www.example.com)!**

Development
-----------

LeSSL uses the staging servers of Let's Encrypt if the Rails environment is set to 'development'.

Planned Features
----------------

 * Automatically renew certificates with an ActiveJob job
 * Automatically install certificates in popular web servers

We welcome also other feature request and of course feature pull requests!

Other things to do
------------------

 * **To test the gem.**

Also here we would be thankful for pull requests.

Contribution
------------

Create pull requests on Github and help us to improve this gem. There are some guidelines to follow:

 * Follow the conventions
 * Test all your implementations
 * Document methods which aren't self-explaining (we are using [YARD](http://yardoc.org/))

Copyright (c) 2016 Tobias Feistmantl, MIT license