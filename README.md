# Koombea Contact Importer

This is a test project as a part of Koombea tech assessment. You can read the task itself here 

You can try this app here https://koombea-contact-importer.herokuapp.com/

In case you want to run this application locally please read below.
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
then you can access the application on following URL http://localhost:3000

For background job processing you need to start Sidekiq:
```shell
$ bundle exec sidekiq
```

For login you can use a pre-seeded account:
* **email**: user@example.com,
* **password**: test_TEST_7357

or register your own.

You can use test CSV from the "example" directory o you can generate a test CSV file running:
```shell
$ bundle exec rails r csv_generator.rb
```
by default this script will generae 1000 line CSV file, but you can modify this number by providing an ENV variable:
```shell
$ CSV_LINES=200 bundle exec rails r csv_generator.rb
```
