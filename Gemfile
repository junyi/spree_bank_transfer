source 'https://rubygems.org'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree', github: 'spree/spree', branch: '3-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'
gem 'mysql2'

group :assets do
  gem 'coffee-rails', '~> 4.0.0'
  gem 'sass-rails', '~> 4.0.2'
end

group :test do
  gem 'test-unit'
  gem 'minitest'
  gem 'rspec-rails', '~> 3.3.3'
  gem 'shoulda-matchers', '2.8.0'
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'rspec-activemodel-mocks'
end
gemspec
