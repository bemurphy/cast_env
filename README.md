# CastEnv

CastEnv can retrieve and cast basic types from your ENV for you.

Currently it handles Integers, Booleans and Strings.

Strings are the implied type for values in ENV, but they are
available here to provide a consistent interface if you choose
to use it.

## Installation

Add this line to your application's Gemfile:

    gem 'cast_env'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cast_env

## Usage

Configure the type you'd like CastEnv to cast a given ENV
value for you to.  Booleans are considered true if the original
ENV value is the string 'true' or 'TRUE', otherwise they are false.

```ruby
CastEnv.casts :spam_checks_enabled, :Boolean
CastEnv.casts :max_projects, :Integer
```

Fetch those values:

```ruby
ENV['SPAM_CHECKS_ENABLED'] = 'true'
CastEnv[:spam_checks_enabled] # => true
CastEnv[:spam_checks_enabled].class # => TrueClass

ENV['MAX_PROJECTS'] = '42'
CastEnv[:max_projects] # => 42
CastEnv[:max_projects].class # => Fixnum
```

Note that if you try and grab a value that doesn't exist, you'll get
a `KeyError` exception.  Since we are casting data, it makes better sense
to throw an exception than assume a potentially harmful value like `''` getting
converted to 0.  Better to fail fast than fail weird here.


## Contributing

1. Fork it ( http://github.com/bemurphy/cast_env/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
