# Data Submission Service Supplier Frontend

This project can be run locally in two ways - with Docker or without. For speed, we recommend running _without_ Docker.

## Running with Docker

See [Running with Docker](docs/running-with-docker.md)

## Without Docker

### Prerequisites

#### DataSubmissionServiceAPI

The [DataSubmissionServiceAPI](https://github.com/dxw/DataSubmissionServiceAPI/) project _must_ be set up and running before attempting to set up this project.

This project uses Postgres, Bundler and Yarn, which will have been installed with DataSubmissionServiceAPI.

### Setting up the project

Copy `.env.development.example` to `.env.development`. This file contains secrets which are not currently available in 1Password - liaise with team members to get the required values.

Once this is done, use Bundler to set up the project:

`$ bundle install`

Create & set up the database:

`$ bundle exec rake db:setup`

Next, copy `.env.test.example` to `.env.test`. This file needs a `SECRET_KEY_BASE` parameter which you can generate with Rake:

`$ rake secret`

Install front-end dependencies:

`$ yarn install`

## Running the tests

To run the rspec tests:

`$ bundle exec rspec`

To run the full test suite - Rubocop, Brakeman and Rspec - before pushing to Github:

`$ bundle exec rake` (the default Rake task)

## Running the application

`$ bundle exec rails s`

The application will run on port 3100 by default

## Release process

The production release process is documented in [RELEASE-PROCESS.md](RELEASE-PROCESS.md).
