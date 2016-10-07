# frozen_string_literal: true
# :reek:TooManyStatements
module CheckySpecHelpers
  def silence_streams
    @original_stderr = $stderr
    @original_stdout = $stdout

    $stderr = $stdout = StringIO.new

    yield

    $stderr = @original_stderr
    $stdout = @original_stdout
    @original_stderr = nil
    @original_stdout = nil
  end
end
