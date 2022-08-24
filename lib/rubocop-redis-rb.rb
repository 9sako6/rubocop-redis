# frozen_string_literal: true

require 'rubocop'
require_relative "rubocop/redis-rb"
require_relative "rubocop/redis-rb/version"
require_relative "rubocop/redis-rb/inject"

RuboCop::RedisRb::Inject.defaults!

require_relative 'rubocop/cop/redis-rb_cops'
