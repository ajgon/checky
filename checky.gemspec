# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'checky/version'

Gem::Specification.new do |gem|
  gem.name          = 'checky'
  gem.version       = Checky::VERSION
  gem.licenses      = ['MIT']
  gem.authors       = ['Igor Rzegocki']
  gem.email         = ['igor@rzegocki.pl']
  gem.description   = 'Dependencies checker for CLI tools'
  gem.summary       = 'Dependencies checker for CLI tools'
  gem.homepage      = 'https://github.com/ajgon/checky'

  gem.files         = Dir['lib/**/*']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
