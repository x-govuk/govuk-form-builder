module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadioButton < Base
        include Traits::Hint
        include Traits::Conditional

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
          safe_join(
            [
              content_tag('div', class: 'govuk-radios__item') do
                safe_join(
                  [
                    input,
                    label_element.html,
                    hint_element.html,
                  ]
                )
              end,
              @conditional_content
            ]
          )
        end

      private

        def label_element
          @label_element ||= Elements::Label.new(@builder, @object_name, @attribute_name, radio: true, value: @value, **@label, link_errors: @link_errors)
        end

        def hint_element
          @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text, radio: true)
        end

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
