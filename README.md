<div align="center">

Greetings! Here is my answer to your API challenge. Please feel free to email me with any questions at jacqwhitmer@gmail.com. Total time spent coding was 2 hours and 6 minutes.

A note on the project:
- I decided not to make a user model for the current user attribute on books. I decided to do this for the interest of time as I knew that creating a user model and having it accessed through books would give me many ideas for new features that I would spend time on despite it being outside of the scope.

</div>
<div align="center">

## Table of Contents
|Links
|--- |
[Tools Used](#tools-used)
[Setup](#setup)
[Goals](#goals)
[Database Schema](#database-schema)
[API Endpoints](#api-endpoints)

</div>

<div align="center">

## Tools Used

[<img alt="Ruby On Rails" src="https://img.shields.io/badge/RubyOnRails-flat--square?logo=ruby-on-rails&style=for-the-badge&color=black"/>](https://rubyonrails.org/)

[<img alt="Git" src="https://img.shields.io/badge/Git-flat--square?logo=git&style=for-the-badge&color=black"/>](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)

[<img alt="PostgreSQL" src ="https://img.shields.io/badge/Postgres-flat--square?logo=postgres&style=for-the-badge&color=black"/>](https://www.postgresql.org/)

[<img alt="RSpec" src ="https://img.shields.io/badge/RSpec-flat--square?logo=rspec&style=for-the-badge&color=black"/>](https://github.com/rspec/rspec-rails)

</div>

<div align="center">

## Setup

</div>


  This project requires PostgreSQL, Ruby 2.7.2, Rails 6.1.4, and bundler

  * Fork this repository
  * From the command line, install dependencies and set up your DB:
      * `bundle install`
      * `bundle update`
      * `rails db:{drop,create,migrate,seed}`
  * Run the test suite with `rspec`
  * Run your development server with `rails s` to see the app in action.

<div align="center">

## Goals

</div>

Design a single JSON API endpoint that returns basic information about what books a specific library has and at least one test against that endpoint. Some more requirements here:
  - each library has a limited selection of books
  - each book can be checkout out or available
  - each book in the response should indicate if they are available or, if they are checked out, have some reference back to the user who checked them out

## Database Schema

<img src="https://user-images.githubusercontent.com/78382113/152385958-13820deb-3a9a-404e-a5c3-0edb8ef1688f.png">

</div>


## API Endpoints

<div align="left">

* GET to `/api/v1/libraries/:id/books`
 - returns the following body:
 ```
   {
    [
      {
        "id": "id",
        "library_id": "library_id",
        "author": "author",
        "title": "title",
        "status": "status"
        "current_user": "user"
        "created_at": "timestamp"
        "updated_at": "timestamp"
      },
      {
        "id": "id",
        "library_id": "library_id",
        "author": "author",
        "title": "title",
        "status": "status"
        "current_user": "user"
        "created_at": "timestamp"
        "updated_at": "timestamp"
      },
      {
        "id": "id",
        "library_id": "library_id",
        "author": "author",
        "title": "title",
        "status": "status"
        "current_user": "user"
        "created_at": "timestamp"
        "updated_at": "timestamp"
      }...
    ]
  }
 ```
  - Optional query params include: `?status=` and `?current_user=`
    - `?status=` can be either `available` or `checkedout` and any other value will return a 400 status and error message
      - This can show all of the available books or all of the books that are checked out
    - `?current_user=` can be any user number or `Library` if there are no books with that user, it will return a 400 status with an error saying so
      - This will return all books with a current user that matches the search input
  - The default sort of the books returned by this endpoint will be asc by book title regardless of status or current_user
