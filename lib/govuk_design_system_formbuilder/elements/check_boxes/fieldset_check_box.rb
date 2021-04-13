module GOVUKDesignSystemFormBuilder
  module Elements
    module CheckBoxes
      class FieldsetCheckBox < Base
        using PrefixableArray

        include Traits::Label
        include Traits::Hint
        include Traits::FieldsetItem
        include Traits::Conditional
        include Traits::HTMLAttributes

        def initialize(builder, object_name, attribute_name, value, unchecked_value, label:, hint:, link_errors:, multiple:, **kwargs, &block)
          super(builder, object_name, attribute_name)

          @value           = value
          @unchecked_value = unchecked_value
          @label           = label
          @hint            = hint
          @multiple        = multiple
          @link_errors     = link_errors
          @html_attributes = kwargs

          if block_given?
            @conditional_content = wrap_conditional(block)
            @conditional_id      = conditional_id
          end
        end

        def html
          safe_join([item, @conditional_content])
        end

      private

        def item
          tag.div(class: %(#{brand}-checkboxes__item)) do
            safe_join([check_box, label_element, hint_element])
          end
        end

        def check_box
          @builder.check_box(@attribute_name, attributes(@html_attributes), @value, @unchecked_value)
        end

        def options
          {
            id: field_id(link_errors: @link_errors),
            class: classes,
            multiple: @multiple,
            aria: { describedby: [hint_id] },
            data: { 'aria-controls' => @conditional_id }
          }
        end

        def classes
          %w(checkboxes__input).prefix(brand)
        end

        def fieldset_options
          { checkbox: true }
        end

        def conditional_classes
          %w(checkboxes__conditional checkboxes__conditional--hidden).prefix(brand)
        end
      end
    end
  end
end
