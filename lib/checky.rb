# frozen_string_literal: true
require 'ostruct'

require 'core_ext'
require 'checky/version'
require 'checky/exception'

require 'checky/validators/binary'
require 'checky/validators/version'
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
