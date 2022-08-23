# frozen_string_literal: true

require 'rubocop'
require_relative "rubocop/redis-rb/version"
require_relative "rubocop/redis-rb/inject"

module Rubocop
  module RedisRb
    class Error < StandardError; end
    # Your code goes here...
  end
end

RuboCop::RedisRb::Inject.defaults!

require_relative 'rubocop/cop/redis-rb_cops'
