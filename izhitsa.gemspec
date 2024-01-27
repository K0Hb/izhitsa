# frozen_string_literal: true

require_relative "lib/izhitsa/version"

Gem::Specification.new do |s|
  s.name = "izhitsa"
  s.version = Izhitsa::VERSION
  s.authors = ["Vyacheslav Konovalov"]
  s.email = ["Vyacheslav Konovalov"]
  s.homepage = "https://github.com/K0Hb/izhitsa"
  s.summary = "Example description"
  s.description = "Example description"

  s.metadata = {
    "bug_tracker_uri" => "https://github.com/K0Hb/izhitsa/issues",
    "changelog_uri" => "https://github.com/K0Hb/izhitsa/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/K0Hb/izhitsa",
    "homepage_uri" => "https://github.com/K0Hb/izhitsa",
    "source_code_uri" => "https://github.com/K0Hb/izhitsa"
  }

  s.license = "MIT"

  s.files = Dir.glob("lib/**/*") + Dir.glob("bin/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 2.7"

  s.add_development_dependency "bundler", ">= 1.15"
  s.add_development_dependency "rake", ">= 13.0"
  s.add_development_dependency "rspec", ">= 3.9"
end
