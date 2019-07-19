require 'govuk_design_system_formbuilder/version'
require 'govuk_design_system_formbuilder/builder'
require 'govuk_design_system_formbuilder/base'

require 'govuk_design_system_formbuilder/elements/hint'
require 'govuk_design_system_formbuilder/elements/label'
require 'govuk_design_system_formbuilder/elements/input'
require 'govuk_design_system_formbuilder/elements/date'
require 'govuk_design_system_formbuilder/elements/collection_radio_buttons'
require 'govuk_design_system_formbuilder/elements/radios/collection_radio_button'
require 'govuk_design_system_formbuilder/elements/radios/fieldset_radio_button'
require 'govuk_design_system_formbuilder/elements/check_boxes/collection_check_box'
require 'govuk_design_system_formbuilder/elements/check_boxes/label'
require 'govuk_design_system_formbuilder/elements/check_boxes/hint'
require 'govuk_design_system_formbuilder/elements/error_message'
require 'govuk_design_system_formbuilder/elements/error_summary'
require 'govuk_design_system_formbuilder/elements/select'
require 'govuk_design_system_formbuilder/elements/submit'
require 'govuk_design_system_formbuilder/elements/text_area'
require 'govuk_design_system_formbuilder/elements/file'

require 'govuk_design_system_formbuilder/containers/form_group'
require 'govuk_design_system_formbuilder/containers/fieldset'
require 'govuk_design_system_formbuilder/containers/radios'
require 'govuk_design_system_formbuilder/containers/check_boxes'
require 'govuk_design_system_formbuilder/containers/character_count'

module GOVUKDesignSystemFormBuilder
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :safe_concat, :capture, :link_to, to: :@template

    include GOVUKDesignSystemFormBuilder::Builder
  end

  # Disable Rails' div.field_with_error wrapper
  ActionView::Base.field_error_proc = Proc.new do |html_tag, _instance|
    html_tag.html_safe
  end
end
