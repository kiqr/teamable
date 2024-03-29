# frozen_string_literal: true

require_relative "lib/teamable/version"

Gem::Specification.new do |spec|
  spec.name = "teamable"
  spec.version = Teamable::VERSION
  spec.authors = ["Rasmus Kjellberg", "KIQR"]
  spec.email = "hello@kiqr.dev"
  spec.homepage = "https://github.com/kiqr/teamable"
  spec.summary = "Extension to enable teams for Authenticatable"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 3.2"

  spec.files = Dir["{app,lib,config}/**/*", "LICENSE.md", "README.md"]

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/kiqr/teamable/issues",
    "documentation_uri" => "https://github.com/kiqr/teamable/issues",
    "source_code_uri" => "https://github.com/kiqr/teamable",
    "rubygems_mfa_required" => "true"
  }

  spec.add_dependency "dry-configurable", "~> 1.1.0"
  spec.add_dependency "public_uid", "~> 2.2.0"
end
