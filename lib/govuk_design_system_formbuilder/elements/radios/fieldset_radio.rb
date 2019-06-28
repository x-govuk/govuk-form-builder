module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadio < Base
        def initialize(builder, object_name, attribute_name, value, label:, hint_text:, &block)
          super(builder, object_name, attribute_name)
          @value = value
          @label = label
          @hint_text  = hint_text
          @conditional_content, @conditional_id = wrap_conditional(block) if block_given?
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
            id: attribute_descriptor,
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
