# Koombea Contact Importer

This is a test project as a part of Koombea tech assessment.

This project uses Ruby v2.7.0  
You also need [Yarn](https://yarnpkg.com/) to be installed
For Sidekiq you should have a Redis server running.

After cloning the repository you should go to project directory and run the command:
```shell
$ bundle install
```
```shell
$ yarn install
```
Then you need to setup your database:
```shell
$ bundle exec rails db:setup
```

You can start this application by running:
```shell
$ bundle exec rails s
```
For background job processing you need to start Sidekiq:
```shell
$ bundle exec sidekiq
```

For login you can use a pre-seeded account:
* **email**: user@example.com,
* **password**: test_TEST_7357

or register your own.

You can generate a test CSV file running:
```shell
$ bundle exec rails r csv_generator.rb
```

