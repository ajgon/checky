# frozen_string_literal: true
module Checky
  module Validators
    # :reek:ManualDispatch
    module Verbose
      def after
        storage.to_h.keys.each do |key|
          next if key.to_s.start_with?('checky_')

          mod = Object.const_get("Checky::Validators::#{String(key).classify}")
          next unless mod.respond_to?(:check)

          display_message(mod, key)
        end
      end

      def display_message(mod, key)
        result = storage.checky_results[key]

        (result ? $stdout : $stderr).puts "#{build_message(mod, key).ljust(60, '.')} #{result ? 'OK' : 'FAIL'}"
      end

      def build_message(mod, key)
        value = storage.send(key)

        begin
          mod.message(value)
        rescue
          "Checking #{key} (#{value})"
        end
      end

      module_function :display_message, :build_message
    end
  end
end
