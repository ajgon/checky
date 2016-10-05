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
end
```
