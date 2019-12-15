require 'active_support/configurable'

require 'govuk_design_system_formbuilder/traits/collection_item'
require 'govuk_design_system_formbuilder/traits/conditional'
require 'govuk_design_system_formbuilder/traits/error'
require 'govuk_design_system_formbuilder/traits/hint'
require 'govuk_design_system_formbuilder/traits/label'
require 'govuk_design_system_formbuilder/traits/localisation'
require 'govuk_design_system_formbuilder/traits/supplemental'

require 'govuk_design_system_formbuilder/version'
require 'govuk_design_system_formbuilder/builder'
require 'govuk_design_system_formbuilder/base'

require 'govuk_design_system_formbuilder/elements/hint'
require 'govuk_design_system_formbuilder/elements/label'
require 'govuk_design_system_formbuilder/elements/date'
require 'govuk_design_system_formbuilder/elements/select'
require 'govuk_design_system_formbuilder/elements/submit'
require 'govuk_design_system_formbuilder/elements/text_area'
require 'govuk_design_system_formbuilder/elements/file'

require 'govuk_design_system_formbuilder/elements/inputs/base'
require 'govuk_design_system_formbuilder/elements/inputs/email'
require 'govuk_design_system_formbuilder/elements/inputs/number'
require 'govuk_design_system_formbuilder/elements/inputs/phone'
require 'govuk_design_system_formbuilder/elements/inputs/text'
require 'govuk_design_system_formbuilder/elements/inputs/url'

require 'govuk_design_system_formbuilder/elements/radios/collection'
require 'govuk_design_system_formbuilder/elements/radios/collection_radio_button'
require 'govuk_design_system_formbuilder/elements/radios/fieldset_radio_button'

require 'govuk_design_system_formbuilder/elements/check_boxes/collection'
require 'govuk_design_system_formbuilder/elements/check_boxes/collection_check_box'
require 'govuk_design_system_formbuilder/elements/check_boxes/fieldset_check_box'
require 'govuk_design_system_formbuilder/elements/check_boxes/label'
require 'govuk_design_system_formbuilder/elements/check_boxes/hint'

require 'govuk_design_system_formbuilder/elements/error_message'
require 'govuk_design_system_formbuilder/elements/error_summary'

require 'govuk_design_system_formbuilder/containers/check_boxes_fieldset'
require 'govuk_design_system_formbuilder/containers/form_group'
require 'govuk_design_system_formbuilder/containers/fieldset'
require 'govuk_design_system_formbuilder/containers/radios'
require 'govuk_design_system_formbuilder/containers/radio_buttons_fieldset'
require 'govuk_design_system_formbuilder/containers/check_boxes'
require 'govuk_design_system_formbuilder/containers/character_count'
require 'govuk_design_system_formbuilder/containers/supplemental'

module GOVUKDesignSystemFormBuilder
  include ActiveSupport::Configurable

  DEFAULTS = {
    default_legend_size: 'm',
    default_legend_tag: 'h1',
    default_submit_button_text: 'Continue',
    default_radio_divider_text: 'or',
    default_error_summary_title: 'There is a problem'
  }.freeze

  DEFAULTS.keys.each { |k| config_accessor(k) { DEFAULTS[k] } }

  class << self
    def configure
      yield(config)
    end

    # Resets each of the configurable values to its default, only really
    # intended for use by the tests
    def reset!
      configure do |c|
        DEFAULTS.each { |k, v| c.send("#{k}=", v) }
      end
    end
  end

  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :safe_concat, :capture, :link_to, :raw, to: :@template

    include GOVUKDesignSystemFormBuilder::Builder
  end

  # Disable Rails' div.field_with_error wrapper
  ActionView::Base.field_error_proc = ->(html_tag, _instance) { html_tag }
end
