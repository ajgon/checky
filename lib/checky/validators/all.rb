# frozen_string_literal: true
module Checky
  module Validators
    module All
    end
  end
end

Checky::Validators.constants.each do |child|
  next if child == :All
  mod = Checky::Validators.const_get(child)

  next unless mod.is_a?(Module)
  Checky::Validators::All.include(mod)

  mod.send(:attr_accessor, :storage)
  mod.send(:module_function, :storage, :storage=)
  %w(populate check).each do |method|
    mod.send(:module_function, method) if mod.method_defined?(method)
  end

  Checky::Validators::All.send(:define_method, "populate_#{child.to_s.underscore}") do |*args, &block|
    validator = Object.const_get("Checky::Validators::#{child}")
    data = validator.respond_to?(:populate) ? validator.populate(*args, &block) : true
    @storage.send("#{child.to_s.underscore}=", data)
  end

  Checky::Validators::All.send(:define_method, "check_#{child.to_s.underscore}") do
    validator = Object.const_get("Checky::Validators::#{child}")
    validator.storage = @storage
    validator.respond_to?(:check) ? validator.check : true
  end
end
