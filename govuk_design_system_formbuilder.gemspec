$LOAD_PATH.push File.expand_path('lib', __dir__)

require "govuk_design_system_formbuilder/version"
require_relative "util/version_formatter"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/DFE-Digital/govuk-formbuilder/issues",
  "changelog_uri"     => "https://github.com/DFE-Digital/govuk-formbuilder/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder",
  "homepage_uri"      => "https://govuk-form-builder.netlify.app",
  "source_code_uri"   => "https://github.com/DFE-Digital/govuk-formbuilder",
  "github_repo"       => "https://github.com/DFE-Digital/govuk-formbuilder"
}.freeze

Gem::Specification.new do |s|
  s.name        = "govuk_design_system_formbuilder"
  s.version     = GOVUKDesignSystemFormBuilder::VERSION
  s.authors     = ["Peter Yates"]
  s.email       = ["peter.yates@graphia.co.uk"]
  s.homepage    = "https://govuk-form-builder.netlify.app"
  s.summary     = "GOV.UK-compliant Rails form builder"
  s.description = "A Rails form builder that generates form inputs adhering to the GOV.UK Design System"
  s.license     = "MIT"
  s.metadata    = METADATA
  s.files       = Dir["{app,lib}/**/*", "LICENSE", "README.md"]

  s.add_dependency("html-attributes-utils", "~> 1")

  exact_rails_version = ENV.key?("RAILS_VERSION")
  rails_version = ENV.fetch("RAILS_VERSION") { "6.1.7" }

  %w(actionview activemodel activesupport).each do |lib|
    s.add_dependency(*VersionFormatter.new(lib, rails_version, exact_rails_version).to_a)
  end

  s.add_development_dependency("pry", "~> 0.14.1")
  s.add_development_dependency("pry-byebug", "~> 3.9", ">= 3.9.0")
  s.add_development_dependency("rspec-html-matchers", "~> 0")
  s.add_development_dependency("rspec-rails", "~> 6.0")
  s.add_development_dependency("rubocop-govuk", "~> 4.10.0")
  s.add_development_dependency("simplecov", "~> 0.20")

  # Required for the guide
  s.add_development_dependency("htmlbeautifier", "~> 1.4.1")
  s.add_development_dependency("nanoc", "~> 4.12.15")
  s.add_development_dependency("rouge", "~> 4.0.0")
  s.add_development_dependency("rubypants", "~> 0.7.0")
  s.add_development_dependency("sass")
  s.add_development_dependency("sassc", "~> 2.4.0")
  s.add_development_dependency("slim", "~> 4.1.0")
  s.add_development_dependency("slim_lint", "~> 0.24.0")
  s.add_development_dependency("webrick", "~> 1.8.1")
end
