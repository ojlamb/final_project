![alt tag](https://travis-ci.org/Kyvyas/final_project.svg)    ![Coverage Status](https://coveralls.io/repos/Kyvyas/final_project/badge.svg?branch=adding-cover&service=github)

##TeemApp
---
For our final project at Makers Academy we decided to build a community sourced
activity finder and organizer application.

####Live Demo
http://teemapp.herokuapp.com

####To run locally and test
```
git clone https://github.com/ojlamb/final_project
cd final_project
bundle install
bin/rake db:create
bin/rake db:create RAILS_ENV=test
bin/rake db:migrate
bin/rake db:seed
bin/rails s
```

to run tests:
```
rspec
```

##User Stories

```
As a new User
In order to join the community
I would like to sign up
```

```
As an active user of the app
In order to see my activities
I would like to sign in
```

```
As an active user of the app
In order to leave the app safely
I would like to sign out
```

```
As an active person
In order to do more
I would like to find activities
```

```
As a busy person
In order to find activities I can go to
I would like to see those taking place near me
```

```
As an organized person
In order to plan my activities
I would like to see them arranged by time
```

```
As an activity organizer
In order to gather enough people
I would like to post an activity
```

```
As a potential user
In order In order to join an activity
I would like to inform the organizer than "I'm in!"
```

```
As an activity organizer
In order to get the right number people for the activity
I would like to specify the number of participants required
```
```
As an activity organizer
In order to let people know where my activity is
I would like to place a pin on a map exactly where it will take place
```

```
As an activity organizer
In order to help the community
I would like to rate participants based on reliability
```

```
As an activity participant
In order to help the community
I would like to rate the activity
```

####Technology used
* Ruby on Rails
* Javascript and JQuery
* PostgreSQL
* Action Mailer for email notifications
* Bootstrap + Custom CSS
* Paperclip with AWS for photo storage
* Mapbox and Leaflet JavaScript APIs for Mapping
* Rspec, Capybara, TimeCop, Factory Girl for testing

####Challenges
* Considering time was a major obstacle - hiding activities after they have taken
place, but saving them into the database to allow users to give them a rating.
* Allowing users to update the activity location on the confirmation page was very tricky.
The solution was very streamlined, we used a geocoder to get an initial location, enabled
the pin to be dragged and dropped, reverse geocoded the new location and used JavaScript
to update the form - all in real-time
* Constructing the database model accurately - We had to use a has and belongs to many
relationship between User, Activities, and Attendees.
