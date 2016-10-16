# Getting started with this project

1. Fork this repository;
2. Clone the project;
3. Install ruby & choose the project's ruby version (you can simply use [RVM]('https://rvm.io/') to do that);
```bash
  rvm install ruby-2.2.3
  rvm use ruby-2.2.3
```
5. Create gemset & switch to it (if you use [RVM]('https://rvm.io/')):
```bash
  rvm gemset sloboda-edu-dashboard
  rvm use sloboda-edu-dashboard
```
6. Install [Bundler]('http://bundler.io/'):
```bash
gem install bundler
```
7. Install gems:
```bash
bundle install
```
8. Rename existing `database.yml.sample` to `database.yml` (it stores the db configs);
9. Make sure that you have PosgreSQL in your machine and it's running;
10. Create new db and run migrations:
``` bash
  rake db:create && rake db:migrate
```
11. Also prepare the test db:
```bash
rake db:test:prepare
```
12. Great! You're ready to run the app. Start rails server:
```bash
rails s
```
13. If you want to make PR, just create new branch & add PR to this origin repository.
