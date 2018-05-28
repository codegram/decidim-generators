Note: ***THIS REPO IS OUTDATED**. Please use https://github.com/decidim/decidim/tree/master/decidim-generators instead.

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

This repo helps you generating the scheleton of a decidim plugin. It will
generate a folder with a plugin's code skeleton that you then need to properly
require in your final decidim application in order to use it. To do that, you
need to include the plugin in your application's `Gemfile`.

For example, if you generated your plugin at
`~/decidim-generators/decidim-module-experimental_plugin`, you'll need to edit
your `Gemfile` like this in order for the plugin to be used:

```ruby
gem "decidim-experimental_plugin", path: "~/decidim-generators/decidim-module-experimental_plugin"
```

Once you do that, and boot your application, you'll see the new component being
offered in the "New component" selector on the "Components" section of any
participatory space in the admin dashboard.

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

### Generate a new component as a external plugin

You may do this when your plugin is meant to live outside of decidim's core
repo. The generated application has some particularities as opposed to a plugin
living in the core repo. For example:

* It has its own Gemfile.
* The dummy application path is different.

```
decidim-generators engine my_component --external
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
