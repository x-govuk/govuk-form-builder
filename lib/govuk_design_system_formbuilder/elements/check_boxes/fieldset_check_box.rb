module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class FieldsetCheckBox < Base
        using PrefixableArray

        include Traits::Label
        include Traits::Hint
        include Traits::Conditional

        def initialize(builder, object_name, attribute_name, value, label:, hint_text:, link_errors:, multiple:, &block)
          super(builder, object_name, attribute_name)

          @value       = value
          @label       = label
          @hint_text   = hint_text
          @multiple    = multiple
          @link_errors = link_errors

          if block_given?
            @conditional_content = wrap_conditional(block)
            @conditional_id      = conditional_id
          end
        end

        def html
          safe_join([check_box, @conditional_content])
        end

      private

        def check_box
          content_tag('div', class: %(#{brand}-checkboxes__item)) do
            safe_join([input, label_element, hint_element])
          end
        end

        def input
          @builder.check_box(@attribute_name, input_options, @value, false)
        end

        def input_options
          {
            id: field_id(link_errors: @link_errors),
            class: check_box_classes,
            multiple: @multiple,
            aria: { describedby: hint_id },
            data: { 'aria-controls' => @conditional_id }
          }
        end

        def label_element
          @label_element ||= Elements::Label.new(@builder, @object_name, @attribute_name, **label_content, **label_options)
        end

        def hint_element
          @hint_element ||= Elements::Hint.new(@builder, @object_name, @attribute_name, @hint_text, @value, checkbox: true)
        end

        def conditional_classes
          %w(checkboxes__conditional checkboxes__conditional--hidden).prefix(brand)
        end

        def check_box_classes
          %w(checkboxes__input).prefix(brand)
        end
      end
    end
  end
end
