source 'https://rubygems.org'

# Pry is a powerful alternative to the standard IRB shell for Ruby. It is
# written from scratch to provide a number of advanced features, including:
#   - Source code browsing (including core C source with the pry-doc gem)
#   - Documentation browsing
#   - Live help system
#   - Open methods in editors (edit Class#method)
#   - Syntax highlighting
#   - Command shell integration (start editors, run git, and rake from within
#     Pry)
#   - Gist integration
#   - Navigation around state (cd, ls and friends)
#   - Runtime invocation (use Pry as a developer console or debugger)
#   - Exotic object support (BasicObject instances, IClasses, ...)
#   - A powerful and flexible command system
#   - Ability to view and replay history
#   - Many convenience commands inspired by IPython, Smalltalk and other
#     advanced REPLs
#   - A wide-range number of plugins that provide remote sessions, full
#     debugging functionality, and more
#
# [Source: 'README.md' located at
#          https://github.com/pry/pry/blob/master/README.md]
gem 'pry-rails'

# Add the 'bootstrap-sass' gem on any line (outside of a group)
gem 'bootstrap-sass'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use sqlite3 as the database for Active Record
# [Update] Comment out this line per Bloc Checkpoint #26 instructions.
#gem 'sqlite3'

=begin
  From Bloc Checkpoint #26...
  
  We'll be specifying different databases for our development and production
  environments.
=end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Checkpoint #32: Seed Data
#
# Include the faker Gem in your Gemfile (below jquery is a good place)
gem 'faker'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Checkpoint #36 - User Authentication
gem 'devise'

# Checkpoint #37 - Authentication Continued
gem 'figaro', '1.0'

# Checkpoint #39 - Authorization
gem 'pundit'