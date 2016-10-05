# frozen_string_literal: true
module Checky
  class Checker
    include Checky::Validators::All

    def initialize
      @self_before_instance_eval = false
    end

    def check(&block)
      @result = true
      @self_before_instance_eval = eval 'self', block.binding
      instance_eval(&block)
    end

    # :reek:BooleanParameter
    def respond_to_missing?(method, _include_private = false)
      methods.include?("run_#{method}".to_sym)
    end

    # rubocop:disable Style/MethodMissing
    def method_missing(method, *args, &block)
      raise Checky::Exception unless methods.include?("run_#{method}".to_sym)
      send("run_#{method}", *args, &block)
      Checky::Storage.send(method).success
    rescue Checky::Exception
      @self_before_instance_eval.send method, *args, &block if @self_before_instance_eval.present?
    end
    # rubocop:enable Style/MethodMissing
  end
end
