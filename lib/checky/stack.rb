# frozen_string_literal: true
# rubocop:disable Style/ModuleFunction, Style/MethodMissing
module Checky
  module Storage
    extend self
    @data = {}

    def method_missing(name, value = nil)
      string_name = name.to_s
      param_name = string_name.sub(/=$/, '')
      @data[param_name] = value if string_name.end_with?('=')
      @data[param_name]
    end

    def inspect
      @data.inspect
    end
  end
end
# rubocop:enable Style/ModuleFunction, Style/MethodMissing
