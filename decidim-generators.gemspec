
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "decidim/generators/version"

Gem::Specification.new do |spec|
  spec.name = "decidim-generators"
  spec.version = Decidim::Generators::VERSION
  spec.authors = ["Decidim"]
  spec.email = ["info@decidim.org"]

  spec.summary = "Decidim generators"
  spec.description = "Decidim generators"
  spec.homepage = "https://github.com/decidim/decidim-generators"
  spec.license = "AGPL-3.0"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^spec/})
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 5.1"
  spec.add_dependency "decidim"
  spec.add_dependency "thor", "~> 0.19.4"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
