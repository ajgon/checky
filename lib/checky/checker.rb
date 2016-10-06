# frozen_string_literal: true
module Checky
  class Checker
    include Checky::Validators::All

    attr_reader :storage

    def initialize
      @storage = OpenStruct.new
      @self_before_instance_eval = false
    end

    def check(&block)
      @self_before_instance_eval = eval 'self', block.binding
      instance_eval(&block)
      result = check_result
      raise Checky::ValidationError if @storage.fail_hard && !result
      result
    end

    # :nocov:
    # :reek:BooleanParameter
    def respond_to_missing?(method, _include_private = false)
      methods.include?("run_#{method}".to_sym)
    end
    # :nocov:

    # rubocop:disable Style/MethodMissing
    def method_missing(method, *args, &block)
      raise Checky::Exception unless methods.include?("populate_#{method}".to_sym)
      @storage.send("#{method}=", send("populate_#{method}", *args, &block))
    rescue Checky::Exception
      @self_before_instance_eval.send method, *args, &block if @self_before_instance_eval.present?
    end
    # rubocop:enable Style/MethodMissing

    private

    def check_result
      @storage.to_h.keys.all? do |validator_name|
        send("check_#{validator_name}")
      end
    end
  end
end
