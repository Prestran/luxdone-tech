# README

To run the application run the:

`bundle install`

We won't be needing any database so we can skip all the steps with it. The command:

`rails s -b 0.0.0.0 -p 3000`

should be working now, although it may require some webpacker, in that case run: `bundle exec rails webpacker:install`

Now you should have a working app, to test it you can use something like Postman to try tu request for example: `GET http://localhost:3001/nbp/gbp/2012-01-01/2012-01-31/`

To run tests simply write: `rspec`  while being in main catalogue of a project.