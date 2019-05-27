require 'govuk_design_system_formbuilder/version'
require 'govuk_design_system_formbuilder/labels'
require 'govuk_design_system_formbuilder/inputs'
require 'govuk_design_system_formbuilder/helpers'

module GOVUKDesignSystemFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :safe_concat, :capture, to: :@template

    include GOVUKDesignSystemFormBuilder::Labels
    include GOVUKDesignSystemFormBuilder::Inputs
    include GOVUKDesignSystemFormBuilder::Helpers
  end
end
