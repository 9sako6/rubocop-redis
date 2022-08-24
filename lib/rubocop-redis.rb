# frozen_string_literal: true

require 'rubocop'
require_relative "rubocop/redis"
require_relative "rubocop/redis/version"
require_relative "rubocop/redis/inject"

RuboCop::Redis::Inject.defaults!

require_relative 'rubocop/cop/redis_cops'
