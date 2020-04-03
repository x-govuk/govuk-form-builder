$:.push File.expand_path('lib', __dir__)

require "govuk_design_system_formbuilder/version"
require_relative "util/version_formatter"

METADATA = {
  "bug_tracker_uri"   => "https://github.com/DFE-Digital/govuk_design_system_formbuilder/issues",
  "changelog_uri"     => "https://github.com/DFE-Digital/govuk_design_system_formbuilder/releases",
  "documentation_uri" => "https://www.rubydoc.info/gems/govuk_design_system_formbuilder/GOVUKDesignSystemFormBuilder/Builder",
  "homepage_uri"      => "https://govuk-form-builder.netlify.app",
  "source_code_uri"   => "https://github.com/DFE-Digital/govuk_design_system_formbuilder"
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
  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "README.md"]

  exact_rails_version = ENV.has_key?("RAILS_VERSION")
  rails_version = ENV.fetch("RAILS_VERSION") { "5.2.3" }

  %w(actionview activemodel activesupport).each do |lib|
    s.add_dependency(*VersionFormatter.new(lib, rails_version, exact_rails_version).to_a)
  end

  s.add_development_dependency("rubocop-govuk", "~> 3")
  s.add_development_dependency("pry", "~> 0.13.0")
  s.add_development_dependency("pry-byebug", "~> 3.9", ">= 3.9.0")
  s.add_development_dependency("rspec-html-matchers", "~> 0")
  s.add_development_dependency("rspec-rails", "~> 4.0")
  s.add_development_dependency("simplecov", "~> 0")

  # Required for the guide
  s.add_development_dependency("adsf", "~> 1.4.2")
  s.add_development_dependency("adsf-live", "~> 1.4.2")
  s.add_development_dependency("htmlbeautifier", "~> 1.3.1")
  s.add_development_dependency("nanoc", "~> 4.11")
  s.add_development_dependency("rouge", "~> 3.17.0")
  s.add_development_dependency("rubypants", "~> 0.7.0")
  s.add_development_dependency("sassc", "~> 2.2.1")
  s.add_development_dependency("sass")
  s.add_development_dependency("slim", "~> 4.0.1")
end
