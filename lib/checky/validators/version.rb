# frozen_string_literal: true
module Checky
  module Validators
    module Version
      def populate(requirement_string)
        requirement_string
      end

      def check
        version = Gem::Version.new(version_string)
        requirement = Gem::Requirement.new(storage.version)
        requirement.satisfied_by?(version)
      end

      def version_string
        command_path = storage.binary
        command_output = Checky.run("#{command_path} --version 2>&1").presence ||
                         Checky.run("#{command_path} -v 2>&1").presence
        command_output[/[0-9]+(?:\.[0-9]+)+/]
      end

      def message(value)
        "Checking #{File.basename(storage.binary)} version against #{value}"
      end

      module_function :version_string
    end
  end
end
