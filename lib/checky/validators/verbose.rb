# frozen_string_literal: true
module Checky
  module Validators
    module Verbose
      # :reek:ManualDispatch
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
        stream = result ? $stdout : $stderr

        stream.puts("#{build_message(mod, key)} #{result_message(key)}")
      end

      def build_message(mod, key)
        value = storage.send(key)

        # :nocov:
        message = begin
          mod.message(value)
        rescue
          "Checking #{key} (#{value})"
        end
        # :nocov:
        format_message(message, key)
      end

      def format_message(message, key)
        key_size = key.to_s.size

        "#{message[0..(65 - key_size)].ljust(67 - key_size, '.')}[#{key.capitalize}]"
      end

      def result_message(key)
        result = storage.checky_results[key]

        if Checky.colorize
          result ? 'OK'.green : 'FAIL'.red
        else
          result ? 'OK' : 'FAIL'
        end
      end

      module_function :display_message, :build_message, :format_message, :result_message
    end
  end
end
