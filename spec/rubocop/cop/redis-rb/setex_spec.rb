# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Redis::Setex, :config do
  it 'registers an offense when calling both `set`` and `expire` in a `multi` transaction' do
    expect_offense(<<~RUBY)
      redis.multi do
      ^^^^^^^^^^^^^^ Use `setex` method instead of calling both `set` and `expire` methods in a transaction.
        redis.set(key, 'foobarbaz')
        redis.expire(key, 1.day.to_i)
      end

      redis.multi do
      ^^^^^^^^^^^^^^ Use `setex` method instead of calling both `set` and `expire` methods in a transaction.
        redis.set(key, 'foobarbaz')
        puts 'hello'
        redis.expire(key, 1.day.to_i)
      end
    RUBY
  end

  it 'does not register an offense when calling only `set` in a `multi` transaction' do
    expect_no_offenses(<<~RUBY)
      redis.multi do
        redis.set(key, 'foobarbaz')
      end
    RUBY
  end

  it 'does not register an offense when calling only `expire` in a `multi` transaction' do
    expect_no_offenses(<<~RUBY)
      redis.multi do
        redis.expire(key, 1.day.to_i)
      end
    RUBY
  end

  it 'does not register an offense when calling both `set` and `expire` outside a transaction' do
    expect_no_offenses(<<~RUBY)
      redis.set(key, 'foobarbaz')
      redis.expire(key, 1.day.to_i)
    RUBY
  end
end
