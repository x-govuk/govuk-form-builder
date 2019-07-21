module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class FieldsetCheckBox < GOVUKDesignSystemFormBuilder::Base
        def initialize(builder, object_name, attribute_name, value, label:, hint_text:, link_errors:, &block)
          super(builder, object_name, attribute_name)

          @value = value
          @label = label
          @hint_text  = hint_text

          if block_given?
            @conditional_content = wrap_conditional(block)
            @conditional_id      = conditional_id
          end
        end

        def html
          @builder.content_tag('div', class: 'govuk-checkboxes__item') do
            @builder.safe_join([input, label, hint, @conditional_content])
          end
        end

      private

        def input
          @builder.check_box(
            @attribute_name,
            {
              id: field_id(link_errors: @link_errors),
              class: check_box_classes,
              aria: { describedby: hint_id },
              data: { 'aria-controls' => @conditional_id }
            },
            @value
          )
        end

        def label
          Elements::Label.new(
            @builder,
            @object_name,
            @attribute_name,
            value: @value,
            checkbox: true,
            **@label,
          ).html
        end

        def hint
          Elements::Hint.new(
            @builder,
            @object_name,
            @attribute_name,
            @hint_text,
            @value,
            checkbox: true
          ).html
        end

        def process(block)
          return content = block.call, (content && conditional_id)
        end

        def conditional_classes
          %w(govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden)
        end

        def check_box_classes
          %w(govuk-checkboxes__input)
        end

        def check_box_hint_classes
          %w(govuk-hint govuk-checkboxes__hint)
        end
      end
    end
  end
end
