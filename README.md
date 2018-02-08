# Decidim::Generators

[![asciicast](https://asciinema.org/a/9afrow4k095ksyuahpgjipfl4.png)](https://asciinema.org/a/9afrow4k095ksyuahpgjipfl4)

TODO: Add gem's description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decidim-generators'
```

And then execute:

```console
bundle
```

Or install it yourself as:

```console
gem install decidim-generators
```

## Usage

### Generate a new component

```console
decidim-generators engine my_component
```

### Generate a new component in a specific folder

You may do this when you want to point to an existing folder or give it a custom
name.

```console
decidim-generators engine my_component --destination_folder ../decidim-module-my_component
```

### Generate a new component with its own Gemfile

You may do this when your plugin is meant to live outside of decidim's core repo.

```
decidim-generators engine my_component --gemfile
```

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/codegram/decidim-generators). This project is
intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
