# Rocky

[![Build Status](https://travis-ci.org/Semjonow/rocky.png?branch=master)](https://travis-ci.org/Semjonow/rocky)

Rocky is CoffeeScript Middleware that binds class objects with HTML page elements.
Class objects interact with page elements through Backbone events.

## Installation

Add this line to your application's Gemfile:

    gem 'rocky'

And then execute:

    $ bundle
    $ rails g rocky:install

Last command will add the following lines to file (app/assets/javascripts/application.js):

    //= require underscore
    //= require backbone
    //= require middleware
    //= require application/#{your_application_name}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
