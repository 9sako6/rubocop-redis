# frozen_string_literal: true

require 'yard'
require 'rubocop'
require_relative '../lib/rubocop-redis'
require 'rubocop/cops_documentation_generator'

YARD::Rake::YardocTask.new(:yard_for_generate_documentation) do |task|
  task.files = ['lib/rubocop/cop/**/*.rb']
  task.options = ['--no-output']
end

task update_cops_documentation: :yard_for_generate_documentation do
  deps = ['Redis']

  # NOTE: Update `<<next>>` version for docs/modules/ROOT/pages/cops_redis.adoc
  # when running release tasks.
  RuboCop::Redis::Inject.defaults!

  CopsDocumentationGenerator.new(departments: deps).call
end
