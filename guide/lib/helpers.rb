require 'rails'
require 'action_view'
require 'active_model'
require 'active_support/core_ext/string'
require 'htmlbeautifier'
require 'ostruct'
require 'slim/erb_converter'

Rails.logger = Logger.new($stdout)

Dir.glob(File.join('./lib', '**', '*.rb')).sort.each { |f| require f }

$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))
require 'govuk_design_system_formbuilder'

use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo
use_helper Nanoc::Helpers::XMLSitemap

use_helper Helpers::Formatters
use_helper Helpers::LinkHelpers
use_helper Helpers::RelatedInfo
use_helper Helpers::ServiceNavigationHelpers
use_helper Helpers::TitleAnchorHelpers
use_helper Helpers::HeaderHelper

use_helper Examples::TextInput
use_helper Examples::TextArea
use_helper Examples::Select
use_helper Examples::Radios
use_helper Examples::Checkboxes
use_helper Examples::SubmitButton
use_helper Examples::Date
use_helper Examples::LabelsCaptionsHintsAndLegends
use_helper Examples::File
use_helper Examples::ErrorHandling
use_helper Examples::InjectingContent
use_helper Examples::Localisation
use_helper Examples::Password

use_helper Setup::FormBuilderObjects
use_helper Setup::ExampleData

class TestHelper < ActionView::Base; end
