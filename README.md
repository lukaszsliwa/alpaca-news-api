# Alpaca::News::Api

Provides a way to fetch and filter historical news using Alpaca News API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alpaca-news-api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install alpaca-news-api

## Usage

```ruby
require 'dotenv'
require 'alpaca-news-api'

Dotenv.load('./.env')

Alpaca::News::Api.configure do |config|
  config.key_id = ENV.fetch('ALPACA_API_KEY_ID')
  config.secret_key = ENV.fetch('ALPACA_API_SECRET_KEY')
end

page = 0
Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM', limit: 50).find_in_batches do |objects|
  break if (page += 1) >= 5
  objects.each { |object| puts "[#{object.id}] #{object.headline}" }
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec/` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lukaszsliwa/alpaca-news-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lukaszsliwa/alpaca-news-api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Alpaca::News::Api project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lukaszsliwa/alpaca-news-api/blob/master/CODE_OF_CONDUCT.md).
