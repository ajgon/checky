# frozen_string_literal: true
module Checky
  module Validators
    module Binary
      # :reek:UtilityFunction
      def check(command)
        binary_path = command.which

        {
          success: !binary_path.to_s.empty?,
          data: binary_path
        }
      end
    end
  end
end
