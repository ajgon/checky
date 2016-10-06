# frozen_string_literal: true
require 'ostruct'

require 'core_ext'
require 'checky/version'
require 'checky/exceptions'

validators = Dir[File.expand_path('../checky/validators/*.rb', __FILE__)].map do |file|
  File.basename(file).sub(/\.rb$/, '')
end
validators.reject! { |file| file == 'all' }

validators.each do |validator|
  require "checky/validators/#{validator}"
end
require 'checky/validators/all'

require 'checky/checker'

module Checky
  def check(&block)
    Checker.new.check(&block)
  end

  # :nocov:
  def run(command)
    `#{command}`
  end
  # :nocov:

  module_function :check, :run
end
