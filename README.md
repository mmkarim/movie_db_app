# Movie DB

Live demo: https://railsmoviedb.herokuapp.com/

User Credentials:

email: admin@movie.com, password: 123456

(or just sign up)


# Gem / Technology used

1. PostgreSQL as database
2. react-rails gem
3. jwt gem for front-end authentication
4. Rspec for test
5. Devise gem
6. and more...


# Project Structure

1. React components are residing inside `app/assets/javascripts/components/`
2. "movie_search.rb" service object for facet and text search `app/services/`
3. "auth.rb" for jwt decode & encoding `app/lib/`
4. Model and Controller test can be found inside `spec/` folder


# TODO / Pending
1. Front-end testing using jasmine
