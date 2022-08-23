# frozen_string_literal: true

module RuboCop
  module Cop
    module RedisRb
      # This cop detects the use of `KEYS` query that should be noted when used in a production environment.
      class NotKeys < Base
        MSG = "Do not use `.keys`. It may ruin performance when it is executed against large databases. See https://redis.io/commands/keys/ for details."

        def_node_matcher :keys_call?, <<~PATTERN
          (send
            (send
              (const {cbase nil?} :Redis) :current) :keys $...)
        PATTERN

        def on_send(node)
          return unless keys_call?(node)

          add_offense(node)
        end
      end
    end
  end
end
