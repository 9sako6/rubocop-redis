# frozen_string_literal: true

module RuboCop
  module Redis
    # Because RuboCop doesn't yet support plugins, we have to monkey patch in a
    # bit of our configuration.
    module Inject
      def self.defaults!
        project_root = Pathname.new(__dir__).parent.parent.parent.expand_path
        config_default = project_root.join('config', 'default.yml')
        path = config_default.to_s
        hash = ConfigLoader.send(:load_yaml_configuration, path)
        config = RuboCop::Config.new(hash, path)
        puts "configuration from #{path}" if ConfigLoader.debug?
        config = ConfigLoader.merge_with_default(config, path)
        ConfigLoader.instance_variable_set(:@default_configuration, config)
      end
    end
  end
end
