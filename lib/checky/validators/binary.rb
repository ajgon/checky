# frozen_string_literal: true
module Checky
  module Validators
    module Binary
      # :reek:UtilityFunction
      def check
        !storage.binary.which.to_s.empty?
      end

      # :reek:UtilityFunction
      def message
        "Checking for #{storage.binary}"
      end
    end
  end
end
