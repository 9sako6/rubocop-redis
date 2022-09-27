# frozen_string_literal: true

module RuboCop
  module Cop
    module Redis
      # Use `setex` method instead of calling both `set` and `expire` methods in a transaction.
      # See https://redis.io/commands/setex/ for details.
      #
      # @example
      #   # bad
      #   redis.multi do
      #     redis.set(key, value)
      #     redis.expire(key, 120)
      #   end
      #
      #   # good
      #   redis.setex(key, 120, value)
      #
      class Setex < Base
        MSG = "Use `setex` method instead of calling both `set` and `expire` methods in a transaction."

        def_node_matcher :multi_block?, <<~PATTERN
          (block $(send ... :multi) args (begin $...))
        PATTERN

        def_node_matcher :match_set_call?, <<~PATTERN
          (send ($...) :set ...)
        PATTERN

        def_node_matcher :match_expire_call?, <<~PATTERN
          (send ($...) :expire ...)
        PATTERN

        RESTRICT_ON_SEND = %i[sets expire].freeze

        def on_block(node)
          return unless multi_block?(node)
          return unless match_set_and_expire_in_multi_block?(node)

          add_offense(node)
        end

        private

        def match_set_and_expire_in_multi_block?(node)
          _, statements = multi_block?(node)
          result = false
          called_set = false

          statements.each do |statement|
            called_set = true if match_set_call?(statement)

            result = true if called_set && match_expire_call?(statement)
          end

          result
        end
      end
    end
  end
end
