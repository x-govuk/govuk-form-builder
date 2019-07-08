module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, text: nil, value: nil, size: nil, radio: false, checkbox: false)
        super(builder, object_name, attribute_name)

        @text           = label_text(text)
        @value          = value # used by attribute_descriptor
        @size_class     = label_size_class(size)
        @radio_class    = radio_class(radio)
        @checkbox_class = checkbox_class(checkbox)
      end

      def html
        return nil unless @text.present?

        @builder.label(
          @attribute_name,
          @text,
          value: @value,
          class: %w(govuk-label).push(@size_class, @weight_class, @radio_class, @checkbox_class).compact
        )
      end

    private

      def label_text(option_text)
        [option_text, @value, @attribute_name.capitalize].compact.first
      end

      def radio_class(radio)
        radio ? 'govuk-radios__label' : nil
      end

      def checkbox_class(checkbox)
        checkbox ? 'govuk-checkboxes__label' : nil
      end

      def label_size_class(size)
        case size
        when 'xl'      then "govuk-label--xl"
        when 'l'       then "govuk-label--l"
        when 'm'       then "govuk-label--m"
        when 's'       then "govuk-label--s"
        when nil       then nil
        else
          fail "size must be either 'xl', 'l', 'm', 's' or nil"
        end
      end
    end
  end
end
