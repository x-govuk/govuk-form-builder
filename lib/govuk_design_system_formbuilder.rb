require 'govuk_design_system_formbuilder/version'
require 'govuk_design_system_formbuilder/helper'
require 'govuk_design_system_formbuilder/base'
require 'govuk_design_system_formbuilder/elements/hint'
require 'govuk_design_system_formbuilder/elements/label'
require 'govuk_design_system_formbuilder/elements/error_message'
require 'govuk_design_system_formbuilder/containers/form_group'

module GOVUKDesignSystemFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :safe_concat, :capture, to: :@template

    include GOVUKDesignSystemFormBuilder::Inputs
  end
end
