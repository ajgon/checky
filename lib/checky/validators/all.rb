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
  mod.send(:module_function, :populate, :check, :storage, :'storage=')

  Checky::Validators::All.send(:define_method, "populate_#{child.downcase}") do |*args, &block|
    validator = Object.const_get("Checky::Validators::#{child}")
    @storage.send("#{child.downcase}=", validator.populate(*args, &block))
  end

  Checky::Validators::All.send(:define_method, "check_#{child.downcase}") do
    validator = Object.const_get("Checky::Validators::#{child}")
    validator.storage = @storage
    validator.check
  end
end
