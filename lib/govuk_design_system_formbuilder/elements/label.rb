module GOVUKDesignSystemFormBuilder
  module Elements
    class Label < GOVUKDesignSystemFormBuilder::Base
      def initialize(builder, object_name, attribute_name, text: nil, value: nil, size: nil, radio: false, checkbox: false, tag: nil)
        super(builder, object_name, attribute_name)

        @text           = label_text(text)
        @value          = value # used by field_id
        @size_class     = label_size_class(size)
        @radio_class    = radio_class(radio)
        @checkbox_class = checkbox_class(checkbox)
        @tag            = tag
      end

      def html
        return nil if @text.blank?

        if @tag.present?
          @builder.content_tag(@tag, class: 'govuk-label-wrapper') { build_label }
        else
          build_label
        end
      end

    private

      def build_label
        @builder.label(
          @attribute_name,
          @text,
          value: @value,
          for: field_id(link_errors: true),
          class: %w(govuk-label).push(@size_class, @weight_class, @radio_class, @checkbox_class).compact
        )
      end

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
          fail "invalid size '#{size}', must be xl, l, m, s or nil"
        end
      end
    end
  end
end
