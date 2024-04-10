require 'active_support/configurable'
require 'html_attributes_utils'

[%w(presenters *.rb), %w(refinements *.rb), %w(traits *.rb), %w(*.rb), %w(elements ** *.rb), %w(containers ** *.rb)]
  .flat_map { |matcher| Dir.glob(File.join(__dir__, 'govuk_design_system_formbuilder', *matcher)) }
  .each { |file| require file }

module GOVUKDesignSystemFormBuilder
  include ActiveSupport::Configurable

  # @!group Defaults

  # Default form builder configuration
  #
  # * +:brand+ sets the value used to prefix all classes, used to allow the
  #   builder to be branded for alternative (similar) design systems.
  #
  # * +:default_caption_size+ controls the default size of caption text.
  #   Can be either +xl+, +l+ or +m+.
  #
  # * +:default_legend_size+ controls the default size of legend text.
  #   Can be either +xl+, +l+, +m+ or +s+.
  #
  # * +:default_legend_tag+ controls the default tag that legends are
  #   wrapped in. Defaults to +nil+.
  #
  # * +:default_submit_button_text+ sets the value assigned to +govuk_submit+,
  #   defaults to 'Continue'.
  #
  # * +:default_date_segments+ allows the date segments used by Rails'
  #   multiparameter attributes to be configured. This is useful if you want to
  #   override the standard behaviour where Rails tries to cast the values
  #   into a +Date+. Defaults to +{ day: '3i', month: '2i', year: '1i' }+
  #
  # * +:default_radio_divider_text+ sets the text automatically added to the
  #   radio button divider, defaults to 'or'
  #
  # * +:default_check_box_divider_text+ sets the text automatically added to the
  #   checkbox divider, defaults to 'or'
  #
  # * +:default_collection_check_boxes_include_hidden+ controls whether or not
  #   a hidden field is added when rendering a collection of check boxes
  #
  # * +:default_collection_radio_buttons_include_hidden+ controls whether or not
  #   a hidden field is added when rendering a collection of radio buttons
  #
  # * +:default_collection_radio_buttons_auto_bold_labels+ will automatically
  #   make labels on {#govuk_collection_radio_buttons} bold when a +:hint_method+
  #   is present. The default can be overridden using the +bold_labels:+ argument.
  #   The default value is 'true'.
  #
  # * +:default_error_summary_title+ sets the text used in error summary
  #   blocks. As per the GOV.UK Design System spec, it defaults to
  #   'There is a problem'.
  #
  # * +:default_error_summary_presenter+ the class that's instantiated when
  #   rendering an error summary and formats the messages for each attribute
  #
  # * +:default_error_summary_error_order_method+ is the method that the library
  #   will check for on the bound object to see whether or not to try ordering the
  #   error messages
  #
  # * +:default_error_summary_turbo_prefix+ is used to disable turbo/turbolinks from
  #   handling clicks on links in the error summary. When it's a string (eg,
  #   turbo), that will result in links with the attribute 'data-turbo=false'.
  #   When nil, no data attribute will be added. Defaults to turbo since Rails 7,
  #   change to 'turbolinks' for Rails 6.1
  #
  # * +:localisation_schema_fallback+ sets the prefix elements for the array
  #   used to build the localisation string. The final two elements are always
  #   are the object name and attribute name. The _special_ value +__context__+,
  #   is used as a placeholder for the context (label, fieldset or hint).
  #
  # * +:localisation_schema_legend+, +:localisation_schema_hint+ and
  #   +:localisation_schema_label+ each override the schema root for their
  #   particular context, allowing them to be independently customised.
  #
  # * +:enable_logger+ controls whether or not the library will emit log
  #   messages via Rails.logger.warn, defaults to +true+
  #
  # * +:trust_error_messages+ call html_safe on error messages before they're
  #   rendered. This allows formatting markup to be used to change the display
  #   of the error message. Defaults to +false+
  #
  # * +:enable_nested_localisation+ scan the object name before building the
  #   localisation schema path to see if it's nested or not. The old behaviour
  #   can be restored by setting this option to +false+. Defaults to +true+
  # ===
  DEFAULTS = {
    brand: 'govuk',

    default_legend_size: 'm',
    default_legend_tag: nil,
    default_caption_size: 'm',
    default_submit_button_text: 'Continue',
    default_date_segments: { day: '3i', month: '2i', year: '1i' },
    default_radio_divider_text: 'or',
    default_check_box_divider_text: 'or',
    default_error_summary_title: 'There is a problem',
    default_error_summary_presenter: Presenters::ErrorSummaryPresenter,
    default_error_summary_error_order_method: nil,
    default_error_summary_turbo_prefix: 'turbo',
    default_collection_check_boxes_include_hidden: true,
    default_collection_radio_buttons_include_hidden: true,
    default_collection_radio_buttons_auto_bold_labels: true,
    default_submit_validate: false,
    default_show_password_text: "Show",
    default_hide_password_text: "Hide",
    default_show_password_aria_label_text: "Show password",
    default_hide_password_aria_label_text: "Hide password",
    default_password_shown_announcement_text: "Your password is visible",
    default_password_hidden_announcement_text: "Your password is hidden",
    localisation_schema_fallback: %i(helpers __context__),
    localisation_schema_label: nil,
    localisation_schema_hint: nil,
    localisation_schema_legend: nil,
    localisation_schema_caption: nil,

    enable_logger: true,
    trust_error_messages: false,

    # temporarily allow the new nested localisation functionality to be
    # disabled
    enable_nested_localisation: true,
  }.freeze

  DEFAULTS.each_key { |k| config_accessor(k) { DEFAULTS[k] } }
  # @!endgroup

  class << self
    # Configure the form builder in the usual manner. All of the
    # keys in {DEFAULTS} can be configured as per the example below
    #
    # @example
    #   GOVUKDesignSystemFormBuilder.configure do |conf|
    #     conf.default_legend_size = 'xl'
    #     conf.default_error_summary_title = 'OMG'
    #   end
    def configure
      yield(config)
    end

    # Resets each of the configurable values to its default
    #
    # @note This method is only really intended for use to clean up
    #   during testing
    def reset!
      configure do |c|
        DEFAULTS.each { |k, v| c.send("#{k}=", v) }
      end
    end
  end

  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :safe_join, :link_to, :capture, to: :@template

    include GOVUKDesignSystemFormBuilder::Builder
  end

  class FormBuilderProxy < FormBuilder; end

  # Disable Rails' div.field_with_error wrapper
  ActionView::Base.field_error_proc = ->(html_tag, _instance) { html_tag }
end
