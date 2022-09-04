# rubocop-redis

An extension of RuboCop for [redis/redis-rb](https://github.com/redis/redis-rb) Redis client.

## Documentation

You can read a lot more about rubocop-redis in its [docs](docs/modules/ROOT/pages/cops_redis.adoc).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-redis'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubocop-redis

## Usage

You need to tell RuboCop to load the Redis extension. There are three
ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-redis
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-redis
```

Now you can run `rubocop` and it will automatically load the rubocop-redis
cops together with the standard cops.

### Command line

```bash
rubocop --require rubocop-redis
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-redis'
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/9sako6/rubocop-redis.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
