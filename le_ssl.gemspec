$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "le_ssl/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name                  = "le_ssl"
  s.version               = LeSsl::VERSION
  s.required_ruby_version = '>= 1.9.3'
  s.authors               = ["Tobias Feistmantl"]
  s.email                 = ["tobias@feistmantl.io"]
  s.homepage              = "https://github.com/tobiasfeistmantl/LeSSL"
  s.summary               = "Le SSL makes it easy to obain certificates of Let's Encrypt"
  s.description           = "Le SSL makes it easy to obain certificates of Let's Encrypt"
  s.license               = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"
  s.add_dependency "acme-client", '~> 0.3.0'
end
