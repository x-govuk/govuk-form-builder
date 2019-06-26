module GOVUKDesignSystemFormBuilder
  module Elements
    module Radios
      class FieldsetRadio < Radio
        def initialize(builder, object_name, attribute_name, value, label:, hint:, &block)
          super(builder, object_name, attribute_name)
          @value = value
          @label = label
          @hint  = hint
          @conditional_content, @conditional_id = wrap_conditional(block) if block_given?
        end

        def html
          @builder.content_tag('div', class: 'govuk-radios__item') do
            @builder.safe_join(
              [
                input,
                Elements::Label.new(@builder, @object_name, @attribute_name, @label.merge(radio: true, value: @value)).html,
                Elements::Hint.new(@builder, @object_name, @attribute_name, id: hint_id, class: radio_hint_classes, text: @hint).html,
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

        def wrap_conditional(block)
          conditional = @builder.content_tag('div', class: conditional_classes, id: conditional_id) do
            @builder.capture { block.call }
          end
          return conditional, conditional_id
        end

        def conditional_classes
          %w(govuk-radios__conditional govuk-radios__conditional--hidden)
        end
      end
    end
  end
end
