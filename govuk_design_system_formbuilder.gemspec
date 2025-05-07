$LOAD_PATH.push File.expand_path('lib', __dir__)

require "govuk_design_system_formbuilder/version"
require_relative "util/version_formatter"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/x-govuk/govuk-form-builder/issues",
  "changelog_uri"     => "https://github.com/x-govuk/govuk-form-builder/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder",
  "homepage_uri"      => "https://govuk-form-builder.netlify.app",
  "source_code_uri"   => "https://github.com/x-govuk/govuk-form-builder",
  "github_repo"       => "https://github.com/x-govuk/govuk-form-builder"
}.freeze

Gem::Specification.new do |s|
  s.name        = "govuk_design_system_formbuilder"
  s.version     = GOVUKDesignSystemFormBuilder::VERSION
  s.authors     = ["Peter Yates"]
  s.email       = ["peter.yates@graphia.co.uk"]
  s.homepage    = "https://govuk-form-builder.netlify.app"
  s.summary     = "GOV.UK Form Builder for Ryby on Rails"
  s.description = "This library provides view components for the GOV.UK Design System. It makes creating services more familiar for Ruby on Rails developers."
  s.license     = "MIT"
  s.metadata    = METADATA
  s.files       = Dir["{app,lib}/**/*", "LICENSE", "README.md"]

  s.add_dependency("html-attributes-utils", "~> 1")

  exact_rails_version = ENV.key?("RAILS_VERSION")
  rails_version = ENV.fetch("RAILS_VERSION") { "7.1.5" }

  %w(actionview activemodel activesupport).each do |lib|
    s.add_dependency(*VersionFormatter.new(lib, rails_version, exact_rails_version).to_a)
  end

  s.add_development_dependency('ostruct')
  s.add_development_dependency("pry", "~> 0.14.1")
  s.add_development_dependency("pry-byebug", "~> 3.9", ">= 3.9.0")
  s.add_development_dependency("rspec-html-matchers", "~> 0")
  s.add_development_dependency("rspec-rails", "~> 6.0")
  s.add_development_dependency("rubocop-govuk", "~> 5.0.1")
  s.add_development_dependency("simplecov", "~> 0.20")

  # Required for the guide
  s.add_development_dependency("htmlbeautifier", "~> 1.4.1")
  s.add_development_dependency("nanoc", "~> 4.13.0")
  s.add_development_dependency("rouge", "~> 4.5.1")
  s.add_development_dependency("rubypants", "~> 0.7.0")
  s.add_development_dependency("sass")
  s.add_development_dependency("sassc", "~> 2.4.0")
  s.add_development_dependency("slim", "~> 5.2.0")
  s.add_development_dependency("slim_lint", "~> 0.31.0")
  s.add_development_dependency("webrick", "~> 1.9.1")
  s.add_development_dependency("redcarpet", "~> 3.6.0")
end
