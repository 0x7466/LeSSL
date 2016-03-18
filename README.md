LeSSL
=====

[![Gem Version](https://badge.fury.io/rb/le_ssl.svg)](https://badge.fury.io/rb/le_ssl)
[![Build Status](https://travis-ci.org/tobiasfeistmantl/LeSSL.svg?branch=master)](https://travis-ci.org/tobiasfeistmantl/LeSSL)

LeSSL is a simple gem to authorize for domains and obtaining certificates from the Let's Encrypt CA. Now it's very easy to get free and trusted SSL certificates!

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
manager = LeSSL::Manager.new(email: 'john@example.com', agree_terms: true, private_key: private_key)
```
It's recommended to store the contact email and the private key in environment variables because you are just allowed to obtain certificates for domains you are authorized for.

If you have `LESSL_CLIENT_PRIVATE_KEY` and `LESSL_CONTACT_EMAIL` set, you don't have to pass them to the initializer.

```ruby
# Example
manager = LeSSL::Manager.new(agree_terms: true)  # Accepting the terms is enough
```

The manager registers automatically a new account on the Let's Encrypt servers.

Authorize for a domain now:

**Important! Every domain you want to be authorized for must have a valid A record which points to your server IP!**

```ruby
manager.authorize_for_domain('example.com')
manager.authorize_for_domain('www.example.com')
```

If your domain is properly set up, you should now be authorized for the domain. Be also sure that your Rails server is running.

Obtaining a SSL certificate:

```ruby
manager.request_certificate('www.example.com', 'example.com')
```

This puts the public and private keys into `config/ssl`. Now you just have to configure your webserver to use these certificates and you should be ready for encrypted HTTP.

**Note that you have to authorize seperately for subdomains (e.g. www.example.com)!**

Use DNS verification
--------------------

If the domain isn't pointing to your server, you can also use a DNS TXT verification. Simply pass the option `:challenge` with the value `:dns` to the parameters of the `#authorize_for_domain` method:

```ruby
challenge = manager.authorize_for_domain('example.com', challenge: :dns)
```

**Important!** Save the returned value into a variable because it's needed to request the verification!

Then create the corresponding DNS TXT record for your domain. (Hint: The `#authorize_for_domain` method prints the information if you use it from the command line)

Wait a few minutes to be sure that the record was updated by the Let's encrypt servers.

And as last step request the verification for the challenge.

```ruby
manager.request_verification(challenge)
```

This returns the verification status afterwards.

If this returns `valid` you are authorized to obtain a certificate for this domain.

Skip registering
----------------

You can also skip the automatic registering which is done in the initializer:

```ruby
manager = LeSSL::Manager.new(agree_terms: true, email: 'john@example.com', private_key: private_key, skip_register: true)
```

To register an account call the `#register` method:

```ruby
manager.register('john@example.com')
```

Development
-----------

LeSSL uses the staging servers of Let's Encrypt if the Rails environment is set to 'development'.

You need help?
--------------

Ask a question on [StackOverflow](https://stackoverflow.com/) with the tag 'le-ssl'.

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
