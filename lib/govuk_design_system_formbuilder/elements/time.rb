module GOVUKDesignSystemFormBuilder
  module Elements
    class Time < Base
      using PrefixableArray

      include Traits::Error
      include Traits::Hint
      include Traits::Supplemental
      include Traits::HTMLClasses
      include Traits::Localisation
      include Traits::DateInput
      include Traits::ContentBeforeAndAfter

      def initialize(builder, object_name, attribute_name, legend:, caption:, hint:, omit_second:, maxlength_enabled:, segments:, form_group:, before_inputs:, after_inputs:, segment_names:, **kwargs, &block)
        super(builder, object_name, attribute_name, &block)

        @legend            = legend
        @caption           = caption
        @hint              = hint
        @omit_second       = omit_second
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
        [hour, minute, second]
      end

      def omit_second?
        @omit_second
      end

      def hour
        date_part(:hour, width: 2, link_errors: true)
      end

      def minute
        date_part(:minute, width: 2)
      end

      def second
        if omit_second?
          return tag.input(
            id: id(:second, false),
            name: name(:second),
            type: 'hidden',
            value: value(:second) || 0,
          )
        end

        date_part(:second, width: 2)
      end

      def autocomplete_value(_segment)
        nil
      end
    end
  end
end
