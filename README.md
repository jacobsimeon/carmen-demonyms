# Carmen::Demonyms

Adds [demonyms][0] to [Carmen][1].

## Installation

Add this line to your application's Gemfile:

    gem 'carmen-demonyms'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carmen-demonyms

## Usage

```ruby
require 'carmen/demonyms'
Carmen::Country.coded("us").demonym # => "American"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[0]: http://en.wikipedia.org/wiki/Demonym 
[1]: https://github.com/jim/carmen


