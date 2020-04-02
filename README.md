# Brownfield Of Dreams

### About Brownfield Of Dreams

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

### Set Up Instructions

First you'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

To setup BrownFieldOfDreams locally, run the following commands:

`git clone https://github.com/adumortier/brownfield-of-dreams`

`brownfield-of-dreams`

`bundle install`

`bundle update`

`rails db:{drop,create,migrate,seed}`

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

Create a new heroku app and connect to your local `BrownFieldOfDreams` repository with:

`heroku git:remote -a your_heroku_app_name`

Deploy `BrownFieldOfDreams` from heroku.

The original repository of the `BrownFieldOfDreams` project can be found at:

https://github.com/turingschool-examples/brownfield-of-dreams


## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
