# frozen_string_literal: true

require_relative "lib/eyepiece/version"

Gem::Specification.new do |spec|
  spec.name = "eyepiece"
  spec.version = Eyepiece::VERSION
  spec.authors = ["John Doe"]
  spec.email = ["test@example.com"]

  spec.summary = "QuickSearch and QuickBriefScope for ActiveRecord models"
  spec.description = "Provides parameterized modules for fast ILIKE searching and brief scope selection on ActiveRecord models."
  spec.homepage = "https://github.com/example/eyepiece"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  gemspec = File.basename(__FILE__)
  spec.files = Dir.glob("{lib,sig,exe}/**/*", base: __dir__).reject do |f|
    (f == gemspec) ||
      f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/])
  end
  spec.files += %w[CHANGELOG.md]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
