# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Redis::NotKeys, :config do
  it 'registers an offense when calling `keys` for `Redis.new`' do
    expect_offense(<<~RUBY)
      Redis.new.keys
      ^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.new.keys("pattern-*")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.new.keys(pattern)
      ^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.new(host: "10.0.1.1", port: 6380, db: 15).keys(pattern)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
    RUBY
  end

  it 'registers an offense when calling `keys` for `Redis.current`' do
    expect_offense(<<~RUBY)
      Redis.current.keys
      ^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.current.keys("pattern-*")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.current.keys(pattern)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.current.keys(Foo.pattern('prefix'))
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
    RUBY
  end

  it 'registers an offense when calling `keys` for an object named `redis`' do
    expect_offense(<<~RUBY)
      redis.keys
      ^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      redis.keys("pattern-*")
      ^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      redis.keys(pattern)
      ^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      redis.keys(Foo.pattern('prefix'))
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
    RUBY
  end

  it 'does not register an offense when calling `Hash#keys`' do
    expect_no_offenses(<<~RUBY)
      {}.keys
    RUBY
  end

  it 'does not register an offense when calling `keys` for a const not named Redis' do
    expect_no_offenses(<<~RUBY)
      Foo.current.keys
      Foo.new.keys
    RUBY
  end

  it 'does not register an offense when calling `keys` for an object not named redis' do
    expect_no_offenses(<<~RUBY)
      hash.keys
      foo.bar.keys
    RUBY
  end
end
