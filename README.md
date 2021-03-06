# checky.gem

[![Gem](https://img.shields.io/gem/v/checky.svg?maxAge=2592000)](https://github.com/ajgon/checky)
[![Build Status](https://travis-ci.org/ajgon/checky.svg?branch=master)](https://travis-ci.org/ajgon/checky)
[![Coverage Status](https://coveralls.io/repos/github/ajgon/checky/badge.svg?branch=master)](https://coveralls.io/github/ajgon/checky?branch=master)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![license](https://img.shields.io/github/license/ajgon/checky.svg?maxAge=2592000)](https://github.com/ajgon/checky/blob/master/LICENSE)

Dependencies checker for CLI tools.

## Installation

```
gem install checky
```

or include in your Gemfile:

```ruby
gem 'checky'
```

## Usage

Checky includes a simple DSL for various tasks. For example, to check for Docker
version 1.x:

```ruby
Checky.check do
  binary 'docker'
  version '~> 1.0'
  fail_hard
  verbose
end
```

The `binary` or `version` concepts are called validators. In order to pass the check,
all validators must return `true`.

## Validators

### binary

```ruby
binary '<command name as it is invoked>'
```

Checks for existence of the command. Returns `true` if found.

### version

```ruby
version '<version string>'
```

Checks if the version of the binary matches the give `<version string>`. Version
string follows [`Gem::Requirement`](http://ruby-doc.org/stdlib-2.3.1/libdoc/rubygems/rdoc/Gem/Requirement.html)
restriction operators schema. Returns `true` if version matches.

**WARNING!** By default, this validator invokes `command --version` and
`command -v` to check the versions. If this fails (for example, your command uses
different argument, or the version string is not easily parseable), you can pass
the block to the validator, and do the check by yourself. For example:

```ruby
Checky.check do
  binary 'openssl'
  version '>= 1.0.0' do
    ver = Checky.run("#{storage.binary} version").match(/OpenSSL ([0-9\.]+)/)[1]
    ver.satisfies_requirement?(storage.version)
  end
end
```

See [Passing blocks to validators](#passing-blocks-to-validators) for more details.

### fail\_hard

```ruby
fail_hard
```

Normally, checky returns `true`/`false` depending on result of the check. With
this flag in place, a `Checky::ValidationError` exception will be raised.

### verbose

```ruby
verbose
```

When enabled, prints all validation info to STDOUT (success) or STDERR (failure).
You can customize messages in other validator, with `.message(value)` method,
where value is the parameter provided to the "messaging" validator. If your
project uses `pastel` gem, the output status will be colorized.

## Passing blocks to validators

If you wish to overwrite validator behavior, you can always pass the block to it,
which will perform the check. For example, to force `binary` validator to always
pass (for whatever reason), do:

```ruby
Checky.check do
  binary 'missing' do
    true
  end
end
```

Block must return `true`/`false`. In addition, the `storage` method is available
in block, which contains all the parameters given to check, i.e.

```ruby
Checky.check do
  binary 'docker'
  version('~> 1.0.0') do
    puts storage.binary # => '/usr/bin/docker'
    puts storage.version # => '~> 1.0.0'
  end
end
```

## Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md)
for details.

## Author

Author: [Igor Rzegocki](https://www.rzegocki.pl/) ([@ajgon](https://github.com/ajgon))

## License

License: [MIT](LICENSE)
