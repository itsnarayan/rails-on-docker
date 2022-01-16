# Lead operation engineer take-home assignment

## Overview

**The task is to:**

This rails application was running with Postgres 9.6 on manually managed EC2 instance and RDS.

But we need to shift more modern way to manage infrastructure and one possible option is docker-compose environment.

You need to prepare Rails web application in local docker-compose environment with your own design.

**Requirements:**

1. Production grade design. Your design should able to use it as production environment without huge modification.
2. Lastest version of Postgres database. Suggesting to use v13.
3. Atlest 10 numbers of simultaneous HTTP request should be processed at sime time. Some of them could be long running process.
4. Endpoint should be protected by SSL certificate (it is okay to use self signed certificate).
5. Identify any issue which you found and fix it.

**What will be valued:**

1. Automation, minimum human intervention.
2. Usage of modern practices.
3. Problem solving skills.

**Expected output:**

1. Dockerfile file which able to run with `docker run` command.
2. docker-compose.yml which able to run with `docker-compose up` command.
3. Document that explain your design and how to run it in local env (document.md, picture, workflow, script etc )

## How to run this application
1. Install Ruby version 2.7.2 or use docker image which support Ruby 2.7
2. Create `.env.production` file with following ENV variables right under (same dir with .env.development) this project.

```bash
   RAILS_ENV=production
   RDS_HOST='localhost' # PostgreSQL 9.6 database url
   RDS_USER='' # Set your database username
   RDS_PASSWORD='' # Seet your database password
   PERFORMANCE_SECRET='8b323028e2e26e904b547824c369b1d4'
```

3. Install required libaries with following command

```bash
bundle install
```

4. Create database table and schema

   * `bundle exec rails db:create` - this command will connect to your PosgreSQL Database and execute commands that create databases for application
      If you get any error please check your ENV variables for database which mentioned in #2.
   * `bundle exec rails db:migrate` - this command will load SQL schema (db/structure.sql) to database.
   * `bundle exec rails db:seed` - this command will create test data into your database.

5. Build static files for production environment

```bash
   bundle exec rake assets:precompile # Will build all static files
```

6. Run application

```bash
   bundle exec rails server
```


## How to test your application
1. `<URL>/companies` - endpoint will render all data from Companies table.
2. `<URL>/users` - endpoint will render all data from Users table.
3. `<URL>/companies/all` - endpoint will render all data from Users and Companies tables.

## Hint
1. You can use any existing script and dockerfiles if you need.
2. You can decide design of infrastructure by yourself.
3. You can remove and edit any files from this project if you need.
