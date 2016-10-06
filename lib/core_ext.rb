# frozen_string_literal: true
module CoreExt
end

class Object
  # :reek:ManualDispatch
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end

  def presence
    self if present?
  end
end

class String
  def which
    bin_path = ENV['PATH'].split(File::PATH_SEPARATOR).find do |path|
      file = File.join(path, self)
      File.exist?(file) && File.executable?(file)
    end
    bin_path ? File.join(bin_path, self) : nil
  end

  # :reek:TooManyStatements
  def underscore
    return self unless self =~ /[A-Z-]|::/
    word = to_s.gsub('::', '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    word.tr('-', '_').downcase
  end
end
