source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem "pg", "~> 0.18"
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'config'
gem 'active_model_serializers'
gem "font-awesome-rails"
gem 'devise'
gem 'jwt'
gem 'forty_facets', git: 'https://github.com/fortytools/forty_facets'
gem "haml-rails"

gem 'bootstrap-sass', '~> 3.3'
gem 'react-rails'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'seed_dump'
  gem 'traceroute'
  gem 'rack-mini-profiler'
  gem 'bullet'
  gem 'brakeman', :require => false
  gem 'rails_best_practices'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
