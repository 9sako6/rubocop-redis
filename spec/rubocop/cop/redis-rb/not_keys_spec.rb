# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RedisRb::NotKeys, :config do
  it 'registers an offense when using `.keys`' do
    expect_offense(<<~RUBY)
      Redis.current.keys
      ^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.current.keys("pattern-*")
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
      Redis.current.keys(pattern)
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^ Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details.
    RUBY
  end

  it 'does not register an offense when calling `Hash#keys`' do
    expect_no_offenses(<<~RUBY)
      {}.keys
    RUBY
  end
end
