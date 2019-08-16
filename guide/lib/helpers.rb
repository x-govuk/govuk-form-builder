require 'pry'
require 'action_view'
require 'active_model'
require 'htmlbeautifier'
Dir.glob(File.join('./lib', '**', '*.rb')).each { |f| require f }

$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))
require 'govuk_design_system_formbuilder'

use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo
use_helper Helpers::Formatters
use_helper Helpers::TextHelpers
use_helper Examples::TextInput
use_helper Examples::Select
use_helper Examples::Radios
use_helper Setup::FormBuilderObjects
use_helper Setup::ExampleData

class TestHelper < ActionView::Base; end
