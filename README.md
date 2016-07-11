# Movie App
A Sample MovieApp with Braintree Payement Integration

### Getting started
This app uses Redis so make sure you have redis installed and is up & running

### To try this out on your machine 
- Clone the app
- run `bundle install`
- Create a braintree sandbox account here `https://www.braintreepayments.com/`
- Run `rails generate figaro:install` 
This will create a config/application.yml file and will automatically add it to your .gitignore list 
- Add your braintree configuration credentials in the config file 

### Braintree configuration keys
BRAINTREE_MERCHANT_ID: 'your braintree merchant id'

BRAINTREE_PUBLIC_KEY: 'your braintree public key'

BRAINTREE_PRIVATE_KEY: 'your braintree private key'

### Importing sample movie data into your app
There's a movies.csv file inside the db folder, to import this into your database just 
open the rails console `rails console` and then type

`require 'csv'` 

```ruby 
CSV.foreach(Rails.root.join("db/movies.csv"), headers: true) do |row|
  Movie.find_or_create_by(title: row[0], release_year: row[1], price: row[2], description: row[3], imdb_id: row[4], poster_url: row[5])
end
```
When you're done just fire up your rails app `rails server` 
