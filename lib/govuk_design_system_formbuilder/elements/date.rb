module GOVUKDesignSystemFormBuilder
  module Elements
    class Date < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Supplemental
      include Traits::HTMLClasses
      include Traits::Localisation
      include Traits::DateInput
      include Traits::ContentBeforeAndAfter

      MULTIPARAMETER_KEY = { day: 3, month: 2, year: 1 }.freeze

      def initialize(builder, object_name, attribute_name, legend:, caption:, hint:, omit_day:, maxlength_enabled:, segments:, form_group:, segment_names:, before_inputs:, after_inputs:, date_of_birth: false, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @legend            = legend
        @caption           = caption
        @hint              = hint
        @date_of_birth     = date_of_birth
        @omit_day          = omit_day
        @maxlength_enabled = maxlength_enabled
        @segments          = segments
        @segment_names     = segment_names
        @form_group        = form_group
        @html_attributes   = kwargs
        @before_input      = before_inputs
        @after_input       = after_inputs
      end

    private

      def parts
        [day, month, year]
      end

      def fieldset_options
        { legend: @legend, caption: @caption, described_by: [error_id, hint_id] }
      end

      def omit_day?
        @omit_day
      end

      def day
        if omit_day?
          return tag.input(
            id: id(:day, false),
            name: name(:day),
            type: 'hidden',
            value: value(:day) || 1,
          )
        end

        date_part(:day, width: 2, link_errors: true)
      end

      def month
        date_part(:month, width: 2, link_errors: omit_day?)
      end

      def year
        date_part(:year, width: 4)
      end

      def autocomplete_value(segment)
        return unless @date_of_birth

        { day: 'bday-day', month: 'bday-month', year: 'bday-year' }.fetch(segment)
      end
    end
  end
end
