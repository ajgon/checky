# checky.gem

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

Checky includes a simple DSL for various tasks, for example, to check for Docker
version 1.x

```ruby
Checky.check do
  binary 'docker'
  version '~> 1.0'
  fail_hard
end
```

The `binary` or `version` concepts are call validators. In order to pass the check,
all validators must return `true`.

## Validators

### binary

```ruby
binary '<command name as it is invoked>'
```

Checks for existence of the command. Returns `true` if found.

```ruby
version '<version string>'
```

Checks if the version of the binary matches the give `<version string>`. Version
string follows [`Gem::Requirement`](http://ruby-doc.org/stdlib-2.3.1/libdoc/rubygems/rdoc/Gem/Requirement.html)
restriction operators schema. Returns true if version matches.

### fail\_hard

```ruby
fail_hard
```

Normally, checky returns `true`/`false` depending on result of the check. With
this flag in place, a `Checky::ValidationError` exception will be raised.

