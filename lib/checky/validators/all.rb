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

  mod.send(:module_function, :check)
  Checky::Validators::All.send(:define_method, "run_#{child.downcase}") do |*args, &block|
    Checky::Storage.send("#{child.downcase}=", OpenStruct.new(mod.check(*args, &block)))
  end
end
