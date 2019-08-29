# Data Submission Service Supplier Frontend

A Rails frontend that allows suppliers to sign-in and make submissions for their outstanding tasks for frameworks they are apart of.

[Data is retrieved from an API](https://github.com/dxw/DataSubmissionServiceAPI/).

---

### Prerequisites

- [Docker](https://docs.docker.com/docker-for-mac) greater than or equal to `18.03.1-ce-mac64 (24245)`
- Access to the dxw 1Password vault named `DSS` can be granted by anyone on the dxw technical operations team
- The [API](https://github.com/dxw/DataSubmissionServiceAPI) must be running locally before starting this application or you will see a Docker networking error

### Setting up the project

Copy the example environment variable file used with Docker:

```bash
$ cp docker-compose.env.sample docker-compose.env
```

From the 1Password vault, copy the contents of a file named `Docker Compose - Frontend - docker-compose.env` into the new `docker-compose.env` file. This file should contain no further additions to get started.

The most common command used to start all containers. It does database set up if required and leaves you on an interactive prompt within the rails server process where `pry` can be used for debugging:

```bash
$ bin/dstart
```

If you'd like to see all logs, like `Postgres` you can use the conventional docker-compose command - you will lose the ability to use `pry`:

```bash
$ docker-compose up
```

If you'd like to shut all containers down, and remove database information persisted in `docker volumes` you can run the following command which rebuilds everything from scratch:

```bash
$ bin/drebuild
```

---

## Running the tests

Because the setup and teardown introduces quite some latency, we use the spring service to
start up all dependencies in a docker container. This makes the test run faster.

Get the test server up and running behind the scenes:

```bash
$ bin/dtest-server up
```

Run all the RSpec tests:

```bash
$ bin/dspec spec
```

When no arguments are specified, the default rake task is executed. This runs other tests such as `Rubocop` for linting and `brakeman` for static code analysis.

You can use pass arguments as you normally would to RSpec through this script, to run a single test for example you can use `bin/dspec spec/features/task_management_spec.rb:1`

To stop the test server from running in the background:

```bash
$ bin/dtest-server down
```

---

## Managing gems

When making changes to the Gemfile we should use Docker too in order to ensure we use a consistent version of Bundler:

```bash
$ docker-compose run --rm web bundle
```

The Bundler version in the Gemfile.lock should remain unchanged unless part of a deliberate update.

```
BUNDLED WITH
  2.0.1
```

---

## Deployments

Documentation on how deployments are managed for the RMI service as a whole are documented within the [service manual](https://crown-commercial-service.github.io/ReportMI-service-manual/#/deployments).
