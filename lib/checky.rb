# frozen_string_literal: true
require 'ostruct'

require 'core_ext'
require 'checky/version'
require 'checky/exception'
require 'checky/stack'

require 'checky/validators/binary'
require 'checky/validators/version'
require 'checky/validators/all'

require 'checky/checker'

module Checky
  def check(&block)
    Checker.new.check(&block)
  end

  def run(command)
    `#{command}`
  end

  module_function :check, :run
end
