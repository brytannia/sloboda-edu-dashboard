# Sloboda EDU

## About

This repo represents [the front-page of Sloboda EDU project](https://sloboda-edu-dashboard.herokuapp.com)

## Getting started

1. Install ruby & choose the project's ruby version (you can simply use [RVM](https://rvm.io/) to do that):

  ```bash
    rvm install ruby-2.2.3
  ```
  ```bash
    use ruby-2.2.3
  ```
  
2. Create gemset & switch to it (if you use [RVM](https://rvm.io/)):
  
  ```bash
    rvm gemset sloboda-edu-dashboard
  ```
  ```bash
    rvm use sloboda-edu-dashboard
  ```
  
3. Install [Bundler](http://bundler.io/):

  ```bash
    gem install bundler
  ```
  
4. Install gems:

  ```bash
    bundle install
  ```

5. Rename existing `database.yml.sample` to `database.yml` (it stores the db configs);
6. Make sure that you have PosgreSQL in your machine and it's running;
7. Create new db and run migrations:

  ``` bash
    rake db:create && rake db:migrate
  ```

8. Also prepare the test db:

  ```bash
    rake db:test:prepare
  ```

9. Great! You're ready to run the app. Start rails server:

  ```bash
    rails s
  ```

## Contributing

1. Fork this repository;
2. Clone the project;
3. Bug reports and pull requests(PR) are welcome on GitHub at https://github.com/brytannia/sloboda-edu-dashboard. Just create new branch & add PR to this origin repository.

## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
