require 'govuk_design_system_formbuilder/version'
require 'govuk_design_system_formbuilder/builder'
require 'govuk_design_system_formbuilder/base'
require 'govuk_design_system_formbuilder/elements/hint'
require 'govuk_design_system_formbuilder/elements/label'
require 'govuk_design_system_formbuilder/elements/input'
require 'govuk_design_system_formbuilder/elements/radio'
require 'govuk_design_system_formbuilder/elements/radio_button/collection_radio'
require 'govuk_design_system_formbuilder/elements/radio_button/fieldset_radio'
require 'govuk_design_system_formbuilder/elements/check_box/collection_check_box'
require 'govuk_design_system_formbuilder/elements/check_box/fieldset_check_box'
require 'govuk_design_system_formbuilder/elements/check_box/label'
require 'govuk_design_system_formbuilder/elements/check_box/hint'
require 'govuk_design_system_formbuilder/elements/error_message'
require 'govuk_design_system_formbuilder/containers/form_group'
require 'govuk_design_system_formbuilder/containers/fieldset'
require 'govuk_design_system_formbuilder/containers/radios'
require 'govuk_design_system_formbuilder/containers/check_boxes'

module GOVUKDesignSystemFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :safe_concat, :capture, to: :@template

    include GOVUKDesignSystemFormBuilder::Builder
  end
end
