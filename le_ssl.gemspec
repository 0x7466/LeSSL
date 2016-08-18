$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'le_ssl/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name                  = 'le_ssl'
  s.version               = LeSSL::VERSION
  s.required_ruby_version = '>= 2.1.0'
  s.authors               = ['Tobias Feistmantl']
  s.email                 = ['tobias@feistmantl.io']
  s.homepage              = 'https://github.com/tobiasfeistmantl/LeSSL'
  s.summary               = 'Le SSL makes it easy to obtain certificates from Let\'s Encrypt'
  s.description           = 'Le SSL makes it easy to obtain certificates from Let\'s Encrypt'
  s.license               = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.0.0'
  s.add_dependency 'acme-client', '~> 0.4.0'
end
