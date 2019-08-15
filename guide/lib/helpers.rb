require 'pry'
require 'action_view'
require 'active_model'
require 'htmlbeautifier'
Dir.glob(File.join('./lib', '**', '*.rb')).each { |f| require f }

$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))
require 'govuk_design_system_formbuilder'

use_helper Nanoc::Helpers::Rendering
use_helper Nanoc::Helpers::LinkTo
use_helper BuilderExamples
use_helper Formatters
use_helper TextHelpers
use_helper Examples::TextInput
use_helper Examples::Select
use_helper Examples::Radios

class TestHelper < ActionView::Base; end
