# frozen_string_literal: true
module Checky
  module Validators
    module FailHard
      def after
        raise Checky::ValidationError if storage.fail_hard && !storage.checky_final_result
      end
    end
  end
end
