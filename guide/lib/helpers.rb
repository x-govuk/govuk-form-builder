require 'pry'
require 'action_view'
require 'active_model'
require 'htmlbeautifier'
#require 'nokogiri'

$LOAD_PATH.unshift(File.expand_path("../../lib", "lib"))
require 'govuk_design_system_formbuilder'

use_helper Nanoc::Helpers::Rendering
use_helper BuilderExamples
use_helper Formatters
use_helper Examples::TextInput
