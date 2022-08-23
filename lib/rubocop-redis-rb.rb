# frozen_string_literal: true

require 'rubocop'
require_relative "rubocop/redis-rb/version"

module Rubocop
  module RedisRb
    class Error < StandardError; end
    # Your code goes here...
  end
end

require_relative 'rubocop/cop/redis-rb_cops'
