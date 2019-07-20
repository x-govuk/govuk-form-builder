module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadioButton < Base
        def initialize(builder, object_name, attribute_name, value, label:, hint_text:, link_errors:, &block)
          super(builder, object_name, attribute_name)

          @value       = value
          @label       = label
          @hint_text   = hint_text
          @link_errors = has_errors? && link_errors

          if block_given?
            @conditional_content = wrap_conditional(block)
            @conditional_id      = conditional_id
          end
        end

        def html
          @builder.content_tag('div', class: 'govuk-radios__item') do
            @builder.safe_join(
              [
                input,
                Elements::Label.new(@builder, @object_name, @attribute_name, radio: true, value: @value, **@label).html,
                Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text, radio: true).html,
                @conditional_content
              ]
            )
          end
        end

      private

        def input
          @builder.radio_button(
            @attribute_name,
            @value,
            id: field_id(link_errors: @link_errors),
            aria: { describedby: hint_id },
            data: { 'aria-controls' => @conditional_id },
            class: %w(govuk-radios__input)
          )
        end

        def conditional_classes
          %w(govuk-radios__conditional govuk-radios__conditional--hidden)
        end
      end
    end
  end
end
