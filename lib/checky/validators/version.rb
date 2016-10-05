# frozen_string_literal: true
module Checky
  module Validators
    module Version
      def check(requirement_string)
        version = Gem::Version.new(version_string)
        requirement = Gem::Requirement.new(requirement_string)
        { success: requirement.satisfied_by?(version) }
      end

      def version_string
        command_path = storage.binary.data
        command_output = Checky.run("#{command_path} --version").presence || Checky.run("#{command_path} -v").presence
        command_output[/[0-9]+(?:\.[0-9]+)+/]
      end

      module_function :version_string
    end
  end
end
