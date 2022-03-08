[![Gem Version](https://badge.fury.io/rb/alpaca-news-api.svg)](https://badge.fury.io/rb/alpaca-news-api)
[![License MIT](https://img.shields.io/github/license/lukaszsliwa/alpaca-news-api)](https://github.com/lukaszsliwa/alpaca-news-api/blob/master/LICENSE)

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

# REST API
page = 0
Alpaca::News::Api::HistoricalNews.where(symbols: 'SVM,GOLD,NEM', limit: 50).find_in_batches do |objects|
  break if (page += 1) >= 5
  objects.each { |object| puts "[#{object.id}] #{object.headline}" }
end

# Realtime API
Alpaca::News::Api::RealtimeNews.stream('SVM,GOLD,NEM') do |event|
  puts "[#{event.object.symbols.join(',')}] #{event.object.headline}"
end
```

## REST API

### Available parameters

For more details please check documentation

```ruby
params = {
  symbols: 'GOLD,GDX,GDXJ',
  start: '01-01-2020',
  end: '01-01-2021',
  limit: 50,
  sort: 'DESC',
  include_content: false,
  exclude_contentless: false
}
Alpaca::News::Api::HistoricalNews.where(params).recent
```

### Available methods

You can fetch news using various of methods:

```ruby
params = { symbols: 'SVM,GOLD,NEM', limit: 50 }

Alpaca::News::Api::HistoricalNews.where(params).all
Alpaca::News::Api::HistoricalNews.where(params).find_each { |object| puts object.headline }
Alpaca::News::Api::HistoricalNews.where(params).find_in_batches do |objects|
  objects.each { |object| puts object.headline }
end

# Alternatives to Alpaca::News::Api::HistoricalNews.where(params).all
Alpaca::News::Api::HistoricalNews.where(params).recent
Alpaca::News::Api::HistoricalNews.where(params).query
Alpaca::News::Api::HistoricalNews.where(params).search
Alpaca::News::Api::HistoricalNews.where(params).lookup
Alpaca::News::Api::HistoricalNews.where(params).get
Alpaca::News::Api::HistoricalNews.where(params).find_all

```

## Realtime API

```ruby
symbols = ['GDX']

Alpaca::News::Api::RealtimeNews.stream(symbols) do |event|
  puts "[#{event.object.symbols.join(',')}] #{event.object.headline}"
end
```

### Available parameters

```ruby
options = { key: Alpaca::News::Api.configure.key_id, secret: Alpaca::News::Api.configure.secret_key }

Alpaca::News::Api::RealtimeNews.stream(:all, options) do |event|
  puts event.object.headline
end
```

or

```ruby
options = { key: Alpaca::News::Api.configure.key_id, secret: Alpaca::News::Api.configure.secret_key }

Alpaca::News::Api::RealtimeNews.stream(:all, options) do |event|
  event.objects.each { |object| puts object.headline }
end
```

### Available methods

```ruby
symbols = %w[GOLD OXY GDX GDXJ]

Alpaca::News::Api::RealtimeNews.run(symbols) { |event| puts event.object.headline }
Alpaca::News::Api::RealtimeNews.stream(symbols) { |event| puts event.object.headline }
Alpaca::News::Api::RealtimeNews.subscribe(symbols) { |event| puts event.object.headline }
Alpaca::News::Api::RealtimeNews.watch(symbols) { |event| puts event.object.headline }

realtime_news = Alpaca::News::Api::RealtimeNews.new
realtime_news.on_error do |event|
  puts event.message
end
realtime_news.on_close do
  # ...
end
```

## Available News object attributes

```ruby
> news = Alpaca::News::Api::HistoricalNews.where(params).recent.first
> news.attributes.keys.each { |key| puts key }

id
content
headline
author
created_at
updated_at
summary
url
images
symbols
source

```

## Working with Alpaca News Realtime API websockets

```bash
$ wscat -c wss://stream.data.alpaca.markets/v1beta1/news
Connected (press CTRL+C to quit)
> {"action": "auth", "key": "<KEY>", "secret": "<SECRET>"}
> {"action": "subscribe", "news": ["*"]}
> {"action": "unsubscribe", "news": ["*"]}
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
