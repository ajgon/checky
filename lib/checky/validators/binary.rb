# frozen_string_literal: true
module Checky
  module Validators
    module Binary
      # :reek:UtilityFunction
      def populate(command)
        command.which.to_s
      end

      def check
        !storage.binary.empty?
      end

      # :reek:UtilityFunction
      def message(value)
        "Checking for #{File.basename(value)}"
      end
    end
  end
end
