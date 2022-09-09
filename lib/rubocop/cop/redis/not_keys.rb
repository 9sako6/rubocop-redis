# frozen_string_literal: true

module RuboCop
  module Cop
    module Redis
      # This cop detects the use of `KEYS` query that should be noted when used in a production environment.
      # Consider using `SCAN` query instead of `KEYS` query.
      # See https://redis.io/commands/keys/ for details.
      #
      # To avoid detecting `Hash#keys` calling, this cop adds an offense only if a receiver of `keys` method is named `redis`.
      #
      # @example
      #   # bad
      #   redis.keys("pattern-*")
      #
      #   # bad
      #   Redis.new.keys("pattern-*")
      #
      #   # good
      #   cursor = 0
      #   all_keys = []
      #   loop do
      #     cursor, keys = redis.scan(cursor, match: "pattern-*")
      #     all_keys += keys
      #     break if cursor == "0"
      #   end
      #   all_keys
      #
      class NotKeys < Base
        MSG = "Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details."

        def_node_matcher :keys_call?, <<~PATTERN
          (send
            (send
              (const {cbase nil?} :Redis) {:new | :current} ...) :keys ...)
        PATTERN

        def_node_matcher :keys_call_for_object?, <<~PATTERN
          (send ($...) :keys ...)
        PATTERN

        RESTRICT_ON_SEND = %i[keys].freeze

        def on_send(node)
          return unless keys_call?(node) || keys_call_for_object_named_redis?(node)

          add_offense(node)
        end

        private

        def keys_call_for_object_named_redis?(node)
          receiver, message = keys_call_for_object?(node)

          receiver.nil? && message == :redis
        end
      end
    end
  end
end
